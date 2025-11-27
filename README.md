# Kelvin

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![ci_badge](https://github.com/bgreni/Kelvin/actions/workflows/CI.yml/badge.svg)
![CodeQL](https://github.com/bgreni/Kelvin/workflows/CodeQL/badge.svg)

A powerful dimensional analysis library written in Mojo for all your scientific computing needs.
Heavily inspired by [uom](https://docs.rs/uom/latest/uom/index.html).

## Defining a Quantity

To define a specific unit, you simply need to create an comptime to `Quantity` with
the particular dimensions defined. Each dimension also requires a `Ratio` and a
suffix string. The ratio defines the relationship between it and the unitary amount.
All dimensions that do not exist for a given quantity are given `Dimension.Invalid`.

```mojo
# Base unit for time, `Second`
comptime Meter = Quantity[
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
    *_,
]

# Use Ratio.Kilo to create a `Kilometer`
comptime Kilometer = Quantity[
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
    *_,
]

# Quantity with a weird conversion ratio
comptime Mile = Quantity[
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
    *_,
]
```

With these simple units defined, we can use arithmetic syntax on the `Dimensions`
struct to create derivative units very easily. Here we can define Velocity in
a single line of code.

```mojo
comptime MetersPerSecond = Quantity[Meter.D / Second.D, *_,]
comptime MetersSquared = Quantity[Meter.D**2, *_,]

comptime kg = Kilogram.D
comptime m = Meter.D
comptime s = Second.D
comptime Newton = Quantity[kg * m * (s ** -2)]
```

`Quantity` uses the mojo builtin `SIMD` type, so users can also supply a vector width
parameter after the DType.

```mojo
comptime SIMDSeconds = Second[_, 4]
comptime SIMDMeter = Meter[_, 4]
print(SIMDMeter(40) / SIMDSeconds(10)) # [4.0, 4.0, 4.0, 4.0] m^1 s^-1
```

## Numerical Type

Quantity accepts a `DType` parameter to define the numerical type and bitwidth
of the underlying value. The default is `DType.float64`.

```mojo
var s = Second(10.0) # Will be a float64

comptime IntSecond = Second[DType.int64]
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

You can also use scalar values for multiplication and division.

```mojo
var m = Meter(10)
m = m * 5
m /= 5
```

## Quantity Conversions

Quantities with matching dimensions, but different scale can be casted to one
another.

```mojo
var m = Minute(cast_from=Second(600))
var s = Second(cast_from=m)
```

## Sharp Edges

### Dimensions operations are unchecked

Dimensional type safety is only implemented at the `Quantity` level, due to
the usage of `@always_inline('builtin')` throughout `Dimensions, Dimension, Ratio and Angle`
to keep compile times fast, and there is currently no way of adding additional contraints
to methods that use that decorator. The result is expressions like these are erroneously allowed.

```mojo
comptime BadUnit = Meter.D * Mile.D # Bad

var a = Meter(10) * Mile(10) # Reject properly due to using Quantity
```

You are still protected from surprising behavior when doing actual calculations, but
care must be taken when defining new units.

### Integer Rounding

When using integer value representations, operations are subject to integer rounding
rules. If precision is important, please use a float point representation

```mojo
comptime IntSeconds = Second[DType.int64]

var a = IntSeconds(11) / IntSeconds(3) # returns IntSeconds(3)
```
