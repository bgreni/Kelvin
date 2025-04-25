"""Frequency related definitions."""

from kelvin.quantity import *
from .time import Second


alias Hertz = Quantity[Dimensions.Null / Second.D, _, _]
