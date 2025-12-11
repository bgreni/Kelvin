from kelvin import *
from math import exp

# Define Derived Units
comptime Newton = Quantity[
    (Kilogram.D * Meter.D) / (Second.D**2),
    *_,
]
comptime Pascal = Quantity[
    Newton.D / (Meter.D**2),
    *_,
]
comptime Density = Quantity[
    Kilogram.D / (Meter.D**3),
    *_,
]

# Physical Constants
# Gravity at sea level
comptime g0 = gravity
# Air density at sea level
comptime rho_sea_level = Density(1.225)
# Scale height for Earth's atmosphere
comptime scale_height = Meter(8500)


comptime DT = DType.float64


struct Rocket:
    var mass: Kilogram[DT]
    var fuel_mass: Kilogram[DT]
    var drag_coefficient: Float64
    var area: MetersSquared[DT]
    var thrust: Newton[DT]
    var isp: Second[DT]  # Specific Impulse

    fn __init__(
        out self,
        dry_mass: Kilogram[DT],
        fuel_mass: Kilogram[DT],
        drag_coefficient: Float64,
        area: MetersSquared[DT],
        thrust: Newton[DT],
        isp: Second[DT],
    ):
        self.mass = dry_mass + fuel_mass
        self.fuel_mass = fuel_mass
        self.drag_coefficient = drag_coefficient
        self.area = area
        self.thrust = thrust
        self.isp = isp

    fn total_mass(self) -> Kilogram[DT]:
        return self.mass

    fn burn_fuel(mut self, dt: Second[DT]) -> Kilogram[DT]:
        # Mass flow rate = Thrust / (Isp * g0)
        # Note: g0 here is typically just a conversion factor 9.80665 m/s^2,
        # but dimensionally it matches acceleration.
        # We need to cast g0 to match the rocket's data type
        var g = MetersPerSecondSquared[DT](g0.value().cast[DT]())
        var m_dot = self.thrust / (self.isp * g)
        var burned = m_dot * dt

        if burned > self.fuel_mass:
            burned = self.fuel_mass

        self.fuel_mass -= burned
        self.mass -= burned
        return burned


fn atmosphere_density(altitude: Meter[DT]) -> Density[DT]:
    # Simple exponential atmosphere model
    # rho = rho0 * exp(-h / H)
    if altitude < Meter(0.0):
        return rho_sea_level

    # We need to extract scalars to use exp() since it doesn't support Quantities directly yet
    # or rather, exp(Meter) doesn't make sense, we need exp(Scalar).
    # dividing two Lengths gives a scalar Quantity (dimensionless).
    # Then we call .value() to get the underlying primitives.
    var ratio = altitude / scale_height
    # The result of division is a dimensionless Quantity, we need to extract the raw value to pass to math.exp
    var scalar_ratio = ratio.value()
    return rho_sea_level * exp(-scalar_ratio)


fn main():
    print("Initializing Rocket Simulation...")

    # Setup Rocket
    # A generic small rocket
    var rocket = Rocket(
        dry_mass=Kilogram(100),
        fuel_mass=Kilogram(900),
        drag_coefficient=0.75,
        area=MetersSquared(0.5),  # approx 0.8m diameter
        thrust=Newton(20000),  # ~20 kN
        isp=Second(250),
    )

    # Initial Conditions
    var altitude = Meter(0)
    var velocity = MetersPerSecond(0)
    var time = Second(0)

    # Simulation Parameters
    var dt = Second(0.1)
    var max_time = Second(200)

    print(" T (s) |  Alt (m)  |  Vel (m/s) |  Acc (m/s^2) | Mass (kg)")
    print("-----------------------------------------------------------")

    while time < max_time and altitude >= Meter(0):
        # 1. Update Environment
        var rho = atmosphere_density(altitude)

        # 2. Calculate Forces
        # Gravity: Fg = m * g
        var F_gravity = rocket.total_mass() * g0

        # Drag: Fd = 0.5 * rho * v^2 * Cd * A
        # Note: direction opposes velocity.
        # squaring velocity gives m^2/s^2.
        # Density * m^2/s^2 * m^2 -> (kg/m^3) * (m^4/s^2) -> kg*m/s^2 -> Newton. Correct.
        var drag_mag = (
            0.5 * rho * (velocity**2) * rocket.area * rocket.drag_coefficient
        )

        # Direction handling roughly
        var F_drag = drag_mag
        if velocity < MetersPerSecond(0):
            # basic sign handling for 1D - drag always opposes motion
            F_drag = -drag_mag

        # Thrust
        var F_thrust = Newton(0)
        if rocket.fuel_mass > Kilogram(0):
            F_thrust = rocket.thrust

        # Net Force
        # Up is positive. Gravity is down. Drag opposes velocity (assumed up for now).
        var F_net = F_thrust - F_gravity - F_drag

        # 3. Acceleration: F = ma -> a = F/m
        var acceleration = F_net / rocket.total_mass()

        # 4. Integration (Euler method)
        velocity += acceleration * dt
        altitude += velocity * dt

        # 5. Mass Update
        _ = rocket.burn_fuel(dt)

        # Update time
        time += dt

        # Print stats every second
        # Using mod via int casting for checking print interval
        var t_int = Int(time.value() * 10)
        if t_int % 10 == 0:
            print(
                time,
                "|",
                round(altitude),
                "|",
                round(velocity),
                "|",
                round(acceleration, 2),
                "|",
                round(rocket.total_mass()),
            )

        # Stop if we crash back to ground after launch
        if time > Second(5) and altitude <= Meter(0):
            print("Impact!")
            break

    print("Simulation Complete.")
