"""An idea for a generic trait system for units of measurements.

This is going to evolve a lot over time and be broken while we wait for better
mojo language features.

The current goal is to achieve dimensional analysis at compile time.
"""

from collections.string import StaticString
from kelvin.ratio import Ratio


trait BaseUnit[suffix: StaticString, exponent: UInt]:
    ...


struct ComposedUnit[
    Numerator: VariadicPack[element_trait=BaseUnit, *_, **_],
    Denominator: VariadicPack[element_trait=BaseUnit, *_, **_],
]:
    # TODO: multiplication and simplification of base units
    ...


trait UnitOfMeasurement[
    Unit: ComposedUnit, Magnitude: Ratio, D: DType = DType.float64
]:
    var coefficient: Scalar[D]

    fn __init__(out self, value: Scalar[D] = Scalar[D](1)):
        ...


trait Time(BaseUnit, UnitOfMeasurement):
    ...


trait Length(BaseUnit, UnitOfMeasurement):
    ...


trait Mass(BaseUnit, UnitOfMeasurement):
    ...


trait ElectricCurrent(BaseUnit, UnitOfMeasurement):
    ...


trait Temperature(BaseUnit, UnitOfMeasurement):
    ...


trait Mole(BaseUnit, UnitOfMeasurement):
    ...


trait LuminousIntensity(BaseUnit, UnitOfMeasurement):
    ...


trait Frequency(UnitOfMeasurement):
    alias TimeUnit: Time[_, 1]
    alias Unit: ComposedUnit[Numerator= [], Denominator= [TimeUnit]]


trait Acceleration(UnitOfMeasurement):
    alias LengthUnit: Length[_, 1]
    alias TimeUnit: Time[_, 2]
    alias Unit: ComposedUnit[Numerator= [LengthUnit], Denominator= [TimeUnit]]


trait Velocity(UnitOfMeasurement):
    alias LengthUnit: Length[_, 1]
    alias TimeUnit: Time[_, 1]
    alias Unit: ComposedUnit[Numerator= [LengthUnit], Denominator= [TimeUnit]]


trait Force(UnitOfMeasurement):
    alias MassUnit: Mass[_, 1]
    alias LengthUnit: Length[_, 1]
    alias TimeUnit: Time[_, 2]
    alias Unit: ComposedUnit[
        Numerator= [MassUnit, LengthUnit], Denominator= [TimeUnit]
    ]


trait Pressure(UnitOfMeasurement):
    alias TimeUnit: Time[_, 2]
    alias LengthUnit: Length[_, 1]
    alias MassUnit: Mass[_, 1]
    alias Unit: ComposedUnit[
        Numerator= [MassUnit], Denominator= [LengthUnit, TimeUnit]
    ]


trait Energy(UnitOfMeasurement):
    alias MassUnit: Mass[_, 2]
    alias LengthUnit: Length[_, 1]
    alias TimeUnit: Time[_, 2]
    alias Unit: ComposedUnit[
        Numerator= [MassUnit, LengthUnit], Denominator= [TimeUnit]
    ]


trait Power(UnitOfMeasurement):
    alias MassUnit: Mass[_, 2]
    alias LengthUnit: Length[_, 1]
    alias TimeUnit: Time[_, 3]
    alias Unit: ComposedUnit[
        Numerator= [MassUnit, LengthUnit], Denominator= [TimeUnit]
    ]


trait ElectricCharge(UnitOfMeasurement):
    alias TimeUnit: Time[_, 1]
    alias ElectricCurrentUnit: ElectricCurrent[_, 1]
    alias Unit: ComposedUnit[
        Numerator= [TimeUnit, ElectricCurrentUnit], Denominator= []
    ]


trait ElectricPotentialDelta(UnitOfMeasurement):
    alias MassUnit: Mass[_, 2]
    alias LengthUnit: Length[_, 1]
    alias TimeUnit: Time[_, 3]
    alias ElectricCurrentUnit: ElectricCurrent[_, 3]
    alias Unit: ComposedUnit[
        Numerator= [MassUnit, LengthUnit],
        Denominator= [TimeUnit, ElectricCurrentUnit],
    ]


trait ElectricCapacitance(UnitOfMeasurement):
    alias TimeUnit: Time[_, 4]
    alias ElectricCurrentUnit: ElectricCurrent[_, 2]
    alias MassUnit: Mass[_, 1]
    alias LengthUnit: Length[_, 2]
    alias Unit: ComposedUnit[
        Numerator= [TimeUnit, ElectricCurrentUnit],
        Denominator= [MassUnit, LengthUnit],
    ]


trait ElectricResistance(UnitOfMeasurement):
    alias MassUnit: Mass[_, 1]
    alias LengthUnit: Length[_, 2]
    alias TimeUnit: Time[_, 3]
    alias ElectricCurrentUnit: ElectricCurrent[_, 2]
    alias Unit: ComposedUnit[
        Numerator= [MassUnit, LengthUnit],
        Denominator= [TimeUnit, ElectricCurrentUnit],
    ]


trait ElectricConductance(UnitOfMeasurement):
    alias TimeUnit: Time[_, 3]
    alias ElectricCurrentUnit: ElectricCurrent[_, 2]
    alias MassUnit: Mass[_, 1]
    alias LengthUnit: Length[_, 2]
    alias Unit: ComposedUnit[
        Numerator= [TimeUnit, ElectricCurrentUnit],
        Denominator= [MassUnit, LengthUnit],
    ]

# TODO: 10 more derived units see: https://en.wikipedia.org/wiki/SI_derived_unit