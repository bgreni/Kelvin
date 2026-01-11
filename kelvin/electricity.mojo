"""Electricity related definitions."""

from kelvin.quantity import *

comptime Ampere = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio.Unitary, "A"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    ...,
]
