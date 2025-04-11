from kelvin import *
from testing import assert_equal


def test_ctor():
    var a = Second(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Second[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


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


def test_cast():
    var a = Minute(10)
    assert_equal(a.value(), 600)
