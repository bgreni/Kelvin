"""Velocity related definitions."""

from .time import Hour
from .length import Meter

alias MetersPerSecond = Quantity[Meter.D / Second.D, _]
alias MilesPerHour = Quantity[Mile.D / Hour.D, _]
