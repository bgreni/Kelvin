from kelvin import *
from testing import assert_equal


def test_ctor():
    var s = MetersPerSecond(10)
    assert_equal(s._value, 10.0)
    assert_equal(s.DT, DType.float64)


def test_add():
    assert_equal(MetersPerSecond(10) + MetersPerSecond(5), MetersPerSecond(15))


def test_sub():
    assert_equal(MetersPerSecond(10) - MetersPerSecond(5), MetersPerSecond(5))
    var s = MetersPerSecond(30)
    s -= MetersPerSecond(20)
    assert_equal(s, MetersPerSecond(10))


def test_str():
    assert_equal(String(MetersPerSecond(10)), "10.0 m^1 s^-1")


def test_div():
    assert_equal(Meter(20) / Second(10), MetersPerSecond(2))
