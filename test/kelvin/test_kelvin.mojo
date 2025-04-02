from kelvin.time import *
from testing import assert_equal

def test_add():
    assert_equal(Seconds(10) + Seconds(5), Seconds(15))

def test_str():
    assert_equal(String(Seconds(10)), "10.0 s^1")
