from kelvin import *
from testing import *


def test_ctor():
    var a = Candela(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Candela[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Candela(10) + Candela(5), Candela(15))
    var s = Candela(30)
    s += Candela(20)
    assert_equal(s, Candela(50))


def test_sub():
    assert_equal(Candela(10) - Candela(5), Candela(5))
    var s = Candela(30)
    s -= Candela(20)
    assert_equal(s, Candela(10))


# def test_div():
#     var a = Candela(20) / Candela(10)
#     assert_equal(a.value(), 2.0)
#     assert_equal(String(a), '2.0')

# def test_mul():
#     var a = Candela(20) * Candela(2)
#     assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Candela(10)), "10.0 cd^1")


# def test_eq():
#     assert_equal(Candela(10), Candela(10))
#     assert_not_equal(Candela(10), Candela(20))
