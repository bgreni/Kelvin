from kelvin import *
from std.testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor() raises:
    var a = MetersPerSecondSquared(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = MetersPerSecondSquared[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: MetersPerSecondSquared[Width=4] = [1, 2, 3, 4]
    var d = MetersPerSecondSquared[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


def test_add() raises:
    assert_equal(
        MetersPerSecondSquared(10) + MetersPerSecondSquared(5),
        MetersPerSecondSquared(15),
    )
    var s = MetersPerSecondSquared(30)
    s += MetersPerSecondSquared(20)
    assert_equal(s, MetersPerSecondSquared(50))


def test_sub() raises:
    assert_equal(
        MetersPerSecondSquared(10) - MetersPerSecondSquared(5),
        MetersPerSecondSquared(5),
    )
    var s = MetersPerSecondSquared(30)
    s -= MetersPerSecondSquared(20)
    assert_equal(s, MetersPerSecondSquared(10))


def test_div() raises:
    var a = MetersPerSecondSquared(20) / MetersPerSecondSquared(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_floordiv() raises:
    var a = MetersPerSecondSquared(5) // MetersPerSecondSquared(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv() raises:
# var a = MetersPerSecondSquared(5).__ceildiv__(MetersPerSecondSquared(2))
# assert_equal(a.value(), 3.0)


def test_mul() raises:
    var a = MetersPerSecondSquared(20) * MetersPerSecondSquared(2)
    assert_equal(a.value(), 40.0)


def test_str() raises:
    assert_equal(String(MetersPerSecondSquared(10)), "10.0 m^1 s^-2")


def test_eq() raises:
    assert_equal(MetersPerSecondSquared(10), MetersPerSecondSquared(10))
    assert_not_equal(MetersPerSecondSquared(10), MetersPerSecondSquared(20))


def test_scalar_arithmetic() raises:
    var a = MetersPerSecondSquared(10)
    assert_equal(a * 5, MetersPerSecondSquared(50))
    a *= 5
    assert_equal(a, MetersPerSecondSquared(50))
    assert_equal(a / 5, MetersPerSecondSquared(10))
    a /= 5
    assert_equal(a, MetersPerSecondSquared(10))

    a = MetersPerSecondSquared(10)
    assert_equal(5 * a, MetersPerSecondSquared(50))
    assert_equal(20 / a, Quantity[-MetersPerSecondSquared.D](2))


def test_bool() raises:
    assert_true(Bool(MetersPerSecondSquared(10)))
    assert_false(Bool(MetersPerSecondSquared(0)))

    if not MetersPerSecondSquared(10):
        assert_true(False)

    if MetersPerSecondSquared(0):
        assert_true(False)


def test_compare() raises:
    assert_true(MetersPerSecondSquared(10) == MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(10) < MetersPerSecondSquared(20))
    assert_true(MetersPerSecondSquared(20) > MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(10) <= MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(10) <= MetersPerSecondSquared(20))
    assert_true(MetersPerSecondSquared(10) >= MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(20) >= MetersPerSecondSquared(10))

    comptime T = MetersPerSecondSquared[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd() raises:
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = MetersPerSecondSquared[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains() raises:
    comptime V = MetersPerSecondSquared[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs() raises:
    assert_equal(abs(MetersPerSecondSquared(-10)), MetersPerSecondSquared(10))


def test_trunc() raises:
    assert_equal(
        trunc(MetersPerSecondSquared(10.231)), MetersPerSecondSquared(10)
    )


def test_ceil() raises:
    assert_equal(
        ceil(MetersPerSecondSquared(10.231)), MetersPerSecondSquared(11)
    )


def test_floor() raises:
    assert_equal(
        floor(MetersPerSecondSquared(10.531)), MetersPerSecondSquared(10)
    )


def test_round() raises:
    assert_equal(
        round(MetersPerSecondSquared(10.2)), MetersPerSecondSquared(10)
    )
    assert_equal(
        round(MetersPerSecondSquared(10.23452), 1), MetersPerSecondSquared(10.2)
    )


def test_len() raises:
    assert_equal(len(MetersPerSecondSquared[Width=4](1, 2, 3, 4)), 4)


def test_intable() raises:
    assert_equal(Int(MetersPerSecondSquared(10.23)), 10)


def test_floatable() raises:
    assert_equal(Float64(MetersPerSecondSquared(10.23)), 10.23)


def test_neg() raises:
    assert_equal(-MetersPerSecondSquared(10), MetersPerSecondSquared(-10))


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
