"""Electric charge related definitions."""

from kelvin.quantity import *
from .electricity import Ampere
from .time import Second

comptime Coulomb = Quantity[
    Ampere.D * Second.D,
    *_,
]
