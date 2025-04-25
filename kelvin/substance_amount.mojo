"""Substance Amount related definitions."""

from kelvin.quantity import *

alias Mole = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio.Unitary, "mol"](),
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    _,
    _,
]
