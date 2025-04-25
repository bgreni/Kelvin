"""Acceleration related definitions."""

from .time import Second
from .velocity import MetersPerSecond

alias MetersPerSecondSquared = Quantity[MetersPerSecond.D / Second.D, _, _]
