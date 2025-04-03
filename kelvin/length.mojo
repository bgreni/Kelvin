from kelvin.quantity import *
from kelvin.ratio import Ratio

alias Meter = Quantity[Dimensions[1, 0, 0, 0, 0, 0, 0](), _]


fn length_cast[R: Ratio](v: Scalar) -> Meter[v.dtype]:
    return Meter[v.dtype](R * v)


fn Kilometer(v: Scalar) -> Meter[v.dtype]:
    return length_cast[Ratio.Kilo](v)


fn Kilometer(v: Int) -> Meter:
    return Kilometer(Float64(v))
