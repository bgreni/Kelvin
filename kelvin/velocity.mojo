from .time import Hour
from .length import Meter


alias MetersPerSecond = Quantity[Meter.D / Second.D, _]
alias MilesPerHour = Quantity[Mile.D / Hour.D, _]

alias speed_of_light = MetersPerSecond(299792458.0)
