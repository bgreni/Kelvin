"""Angle related definitions."""

from kelvin.quantity import *

alias Radian = Quantity[
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
    _,
    _,
]

alias Degree = Quantity[
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
    _,
    _,
]
