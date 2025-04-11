from kelvin import *
from testing import assert_equal


def test_ctor():
    var a = MetersSquared(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = MetersSquared[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(MetersSquared(10) + MetersSquared(5), MetersSquared(15))
    var s = MetersSquared(30)
    s += MetersSquared(20)
    assert_equal(s, MetersSquared(50))


def test_sub():
    assert_equal(MetersSquared(10) - MetersSquared(5), MetersSquared(5))
    var s = MetersSquared(30)
    s -= MetersSquared(20)
    assert_equal(s, MetersSquared(10))


def test_str():
    assert_equal(String(MetersSquared(10)), "10.0 m^2")
