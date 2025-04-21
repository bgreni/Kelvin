from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Kilogram(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Kilogram[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Kilogram(10) + Kilogram(5), Kilogram(15))
    var s = Kilogram(30)
    s += Kilogram(20)
    assert_equal(s, Kilogram(50))


def test_sub():
    assert_equal(Kilogram(10) - Kilogram(5), Kilogram(5))
    var s = Kilogram(30)
    s -= Kilogram(20)
    assert_equal(s, Kilogram(10))


def test_div():
    var a = Kilogram(20) / Kilogram(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Kilogram(20) * Kilogram(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Kilogram(10)), "10.0 kg^1")


def test_eq():
    assert_equal(Kilogram(10), Kilogram(10))
    assert_not_equal(Kilogram(10), Kilogram(20))


def test_scalar_arithmetic():
    var a = Kilogram(10)
    assert_equal(a + 10, Kilogram(20))
    a += 10
    assert_equal(a, Kilogram(20))
    assert_equal(a - 15, Kilogram(5))
    a -= 15
    assert_equal(a, Kilogram(5))
    assert_equal(a * 5, Kilogram(25))
    a *= 5
    assert_equal(a, Kilogram(25))
    assert_equal(a / 5, Kilogram(5))
    a /= 5
    assert_equal(a, Kilogram(5))

    a = Kilogram(10)
    assert_equal(10 + a, Kilogram(20))
    assert_equal(15 - a, Kilogram(5))
    assert_equal(5 * a, Kilogram(50))
    assert_equal(20 / a, Kilogram(2))
