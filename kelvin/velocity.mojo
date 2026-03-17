"""Velocity related definitions."""

from .time import Hour, Second
from .length import Meter, Mile, Kilometer

comptime MetersPerSecond = Quantity[
    Meter.D / Second.D,
    ...,
]
comptime MilesPerHour = Quantity[
    Mile.D / Hour.D,
    ...,
]
comptime KilometersPerHour = Quantity[
    Kilometer.D / Hour.D,
    ...,
]
