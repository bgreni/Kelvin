from kelvin import *
from std.testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor() raises:
    var a = MetersSquared(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = MetersSquared[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: MetersSquared[Width=4] = [1, 2, 3, 4]
    var d = MetersSquared[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


def test_add() raises:
    assert_equal(MetersSquared(10) + MetersSquared(5), MetersSquared(15))
    var s = MetersSquared(30)
    s += MetersSquared(20)
    assert_equal(s, MetersSquared(50))


def test_sub() raises:
    assert_equal(MetersSquared(10) - MetersSquared(5), MetersSquared(5))
    var s = MetersSquared(30)
    s -= MetersSquared(20)
    assert_equal(s, MetersSquared(10))


def test_div() raises:
    var a = MetersSquared(20) / MetersSquared(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_floordiv() raises:
    var a = MetersSquared(5) // MetersSquared(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv() raises:
# var a = MetersSquared(5).__ceildiv__(MetersSquared(2))
# assert_equal(a.value(), 3.0)


def test_mul() raises:
    var a = MetersSquared(20) * MetersSquared(2)
    assert_equal(a.value(), 40.0)


def test_str() raises:
    assert_equal(String(MetersSquared(10)), "10.0 m^2")


def test_eq() raises:
    assert_equal(MetersSquared(10), MetersSquared(10))
    assert_not_equal(MetersSquared(10), MetersSquared(20))


def test_scalar_arithmetic() raises:
    var a = MetersSquared(10)
    assert_equal(a * 5, MetersSquared(50))
    a *= 5
    assert_equal(a, MetersSquared(50))
    assert_equal(a / 5, MetersSquared(10))
    a /= 5
    assert_equal(a, MetersSquared(10))

    a = MetersSquared(10)
    assert_equal(5 * a, MetersSquared(50))
    assert_equal(20 / a, Quantity[-MetersSquared.D](2))


def test_bool() raises:
    assert_true(Bool(MetersSquared(10)))
    assert_false(Bool(MetersSquared(0)))

    if not MetersSquared(10):
        assert_true(False)

    if MetersSquared(0):
        assert_true(False)


def test_compare() raises:
    assert_true(MetersSquared(10) == MetersSquared(10))
    assert_true(MetersSquared(10) < MetersSquared(20))
    assert_true(MetersSquared(20) > MetersSquared(10))
    assert_true(MetersSquared(10) <= MetersSquared(10))
    assert_true(MetersSquared(10) <= MetersSquared(20))
    assert_true(MetersSquared(10) >= MetersSquared(10))
    assert_true(MetersSquared(20) >= MetersSquared(10))

    comptime T = MetersSquared[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd() raises:
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = MetersSquared[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains() raises:
    comptime V = MetersSquared[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs() raises:
    assert_equal(abs(MetersSquared(-10)), MetersSquared(10))


def test_trunc() raises:
    assert_equal(trunc(MetersSquared(10.231)), MetersSquared(10))


def test_ceil() raises:
    assert_equal(ceil(MetersSquared(10.231)), MetersSquared(11))


def test_floor() raises:
    assert_equal(floor(MetersSquared(10.531)), MetersSquared(10))


def test_round() raises:
    assert_equal(round(MetersSquared(10.2)), MetersSquared(10))
    assert_equal(round(MetersSquared(10.23452), 1), MetersSquared(10.2))


def test_len() raises:
    assert_equal(len(MetersSquared[Width=4](1, 2, 3, 4)), 4)


def test_intable() raises:
    assert_equal(Int(MetersSquared(10.23)), 10)


def test_floatable() raises:
    assert_equal(Float64(MetersSquared(10.23)), 10.23)


def test_neg() raises:
    assert_equal(-MetersSquared(10), MetersSquared(-10))


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
