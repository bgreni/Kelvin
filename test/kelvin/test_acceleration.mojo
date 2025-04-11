from kelvin import *
from testing import assert_equal

def test_str():
    assert_equal(String(MetersPerSecondSquared(10)), "10.0 m^1 s^-2")