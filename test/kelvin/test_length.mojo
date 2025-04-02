from kelvin import *
from testing import assert_equal


def test_ctor():
    var s = Meter(10)
    assert_equal(s._value, 10.0)
    assert_equal(s.DT, DType.float64)

    var m = Kilometer(Int64(10))
    assert_equal(m._value, 10000)
    assert_equal(m.DT, DType.int64)

    assert_equal(Kilometer(3), Meter(3000))


def test_add():
    assert_equal(Meter(10) + Meter(5), Meter(15))


def test_sub():
    assert_equal(Meter(10) - Meter(5), Meter(5))
    var s = Meter(30)
    s -= Meter(20)
    assert_equal(s, Meter(10))


def test_str():
    assert_equal(String(Meter(10)), "10.0 m^1")
