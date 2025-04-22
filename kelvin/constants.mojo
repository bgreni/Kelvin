"""Definitions of the universal constants."""

from kelvin import *

# ===------------------------------------------------------------------=== #
# SI Defining Constants
# ===------------------------------------------------------------------=== #
alias V_cs = Hertz(9192631770)
alias speed_of_light = MetersPerSecond(299792458.0)
alias planck_constant = Quantity[Joule.D / Hertz.D](6.62607015e-34)
alias elementary_charge = Coulomb(1.602176634e-19)
alias boltzmann_constant = Quantity[Joule.D / Kelvin.D](1.380649e-23)
alias avogandro_constant = Quantity[Dimensions.Null / Mole.D](6.02214076e23)
alias K_cd = Quantity[Candela.D * (Second.D ** 3) * (Kilogram.D ** -1) * (Meter.D ** -2)](683)
