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


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = MetersPerSecond[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def test_cast():
    var a = MetersPerSecond(cast_from=MilesPerHour(10))
    assert_equal(a.value(), 4.4704)
