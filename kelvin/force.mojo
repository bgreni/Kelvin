"""Force related definitions."""

from .mass import Kilogram
from .length import Meter
from .time import Second

comptime Newton = Quantity[
    (Kilogram.D * Meter.D) / Second.D**2,
    ...,
]
