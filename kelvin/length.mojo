from kelvin.common import Ratio
from kelvin.quantity import *

alias Meters = Quantity[Dimensions[1, 0](), _]

# fn length_cast[R: Ratio](v: Float64) -> Seconds:
#     return Seconds(R * v)