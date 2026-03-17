from kelvin import *
from std.testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor() raises:
    var a = Millimeter(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Millimeter[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: Millimeter[Width=4] = [1, 2, 3, 4]
    var d = Millimeter[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


def test_add() raises:
    assert_equal(Millimeter(10) + Millimeter(5), Millimeter(15))
    var s = Millimeter(30)
    s += Millimeter(20)
    assert_equal(s, Millimeter(50))


def test_sub() raises:
    assert_equal(Millimeter(10) - Millimeter(5), Millimeter(5))
    var s = Millimeter(30)
    s -= Millimeter(20)
    assert_equal(s, Millimeter(10))


def test_div() raises:
    var a = Millimeter(20) / Millimeter(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_floordiv() raises:
    var a = Millimeter(5) // Millimeter(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv() raises:
# var a = Millimeter(5).__ceildiv__(Millimeter(2))
# assert_equal(a.value(), 3.0)


def test_mul() raises:
    var a = Millimeter(20) * Millimeter(2)
    assert_equal(a.value(), 40.0)


def test_str() raises:
    assert_equal(String(Millimeter(10)), "10.0 mm^1")


def test_eq() raises:
    assert_equal(Millimeter(10), Millimeter(10))
    assert_not_equal(Millimeter(10), Millimeter(20))


def test_scalar_arithmetic() raises:
    var a = Millimeter(10)
    assert_equal(a * 5, Millimeter(50))
    a *= 5
    assert_equal(a, Millimeter(50))
    assert_equal(a / 5, Millimeter(10))
    a /= 5
    assert_equal(a, Millimeter(10))

    a = Millimeter(10)
    assert_equal(5 * a, Millimeter(50))
    assert_equal(20 / a, Quantity[-Millimeter.D](2))


def test_bool() raises:
    assert_true(Bool(Millimeter(10)))
    assert_false(Bool(Millimeter(0)))

    if not Millimeter(10):
        assert_true(False)

    if Millimeter(0):
        assert_true(False)


def test_compare() raises:
    assert_true(Millimeter(10) == Millimeter(10))
    assert_true(Millimeter(10) < Millimeter(20))
    assert_true(Millimeter(20) > Millimeter(10))
    assert_true(Millimeter(10) <= Millimeter(10))
    assert_true(Millimeter(10) <= Millimeter(20))
    assert_true(Millimeter(10) >= Millimeter(10))
    assert_true(Millimeter(20) >= Millimeter(10))

    comptime T = Millimeter[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd() raises:
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = Millimeter[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains() raises:
    comptime V = Millimeter[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs() raises:
    assert_equal(abs(Millimeter(-10)), Millimeter(10))


def test_trunc() raises:
    assert_equal(trunc(Millimeter(10.231)), Millimeter(10))


def test_ceil() raises:
    assert_equal(ceil(Millimeter(10.231)), Millimeter(11))


def test_floor() raises:
    assert_equal(floor(Millimeter(10.531)), Millimeter(10))


def test_round() raises:
    assert_equal(round(Millimeter(10.2)), Millimeter(10))
    assert_equal(round(Millimeter(10.23452), 1), Millimeter(10.2))


def test_len() raises:
    assert_equal(len(Millimeter[Width=4](1, 2, 3, 4)), 4)


def test_intable() raises:
    assert_equal(Int(Millimeter(10.23)), 10)


def test_floatable() raises:
    assert_equal(Float64(Millimeter(10.23)), 10.23)


def test_neg() raises:
    assert_equal(-Millimeter(10), Millimeter(-10))


def test_cast() raises:
    var a = Millimeter(cast_from=Meter(10))
    assert_equal(a.value(), 10000)


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
