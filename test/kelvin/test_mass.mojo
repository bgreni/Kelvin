from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = Kilogram(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Kilogram[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: Kilogram[Width=4] = [1, 2, 3, 4]
    var d = Kilogram[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


def test_add():
    assert_equal(Kilogram(10) + Kilogram(5), Kilogram(15))
    var s = Kilogram(30)
    s += Kilogram(20)
    assert_equal(s, Kilogram(50))


def test_sub():
    assert_equal(Kilogram(10) - Kilogram(5), Kilogram(5))
    var s = Kilogram(30)
    s -= Kilogram(20)
    assert_equal(s, Kilogram(10))


def test_div():
    var a = Kilogram(20) / Kilogram(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_floordiv():
    var a = Kilogram(5) // Kilogram(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv():
# var a = Kilogram(5).__ceildiv__(Kilogram(2))
# assert_equal(a.value(), 3.0)


def test_mul():
    var a = Kilogram(20) * Kilogram(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Kilogram(10)), "10.0 kg^1")


def test_eq():
    assert_equal(Kilogram(10), Kilogram(10))
    assert_not_equal(Kilogram(10), Kilogram(20))


def test_scalar_arithmetic():
    var a = Kilogram(10)
    assert_equal(a * 5, Kilogram(50))
    a *= 5
    assert_equal(a, Kilogram(50))
    assert_equal(a / 5, Kilogram(10))
    a /= 5
    assert_equal(a, Kilogram(10))

    a = Kilogram(10)
    assert_equal(5 * a, Kilogram(50))
    assert_equal(20 / a, Quantity[-Kilogram.D](2))


def test_bool():
    assert_true(Bool(Kilogram(10)))
    assert_false(Bool(Kilogram(0)))

    if not Kilogram(10):
        assert_true(False)

    if Kilogram(0):
        assert_true(False)


def test_compare():
    assert_true(Kilogram(10) == Kilogram(10))
    assert_true(Kilogram(10) < Kilogram(20))
    assert_true(Kilogram(20) > Kilogram(10))
    assert_true(Kilogram(10) <= Kilogram(10))
    assert_true(Kilogram(10) <= Kilogram(20))
    assert_true(Kilogram(10) >= Kilogram(10))
    assert_true(Kilogram(20) >= Kilogram(10))

    comptime T = Kilogram[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd():
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = Kilogram[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains():
    comptime V = Kilogram[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs():
    assert_equal(abs(Kilogram(-10)), Kilogram(10))


def test_trunc():
    assert_equal(trunc(Kilogram(10.231)), Kilogram(10))


def test_ceil():
    assert_equal(ceil(Kilogram(10.231)), Kilogram(11))


def test_floor():
    assert_equal(floor(Kilogram(10.531)), Kilogram(10))


def test_round():
    assert_equal(round(Kilogram(10.2)), Kilogram(10))
    assert_equal(round(Kilogram(10.23452), 1), Kilogram(10.2))


def test_len():
    assert_equal(len(Kilogram[Width=4](1, 2, 3, 4)), 4)


def test_intable():
    assert_equal(Int(Kilogram(10.23)), 10)


def test_floatable():
    assert_equal(Float64(Kilogram(10.23)), 10.23)


def test_neg():
    assert_equal(-Kilogram(10), Kilogram(-10))


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
