"""Luminosity related definitions."""

from kelvin.quantity import *

comptime Candela = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio.Unitary, "cd"](),
        Angle.Invalid,
    ](),
    *_,
]
