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
    assert_equal(a * 5, Candela(50))
    a *= 5
    assert_equal(a, Candela(50))
    assert_equal(a / 5, Candela(10))
    a /= 5
    assert_equal(a, Candela(10))

    a = Candela(10)
    assert_equal(5 * a, Candela(50))
    assert_equal(20 / a, Quantity[-Candela.D](2))


def test_bool():
    assert_true(Bool(Candela(10)))
    assert_false(Bool(Candela(0)))

    if not Candela(10):
        assert_true(False)

    if Candela(0):
        assert_true(False)


def test_compare():
    assert_true(Candela(10) == Candela(10))
    assert_true(Candela(10) < Candela(20))
    assert_true(Candela(20) > Candela(10))
    assert_true(Candela(10) <= Candela(10))
    assert_true(Candela(10) <= Candela(20))
    assert_true(Candela(10) >= Candela(10))
    assert_true(Candela(20) >= Candela(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = Candela[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
