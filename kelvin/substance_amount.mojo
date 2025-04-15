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
    ](),
    _,
]
