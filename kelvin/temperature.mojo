from kelvin.quantity import *

alias Kelvin = Quantity[
    Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension[1, Ratio.Unitary, "K"](),
        Dimension.Invalid,
        Dimension.Invalid,
    ](),
    _,
]
