from kelvin.common import Ratio
from kelvin.quantity import *

alias Seconds = Quantity[Dimensions[0, 1](), _]

fn time_cast[R: Ratio](v: Float64) -> Seconds:
    return Seconds(R * v)

fn Minutes(v: Float64) -> Seconds:
    return time_cast[Ratio[60]()](v)

fn Hours(v: Float64) -> Seconds:
    return time_cast[Ratio[3600]()](v)