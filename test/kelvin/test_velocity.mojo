from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = MetersPerSecond(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = MetersPerSecond[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: MetersPerSecond[Width=4] = [1, 2, 3, 4]
    var d = MetersPerSecond[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)

    c[0] = 10
    assert_equal(c[0], 10)


def test_add():
    assert_equal(MetersPerSecond(10) + MetersPerSecond(5), MetersPerSecond(15))
    var s = MetersPerSecond(30)
    s += MetersPerSecond(20)
    assert_equal(s, MetersPerSecond(50))


def test_sub():
    assert_equal(MetersPerSecond(10) - MetersPerSecond(5), MetersPerSecond(5))
    var s = MetersPerSecond(30)
    s -= MetersPerSecond(20)
    assert_equal(s, MetersPerSecond(10))


def test_div():
    var a = MetersPerSecond(20) / MetersPerSecond(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_floordiv():
    var a = MetersPerSecond(5) // MetersPerSecond(2)
    assert_equal(a.value(), 2.0)


# def test_ceildiv():
# var a = MetersPerSecond(5).__ceildiv__(MetersPerSecond(2))
# assert_equal(a.value(), 3.0)


def test_mul():
    var a = MetersPerSecond(20) * MetersPerSecond(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(MetersPerSecond(10)), "10.0 m^1 s^-1")


def test_eq():
    assert_equal(MetersPerSecond(10), MetersPerSecond(10))
    assert_not_equal(MetersPerSecond(10), MetersPerSecond(20))


def test_scalar_arithmetic():
    var a = MetersPerSecond(10)
    assert_equal(a * 5, MetersPerSecond(50))
    a *= 5
    assert_equal(a, MetersPerSecond(50))
    assert_equal(a / 5, MetersPerSecond(10))
    a /= 5
    assert_equal(a, MetersPerSecond(10))

    a = MetersPerSecond(10)
    assert_equal(5 * a, MetersPerSecond(50))
    assert_equal(20 / a, Quantity[-MetersPerSecond.D](2))


def test_bool():
    assert_true(Bool(MetersPerSecond(10)))
    assert_false(Bool(MetersPerSecond(0)))

    if not MetersPerSecond(10):
        assert_true(False)

    if MetersPerSecond(0):
        assert_true(False)


def test_compare():
    assert_true(MetersPerSecond(10) == MetersPerSecond(10))
    assert_true(MetersPerSecond(10) < MetersPerSecond(20))
    assert_true(MetersPerSecond(20) > MetersPerSecond(10))
    assert_true(MetersPerSecond(10) <= MetersPerSecond(10))
    assert_true(MetersPerSecond(10) <= MetersPerSecond(20))
    assert_true(MetersPerSecond(10) >= MetersPerSecond(10))
    assert_true(MetersPerSecond(20) >= MetersPerSecond(10))

    comptime T = MetersPerSecond[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))


def test_simd():
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = MetersPerSecond[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains():
    comptime V = MetersPerSecond[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs():
    assert_equal(abs(MetersPerSecond(-10)), MetersPerSecond(10))


def test_trunc():
    assert_equal(trunc(MetersPerSecond(10.231)), MetersPerSecond(10))


def test_ceil():
    assert_equal(ceil(MetersPerSecond(10.231)), MetersPerSecond(11))


def test_floor():
    assert_equal(floor(MetersPerSecond(10.531)), MetersPerSecond(10))


def test_round():
    assert_equal(round(MetersPerSecond(10.2)), MetersPerSecond(10))
    assert_equal(round(MetersPerSecond(10.23452), 1), MetersPerSecond(10.2))


def test_len():
    assert_equal(len(MetersPerSecond[Width=4](1, 2, 3, 4)), 4)


def test_intable():
    assert_equal(Int(MetersPerSecond(10.23)), 10)


def test_floatable():
    assert_equal(Float64(MetersPerSecond(10.23)), 10.23)


def test_neg():
    assert_equal(-MetersPerSecond(10), MetersPerSecond(-10))


def test_cast():
    var a = MetersPerSecond(cast_from=MilesPerHour(10))
    assert_equal(a.value(), 4.4704)


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
