"""Mass related definitions."""

from kelvin.quantity import *

alias Kilogram = Quantity[
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
    _,
    _,
]
