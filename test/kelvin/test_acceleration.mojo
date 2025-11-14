from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT


def test_ctor():
    var a = MetersPerSecondSquared(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = MetersPerSecondSquared[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(
        MetersPerSecondSquared(10) + MetersPerSecondSquared(5),
        MetersPerSecondSquared(15),
    )
    var s = MetersPerSecondSquared(30)
    s += MetersPerSecondSquared(20)
    assert_equal(s, MetersPerSecondSquared(50))


def test_sub():
    assert_equal(
        MetersPerSecondSquared(10) - MetersPerSecondSquared(5),
        MetersPerSecondSquared(5),
    )
    var s = MetersPerSecondSquared(30)
    s -= MetersPerSecondSquared(20)
    assert_equal(s, MetersPerSecondSquared(10))


def test_div():
    var a = MetersPerSecondSquared(20) / MetersPerSecondSquared(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = MetersPerSecondSquared(20) * MetersPerSecondSquared(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(MetersPerSecondSquared(10)), "10.0 m^1 s^-2")


def test_eq():
    assert_equal(MetersPerSecondSquared(10), MetersPerSecondSquared(10))
    assert_not_equal(MetersPerSecondSquared(10), MetersPerSecondSquared(20))


def test_scalar_arithmetic():
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


def test_bool():
    assert_true(Bool(MetersPerSecondSquared(10)))
    assert_false(Bool(MetersPerSecondSquared(0)))

    if not MetersPerSecondSquared(10):
        assert_true(False)

    if MetersPerSecondSquared(0):
        assert_true(False)


def test_compare():
    assert_true(MetersPerSecondSquared(10) == MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(10) < MetersPerSecondSquared(20))
    assert_true(MetersPerSecondSquared(20) > MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(10) <= MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(10) <= MetersPerSecondSquared(20))
    assert_true(MetersPerSecondSquared(10) >= MetersPerSecondSquared(10))
    assert_true(MetersPerSecondSquared(20) >= MetersPerSecondSquared(10))


def test_simd():
    alias Vec = SIMD[DType.int64, 4]
    alias S = MetersPerSecondSquared[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
