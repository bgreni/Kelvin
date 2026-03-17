"""Mass related definitions."""

from kelvin.quantity import *

comptime Kilogram = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension[1, Ratio.Unitary, "kg"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    ...,
]

comptime Gram = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension[1, Ratio.Milli, "g"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    ...,
]

comptime Milligram = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension[1, Ratio.Micro, "mg"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    ...,
]
