from kelvin import *
from testing import assert_equal


def test_ctor():
    var s = Second(10)
    assert_equal(s._value, 10.0)
    assert_equal(s.DT, DType.float64)

    var m = Minute(Int64(10))
    assert_equal(m._value, 600)
    assert_equal(m.DT, DType.int64)

    assert_equal(Minute(3), Second(180))


def test_add():
    assert_equal(Second(10) + Second(5), Second(15))
    var s = Second(30)
    s += Second(20)
    assert_equal(s, Second(50))


def test_sub():
    assert_equal(Second(10) - Second(5), Second(5))
    var s = Second(30)
    s -= Second(20)
    assert_equal(s, Second(10))


def test_str():
    assert_equal(String(Second(10)), "10.0 s^1")
