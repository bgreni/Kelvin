"""Area related definitions."""

from kelvin.quantity import *
from .length import Meter

comptime MetersSquared = Quantity[
    Meter.D**2,
    ...,
]
