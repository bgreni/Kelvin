from kelvin import *
from testing import assert_equal


def test_ctor():
    var a = MetersPerSecondSquared(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = MetersPerSecondSquared[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(
        MetersPerSecondSquared(10) + MetersPerSecondSquared(5),
        MetersPerSecondSquared(15),
    )
    var s = MetersPerSecondSquared(30)
    s += MetersPerSecondSquared(20)
    assert_equal(s, MetersPerSecondSquared(50))


def test_sub():
    assert_equal(
        MetersPerSecondSquared(10) - MetersPerSecondSquared(5),
        MetersPerSecondSquared(5),
    )
    var s = MetersPerSecondSquared(30)
    s -= MetersPerSecondSquared(20)
    assert_equal(s, MetersPerSecondSquared(10))


def test_str():
    assert_equal(String(MetersPerSecondSquared(10)), "10.0 m^1 s^-2")
