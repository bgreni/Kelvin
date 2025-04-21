from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Kelvin(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Kelvin[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Kelvin(10) + Kelvin(5), Kelvin(15))
    var s = Kelvin(30)
    s += Kelvin(20)
    assert_equal(s, Kelvin(50))


def test_sub():
    assert_equal(Kelvin(10) - Kelvin(5), Kelvin(5))
    var s = Kelvin(30)
    s -= Kelvin(20)
    assert_equal(s, Kelvin(10))


def test_div():
    var a = Kelvin(20) / Kelvin(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Kelvin(20) * Kelvin(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Kelvin(10)), "10.0 K^1")


def test_eq():
    assert_equal(Kelvin(10), Kelvin(10))
    assert_not_equal(Kelvin(10), Kelvin(20))


def test_scalar_arithmetic():
    var a = Kelvin(10)
    assert_equal(a + 10, Kelvin(20))
    a += 10
    assert_equal(a, Kelvin(20))
    assert_equal(a - 15, Kelvin(5))
    a -= 15
    assert_equal(a, Kelvin(5))
    assert_equal(a * 5, Kelvin(25))
    a *= 5
    assert_equal(a, Kelvin(25))
    assert_equal(a / 5, Kelvin(5))
    a /= 5
    assert_equal(a, Kelvin(5))

    a = Kelvin(10)
    assert_equal(10 + a, Kelvin(20))
    assert_equal(15 - a, Kelvin(5))
    assert_equal(5 * a, Kelvin(50))
    assert_equal(20 / a, Kelvin(2))
