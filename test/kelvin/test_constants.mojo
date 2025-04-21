from kelvin import *
from testing import *


def test_sol():
    assert_equal(String(speed_of_light), "299792458.0 m^1 s^-1")
    assert_equal(String(planck_constant), "6.62607015e-34 m^2 kg^1 s^-1")
