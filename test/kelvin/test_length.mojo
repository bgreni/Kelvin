from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Meter(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Meter[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Meter(10) + Meter(5), Meter(15))
    var s = Meter(30)
    s += Meter(20)
    assert_equal(s, Meter(50))


def test_sub():
    assert_equal(Meter(10) - Meter(5), Meter(5))
    var s = Meter(30)
    s -= Meter(20)
    assert_equal(s, Meter(10))


def test_div():
    var a = Meter(20) / Meter(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Meter(20) * Meter(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Meter(10)), "10.0 m^1")


def test_eq():
    assert_equal(Meter(10), Meter(10))
    assert_not_equal(Meter(10), Meter(20))


def test_cast():
    var a = Meter(cast_from=Kilometer(10))
    assert_equal(a.value(), 10000)
