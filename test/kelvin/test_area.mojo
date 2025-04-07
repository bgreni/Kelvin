from kelvin.area import *
from testing import *

def test_ctor():
    assert_equal(MetersSquared(10).value(), 10)

def test_str():
    assert_equal(String(MetersSquared(20)), '20.0 m^2')