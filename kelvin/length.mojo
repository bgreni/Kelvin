"""Length related definitions."""

from kelvin.quantity import *

comptime Meter = Quantity[
    Dimensions[
        Dimension[1, Ratio.Unitary, "m"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    ...,
]

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
    ...,
]

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
    ...,
]
