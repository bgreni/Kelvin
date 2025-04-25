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
    assert_equal(a * 5, Kelvin(50))
    a *= 5
    assert_equal(a, Kelvin(50))
    assert_equal(a / 5, Kelvin(10))
    a /= 5
    assert_equal(a, Kelvin(10))

    a = Kelvin(10)
    assert_equal(5 * a, Kelvin(50))
    assert_equal(20 / a, Quantity[-Kelvin.D](2))


def test_bool():
    assert_true(Bool(Kelvin(10)))
    assert_false(Bool(Kelvin(0)))

    if not Kelvin(10):
        assert_true(False)

    if Kelvin(0):
        assert_true(False)


def test_compare():
    assert_true(Kelvin(10) == Kelvin(10))
    assert_true(Kelvin(10) < Kelvin(20))
    assert_true(Kelvin(20) > Kelvin(10))
    assert_true(Kelvin(10) <= Kelvin(10))
    assert_true(Kelvin(10) <= Kelvin(20))
    assert_true(Kelvin(10) >= Kelvin(10))
    assert_true(Kelvin(20) >= Kelvin(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = Kelvin[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))
