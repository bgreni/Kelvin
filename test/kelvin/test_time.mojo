from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


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


def test_div():
    var a = Second(20) / Second(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Second(20) * Second(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Second(10)), "10.0 s^1")


def test_eq():
    assert_equal(Second(10), Second(10))
    assert_not_equal(Second(10), Second(20))


def test_scalar_arithmetic():
    var a = Second(10)
    assert_equal(a + 10, Second(20))
    a += 10
    assert_equal(a, Second(20))
    assert_equal(a - 15, Second(5))
    a -= 15
    assert_equal(a, Second(5))
    assert_equal(a * 5, Second(25))
    a *= 5
    assert_equal(a, Second(25))
    assert_equal(a / 5, Second(5))
    a /= 5
    assert_equal(a, Second(5))


def test_cast():
    var a = Second(cast_from=Minute(10))
    assert_equal(a.value(), 600)
