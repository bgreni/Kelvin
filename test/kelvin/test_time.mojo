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
    assert_equal(a * 5, Second(50))
    a *= 5
    assert_equal(a, Second(50))
    assert_equal(a / 5, Second(10))
    a /= 5
    assert_equal(a, Second(10))

    a = Second(10)
    assert_equal(5 * a, Second(50))
    assert_equal(20 / a, Quantity[-Second.D](2))


def test_bool():
    assert_true(Bool(Second(10)))
    assert_false(Bool(Second(0)))

    if not Second(10):
        assert_true(False)

    if Second(0):
        assert_true(False)


def test_compare():
    assert_true(Second(10) == Second(10))
    assert_true(Second(10) < Second(20))
    assert_true(Second(20) > Second(10))
    assert_true(Second(10) <= Second(10))
    assert_true(Second(10) <= Second(20))
    assert_true(Second(10) >= Second(10))
    assert_true(Second(20) >= Second(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = Second[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_cast():
    var a = Second(cast_from=Minute(10))
    assert_equal(a.value(), 600)
