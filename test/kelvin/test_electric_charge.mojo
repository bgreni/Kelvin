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

    var c: Coulomb[Width=4] = [1, 2, 3, 4]
    var d = Coulomb[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


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


def test_floordiv():
    var a = Coulomb(5) // Coulomb(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv():
# var a = Coulomb(5).__ceildiv__(Coulomb(2))
# assert_equal(a.value(), 3.0)


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

    comptime T = Coulomb[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd():
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = Coulomb[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains():
    comptime V = Coulomb[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs():
    assert_equal(abs(Coulomb(-10)), Coulomb(10))


def test_trunc():
    assert_equal(trunc(Coulomb(10.231)), Coulomb(10))


def test_ceil():
    assert_equal(ceil(Coulomb(10.231)), Coulomb(11))


def test_floor():
    assert_equal(floor(Coulomb(10.531)), Coulomb(10))


def test_round():
    assert_equal(round(Coulomb(10.2)), Coulomb(10))
    assert_equal(round(Coulomb(10.23452), 1), Coulomb(10.2))


def test_len():
    assert_equal(len(Coulomb[Width=4](1, 2, 3, 4)), 4)


def test_intable():
    assert_equal(Int(Coulomb(10.23)), 10)


def test_floatable():
    assert_equal(Float64(Coulomb(10.23)), 10.23)


def test_neg():
    assert_equal(-Coulomb(10), Coulomb(-10))


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
