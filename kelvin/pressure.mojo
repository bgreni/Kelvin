"""Pressure related definitions."""

from .force import Newton
from .length import Meter

comptime Pascal = Quantity[
    Newton.D / Meter.D**2,
    ...,
]
