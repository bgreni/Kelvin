from kelvin import *
from std.testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor() raises:
    var a = Milligram(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Milligram[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: Milligram[Width=4] = [1, 2, 3, 4]
    var d = Milligram[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


def test_add() raises:
    assert_equal(Milligram(10) + Milligram(5), Milligram(15))
    var s = Milligram(30)
    s += Milligram(20)
    assert_equal(s, Milligram(50))


def test_sub() raises:
    assert_equal(Milligram(10) - Milligram(5), Milligram(5))
    var s = Milligram(30)
    s -= Milligram(20)
    assert_equal(s, Milligram(10))


def test_div() raises:
    var a = Milligram(20) / Milligram(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_floordiv() raises:
    var a = Milligram(5) // Milligram(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv() raises:
# var a = Milligram(5).__ceildiv__(Milligram(2))
# assert_equal(a.value(), 3.0)


def test_mul() raises:
    var a = Milligram(20) * Milligram(2)
    assert_equal(a.value(), 40.0)


def test_str() raises:
    assert_equal(String(Milligram(10)), "10.0 mg^1")


def test_eq() raises:
    assert_equal(Milligram(10), Milligram(10))
    assert_not_equal(Milligram(10), Milligram(20))


def test_scalar_arithmetic() raises:
    var a = Milligram(10)
    assert_equal(a * 5, Milligram(50))
    a *= 5
    assert_equal(a, Milligram(50))
    assert_equal(a / 5, Milligram(10))
    a /= 5
    assert_equal(a, Milligram(10))

    a = Milligram(10)
    assert_equal(5 * a, Milligram(50))
    assert_equal(20 / a, Quantity[-Milligram.D](2))


def test_bool() raises:
    assert_true(Bool(Milligram(10)))
    assert_false(Bool(Milligram(0)))

    if not Milligram(10):
        assert_true(False)

    if Milligram(0):
        assert_true(False)


def test_compare() raises:
    assert_true(Milligram(10) == Milligram(10))
    assert_true(Milligram(10) < Milligram(20))
    assert_true(Milligram(20) > Milligram(10))
    assert_true(Milligram(10) <= Milligram(10))
    assert_true(Milligram(10) <= Milligram(20))
    assert_true(Milligram(10) >= Milligram(10))
    assert_true(Milligram(20) >= Milligram(10))

    comptime T = Milligram[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd() raises:
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = Milligram[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains() raises:
    comptime V = Milligram[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs() raises:
    assert_equal(abs(Milligram(-10)), Milligram(10))


def test_trunc() raises:
    assert_equal(trunc(Milligram(10.231)), Milligram(10))


def test_ceil() raises:
    assert_equal(ceil(Milligram(10.231)), Milligram(11))


def test_floor() raises:
    assert_equal(floor(Milligram(10.531)), Milligram(10))


def test_round() raises:
    assert_equal(round(Milligram(10.2)), Milligram(10))
    assert_equal(round(Milligram(10.23452), 1), Milligram(10.2))


def test_len() raises:
    assert_equal(len(Milligram[Width=4](1, 2, 3, 4)), 4)


def test_intable() raises:
    assert_equal(Int(Milligram(10.23)), 10)


def test_floatable() raises:
    assert_equal(Float64(Milligram(10.23)), 10.23)


def test_neg() raises:
    assert_equal(-Milligram(10), Milligram(-10))


def test_cast() raises:
    var a = Milligram(cast_from=Kilogram(10))
    assert_equal(a.value(), 10000000)


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
