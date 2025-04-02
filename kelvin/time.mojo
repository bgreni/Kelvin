from kelvin.common import Ratio
from kelvin.quantity import *

alias Second = Quantity[Dimensions[0, 0, 1, 0, 0, 0, 0](), _]


fn time_cast[R: Ratio](v: Scalar) -> Second[v.dtype]:
    return Second[v.dtype](R * v)


fn Minute(v: Scalar) -> Second[v.dtype]:
    return time_cast[Ratio[60]()](v)


fn Minute(v: Int) -> Second:
    return Minute(Float64(v))
