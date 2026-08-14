"""Acceleration related definitions."""

from kelvin.quantity import *
from .time import Second
from .velocity import MetersPerSecond

comptime MetersPerSecondSquared = Quantity[
    MetersPerSecond.D / Second.D,
    ...,
]
