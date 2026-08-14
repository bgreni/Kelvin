"""Pressure related definitions."""

from kelvin.quantity import *
from .force import Newton
from .length import Meter

comptime Pascal = Quantity[
    Newton.D / Meter.D**2,
    ...,
]
