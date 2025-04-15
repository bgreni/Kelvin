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
    ](),
    _,
]


fn mass_cast[R: Ratio](v: Scalar) -> Kilogram[v.dtype]:
    return Kilogram[v.dtype](R * v)
