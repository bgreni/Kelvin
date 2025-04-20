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
        Angle[Ratio.Unitary](),
    ](),
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
        Angle[(Ratio[180]() / Ratio.PI).simplify()](),
    ](),
    _,
]
