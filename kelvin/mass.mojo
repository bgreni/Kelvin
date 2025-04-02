from kelvin.quantity import *

alias Kilogram = Quantity[Dimensions[0, 1, 0, 0, 0, 0, 0](), _]


fn mass_cast[R: Ratio](v: Scalar) -> Kilogram[v.dtype]:
    return Kilogram[v.dtype](R * v)
