"""Definitions of the universal constants."""

from .velocity import MetersPerSecond
from .quantity import Quantity, Dimensions
from .frequency import Hertz
from .electric_charge import Coulomb
from .substance_amount import Mole
from .luminosity import Candela
from .time import Second
from .mass import Kilogram
from .energy import Joule

# ===------------------------------------------------------------------=== #
# SI Defining Constants
# ===------------------------------------------------------------------=== #
alias V_cs = Hertz(9192631770)
alias speed_of_light = MetersPerSecond(299792458.0)
alias planck_constant = Quantity[Joule.D / Hertz.D](6.62607015e-34)
alias elementary_charge = Coulomb(1.602176634e-19)
alias boltzmann_constant = Quantity[Joule.D / Kelvin.D](1.380649e-23)
alias avogandro_constant = Quantity[Dimensions.Null / Mole.D](6.02214076e23)
alias K_cd = Quantity[
    Candela.D * (Second.D**3) * (Kilogram.D**-1) * (Meter.D**-2)
](683)
alias gravity = MetersPerSecondSquared(9.81)
