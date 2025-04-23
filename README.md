# Kelvin

![license_badge](https://badgen.net/static/license/Apache2.0/blue)
![ci_badge](https://github.com/bgreni/Kelvin/actions/workflows/CI.yml/badge.svg)

A powerful dimensional analysis library written in Mojo for all you scientific computing needs.
Heavily inspired by [uom](https://docs.rs/uom/latest/uom/index.html).

## Defining a Quantity

To define a specific unit, you simply need to create an alias to `Quantity` with
the particular dimensions defined. Each dimension also requires a `Ratio` and a
suffix string. The ratio defines the relationship between it and the unitary amount.
All dimensions that do not exist for a given quantity are given `Dimension.Invalid`.

```mojo
# Base unit for time, `Second`
alias Meter = Quantity[
    Dimensions[
        Dimension[1, Ratio.Unitary, "m"](), # Length
        Dimension.Invalid, # Mass
        Dimension.Invalid, # Time
        Dimension.Invalid, # Electric current
        Dimension.Invalid, # Temperature
        Dimension.Invalid, # Substance Amount
        Dimension.Invalid, # Luminosity
        Angle.Invalid, # Angle
    ](),
    _,
]

# Use Ratio.Kilo to create a `Kilometer`
alias Kilometer = Quantity[
    Dimensions[
        Dimension[1, Ratio.Kilo, "km"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    _,
]

# Quantity with a weird conversion ratio
alias Mile = Quantity[
    Dimensions[
        Dimension[1, Ratio[1609344, 1000]().simplify(), "mile"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    _,
]
```

With these simple units defined, we can use arithmetic syntax on the `Dimensions`
struct to create derivative units very easily. Here we can define Velocity in
a single line of code.

```mojo
alias MetersPerSecond = Quantity[Meter.D / Second.D, _]
alias MetersSquared = Quantity[Meter.D**2, _]

alias kg = Kilogram.D
alias m = Meter.D
alias s = Second.D
alias Newton = Quantity[kg * m * (s ** -2)]
```

## Numerical Type

Quantity accepts a `DType` parameter to define the numerical type and bitwidth
of the underlying value. The default is `DType.float64`.

```mojo
var s = Second(10.0) # Will be a float64

alias IntSecond = Second[DType.int64]
var is = IntSecond(10) # will be int64
```

## Quantity Arithmetic

Since the dimensions of a quantity are a dynamic part of the type system,
we can also do type-safe quantity multiplication and division. Though they
must have matching scale on all valid dimensions

```mojo
var velocity: MetersPerSecond = Meter(10) / Second(2)
var area: MetersSquared = Meter(10) * Meter(20)

var a = Meter(10) * Mile(20) # Nope

# Power must be an IntLiteral so it's compile time known
area = Meter(10) ** 2
```

Addition and subtraction are only defined on matching quantities.

```mojo
var a = Meter(10) + Meter(10)
var b = Meter(10) + Mile(20) # Nope
var c = Meter(10) + Second(10) # Nope
```

You can also freely use scalar values in combinations with scalar values.

```mojo
var m = Meter(10)
m = m * 5
m += 10
```

## Quantity Conversions

Quantities with matching dimensions, but different scale can be casted to one
another.

```mojo
var m = Minute(cast_from=Second(600))
var s = Second(cast_from=m)
```

## Sharp Edges

Dimensional type safety is only implemented at the `Quantity` level, due to
the usage of `@always_inline('builtin')` throughout `Dimensions, Dimension, Ratio and Angle`
to keep compile times fast, and there is currently no way of adding additional contraints
to methods that use that decorator. The result is expressions like these are erroneously allowed.

```mojo
alias BadUnit = Meter.D * Mile.D # Bad

var a = Meter(10) * Mile(10) # Reject properly due to using Quantity
```

You are still protected from surprising behavior when doing actual calculations, but
care must be taken when defining new units.
