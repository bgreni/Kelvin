"""Electric charge related definitions."""

from kelvin.quantity import *
from .electricity import Ampere
from .time import Second

alias Coulomb = Quantity[Ampere.D * Second.D, _, _]
