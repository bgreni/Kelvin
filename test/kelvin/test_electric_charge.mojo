from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Coulomb(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Coulomb[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Coulomb(10) + Coulomb(5), Coulomb(15))
    var s = Coulomb(30)
    s += Coulomb(20)
    assert_equal(s, Coulomb(50))


def test_sub():
    assert_equal(Coulomb(10) - Coulomb(5), Coulomb(5))
    var s = Coulomb(30)
    s -= Coulomb(20)
    assert_equal(s, Coulomb(10))


def test_div():
    var a = Coulomb(20) / Coulomb(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Coulomb(20) * Coulomb(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Coulomb(10)), "10.0 s^1 A^1")


def test_eq():
    assert_equal(Coulomb(10), Coulomb(10))
    assert_not_equal(Coulomb(10), Coulomb(20))


def test_scalar_arithmetic():
    var a = Coulomb(10)
    assert_equal(a * 5, Coulomb(50))
    a *= 5
    assert_equal(a, Coulomb(50))
    assert_equal(a / 5, Coulomb(10))
    a /= 5
    assert_equal(a, Coulomb(10))

    a = Coulomb(10)
    assert_equal(5 * a, Coulomb(50))
    assert_equal(20 / a, Quantity[-Coulomb.D](2))


def test_bool():
    assert_true(Bool(Coulomb(10)))
    assert_false(Bool(Coulomb(0)))

    if not Coulomb(10):
        assert_true(False)

    if Coulomb(0):
        assert_true(False)


def test_compare():
    assert_true(Coulomb(10) == Coulomb(10))
    assert_true(Coulomb(10) < Coulomb(20))
    assert_true(Coulomb(20) > Coulomb(10))
    assert_true(Coulomb(10) <= Coulomb(10))
    assert_true(Coulomb(10) <= Coulomb(20))
    assert_true(Coulomb(10) >= Coulomb(10))
    assert_true(Coulomb(20) >= Coulomb(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = Coulomb[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
