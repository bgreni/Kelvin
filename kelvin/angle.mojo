"""Angle related definitions."""

from kelvin.quantity import *

comptime Radian = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle[Ratio.Unitary, "rad"](),
    ](),
    ...,
]

comptime Degree = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle[(Ratio.PI / Ratio[180, 1]()).simplify(), "°"](),
    ](),
    ...,
]
