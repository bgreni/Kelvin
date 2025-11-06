from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Joule(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Joule[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Joule(10) + Joule(5), Joule(15))
    var s = Joule(30)
    s += Joule(20)
    assert_equal(s, Joule(50))


def test_sub():
    assert_equal(Joule(10) - Joule(5), Joule(5))
    var s = Joule(30)
    s -= Joule(20)
    assert_equal(s, Joule(10))


def test_div():
    var a = Joule(20) / Joule(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Joule(20) * Joule(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Joule(10)), "10.0 m^2 kg^1 s^-2")


def test_eq():
    assert_equal(Joule(10), Joule(10))
    assert_not_equal(Joule(10), Joule(20))


def test_scalar_arithmetic():
    var a = Joule(10)
    assert_equal(a * 5, Joule(50))
    a *= 5
    assert_equal(a, Joule(50))
    assert_equal(a / 5, Joule(10))
    a /= 5
    assert_equal(a, Joule(10))

    a = Joule(10)
    assert_equal(5 * a, Joule(50))
    assert_equal(20 / a, Quantity[-Joule.D](2))


def test_bool():
    assert_true(Bool(Joule(10)))
    assert_false(Bool(Joule(0)))

    if not Joule(10):
        assert_true(False)

    if Joule(0):
        assert_true(False)


def test_compare():
    assert_true(Joule(10) == Joule(10))
    assert_true(Joule(10) < Joule(20))
    assert_true(Joule(20) > Joule(10))
    assert_true(Joule(10) <= Joule(10))
    assert_true(Joule(10) <= Joule(20))
    assert_true(Joule(10) >= Joule(10))
    assert_true(Joule(20) >= Joule(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = Joule[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def main():
    var s = TestSuite.discover_tests[__functions_in_module()]()
    print(s.generate_report())
