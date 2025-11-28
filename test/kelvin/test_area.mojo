from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
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


def test_add():
    assert_equal(MetersSquared(10) + MetersSquared(5), MetersSquared(15))
    var s = MetersSquared(30)
    s += MetersSquared(20)
    assert_equal(s, MetersSquared(50))


def test_sub():
    assert_equal(MetersSquared(10) - MetersSquared(5), MetersSquared(5))
    var s = MetersSquared(30)
    s -= MetersSquared(20)
    assert_equal(s, MetersSquared(10))


def test_div():
    var a = MetersSquared(20) / MetersSquared(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = MetersSquared(20) * MetersSquared(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(MetersSquared(10)), "10.0 m^2")


def test_eq():
    assert_equal(MetersSquared(10), MetersSquared(10))
    assert_not_equal(MetersSquared(10), MetersSquared(20))


def test_scalar_arithmetic():
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


def test_bool():
    assert_true(Bool(MetersSquared(10)))
    assert_false(Bool(MetersSquared(0)))

    if not MetersSquared(10):
        assert_true(False)

    if MetersSquared(0):
        assert_true(False)


def test_compare():
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


def test_simd():
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = MetersSquared[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_contains():
    comptime V = MetersSquared[Width=4]
    assert_true(10 in V(1, 10, 2, 4))
    assert_false(20 in V(1, 2, 3, 4))


def test_abs():
    assert_equal(abs(MetersSquared(-10)), MetersSquared(10))


def test_trunc():
    assert_equal(trunc(MetersSquared(10.231)), MetersSquared(10))


def test_ceil():
    assert_equal(ceil(MetersSquared(10.231)), MetersSquared(11))


def test_floor():
    assert_equal(floor(MetersSquared(10.531)), MetersSquared(10))


# def test_ceildiv(): # Doesn't work with the CeilDivable trait yet
#   assert_equal(ceildiv(MetersSquared(5), MetersSquared(2)).value(), 3)


def test_round():
    assert_equal(round(MetersSquared(10.2)), MetersSquared(10))
    assert_equal(round(MetersSquared(10.23452), 1), MetersSquared(10.2))


def test_len():
    assert_equal(len(MetersSquared[Width=4](1, 2, 3, 4)), 4)


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
