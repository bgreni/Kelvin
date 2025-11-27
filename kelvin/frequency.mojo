"""Frequency related definitions."""

from kelvin.quantity import *
from .time import Second


comptime Hertz = Quantity[
    Dimensions.Null / Second.D,
    *_,
]
