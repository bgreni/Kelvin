from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Candela(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Candela[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Candela(10) + Candela(5), Candela(15))
    var s = Candela(30)
    s += Candela(20)
    assert_equal(s, Candela(50))


def test_sub():
    assert_equal(Candela(10) - Candela(5), Candela(5))
    var s = Candela(30)
    s -= Candela(20)
    assert_equal(s, Candela(10))


def test_div():
    var a = Candela(20) / Candela(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Candela(20) * Candela(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Candela(10)), "10.0 cd^1")


def test_eq():
    assert_equal(Candela(10), Candela(10))
    assert_not_equal(Candela(10), Candela(20))


def test_scalar_arithmetic():
    var a = Candela(10)
    assert_equal(a + 10, Candela(20))
    a += 10
    assert_equal(a, Candela(20))
    assert_equal(a - 15, Candela(5))
    a -= 15
    assert_equal(a, Candela(5))
    assert_equal(a * 5, Candela(25))
    a *= 5
    assert_equal(a, Candela(25))
    assert_equal(a / 5, Candela(5))
    a /= 5
    assert_equal(a, Candela(5))

    a = Candela(10)
    assert_equal(10 + a, Candela(20))
    assert_equal(15 - a, Candela(5))
    assert_equal(5 * a, Candela(50))
    assert_equal(20 / a, Candela(2))
