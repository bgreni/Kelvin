"""Power related definitions."""

from kelvin.quantity import *
from .energy import Joule
from .time import Second

comptime Watt = Quantity[
    Joule.D / Second.D,
    ...,
]
