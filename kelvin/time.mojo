"""Time related definitions."""

from kelvin.quantity import *

alias Second = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio.Unitary, "s"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    _,
    _,
]

alias Minute = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio[60, 1](), "min"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    _,
    _,
]

alias Hour = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio[3600, 1](), "h"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ](),
    _,
    _,
]
