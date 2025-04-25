from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Ampere(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Ampere[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Ampere(10) + Ampere(5), Ampere(15))
    var s = Ampere(30)
    s += Ampere(20)
    assert_equal(s, Ampere(50))


def test_sub():
    assert_equal(Ampere(10) - Ampere(5), Ampere(5))
    var s = Ampere(30)
    s -= Ampere(20)
    assert_equal(s, Ampere(10))


def test_div():
    var a = Ampere(20) / Ampere(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Ampere(20) * Ampere(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Ampere(10)), "10.0 A^1")


def test_eq():
    assert_equal(Ampere(10), Ampere(10))
    assert_not_equal(Ampere(10), Ampere(20))


def test_scalar_arithmetic():
    var a = Ampere(10)
    assert_equal(a * 5, Ampere(50))
    a *= 5
    assert_equal(a, Ampere(50))
    assert_equal(a / 5, Ampere(10))
    a /= 5
    assert_equal(a, Ampere(10))

    a = Ampere(10)
    assert_equal(5 * a, Ampere(50))
    assert_equal(20 / a, Quantity[-Ampere.D](2))


def test_bool():
    assert_true(Bool(Ampere(10)))
    assert_false(Bool(Ampere(0)))

    if not Ampere(10):
        assert_true(False)

    if Ampere(0):
        assert_true(False)


def test_compare():
    assert_true(Ampere(10) == Ampere(10))
    assert_true(Ampere(10) < Ampere(20))
    assert_true(Ampere(20) > Ampere(10))
    assert_true(Ampere(10) <= Ampere(10))
    assert_true(Ampere(10) <= Ampere(20))
    assert_true(Ampere(10) >= Ampere(10))
    assert_true(Ampere(20) >= Ampere(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = Ampere[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))
