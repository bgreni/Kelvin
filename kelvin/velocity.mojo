"""Velocity related definitions."""

from .time import Hour
from .length import Meter

comptime MetersPerSecond = Quantity[
    Meter.D / Second.D,
    ...,
]
comptime MilesPerHour = Quantity[
    Mile.D / Hour.D,
    ...,
]
