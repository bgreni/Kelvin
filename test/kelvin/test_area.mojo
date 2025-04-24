from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


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


def test_div():
    var a = MetersSquared(20) / MetersSquared(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = MetersSquared(20) * MetersSquared(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(MetersSquared(10)), "10.0 m^2")


def test_eq():
    assert_equal(MetersSquared(10), MetersSquared(10))
    assert_not_equal(MetersSquared(10), MetersSquared(20))


def test_scalar_arithmetic():
    var a = MetersSquared(10)
    assert_equal(a * 5, MetersSquared(50))
    a *= 5
    assert_equal(a, MetersSquared(50))
    assert_equal(a / 5, MetersSquared(10))
    a /= 5
    assert_equal(a, MetersSquared(10))

    a = MetersSquared(10)
    assert_equal(5 * a, MetersSquared(50))
    assert_equal(20 / a, Quantity[-MetersSquared.D](2))


def test_bool():
    assert_true(Bool(MetersSquared(10)))
    assert_false(Bool(MetersSquared(0)))

    if not MetersSquared(10):
        assert_true(False)

    if MetersSquared(0):
        assert_true(False)


def test_compare():
    assert_true(MetersSquared(10) == MetersSquared(10))
    assert_true(MetersSquared(10) < MetersSquared(20))
    assert_true(MetersSquared(20) > MetersSquared(10))
    assert_true(MetersSquared(10) <= MetersSquared(10))
    assert_true(MetersSquared(10) <= MetersSquared(20))
    assert_true(MetersSquared(10) >= MetersSquared(10))
    assert_true(MetersSquared(20) >= MetersSquared(10))
