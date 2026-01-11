"""Energy related definitions."""

from kelvin.quantity import *
from .mass import Kilogram
from .length import Meter
from .time import Second

comptime Joule = Quantity[
    (Kilogram.D * (Meter.D**2)) / Second.D**2,
    ...,
]
