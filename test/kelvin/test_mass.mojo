from kelvin import *
from testing import assert_equal


def test_ctor():
    var s = Kilogram(10)
    assert_equal(s._value, 10.0)
    assert_equal(s.DT, DType.float64)


def test_add():
    assert_equal(Kilogram(10) + Kilogram(5), Kilogram(15))


def test_sub():
    assert_equal(Kilogram(10) - Kilogram(5), Kilogram(5))
    var s = Kilogram(30)
    s -= Kilogram(20)
    assert_equal(s, Kilogram(10))


def test_str():
    assert_equal(String(Kilogram(10)), "10.0 g^1")
