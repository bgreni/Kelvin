from kelvin.ratio import Ratio
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
    ](),
    _,
]

alias Minute = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio[60](), "min"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
    ](),
    _,
]

alias Hour = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio[3600](), "h"](),
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
    ](),
    _,
]
