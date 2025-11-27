"""Time related definitions."""

from kelvin.quantity import *

comptime Second = Quantity[
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
    *_,
]

comptime Minute = Quantity[
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
    *_,
]

comptime Hour = Quantity[
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
    *_,
]
