from kelvin import *
from testing import assert_equal


def test_ctor():
    var s = Velocity(10)
    assert_equal(s._value, 10.0)
    assert_equal(s.DT, DType.float64)


def test_add():
    assert_equal(Velocity(10) + Velocity(5), Velocity(15))


def test_sub():
    assert_equal(Velocity(10) - Velocity(5), Velocity(5))
    var s = Velocity(30)
    s -= Velocity(20)
    assert_equal(s, Velocity(10))


def test_str():
    assert_equal(String(Velocity(10)), "10.0 m^1 s^-1")


def test_div():
    assert_equal(Meter(20) / Second(10), Velocity(2))
