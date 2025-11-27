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
    *_,
]
