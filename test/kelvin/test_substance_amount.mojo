from kelvin import *
from testing import *


def test_ctor():
    var a = Mole(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = Mole[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)


def test_add():
    assert_equal(Mole(10) + Mole(5), Mole(15))
    var s = Mole(30)
    s += Mole(20)
    assert_equal(s, Mole(50))


def test_sub():
    assert_equal(Mole(10) - Mole(5), Mole(5))
    var s = Mole(30)
    s -= Mole(20)
    assert_equal(s, Mole(10))


def test_div():
    var a = Mole(20) / Mole(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), "2.0")


def test_mul():
    var a = Mole(20) * Mole(2)
    assert_equal(a.value(), 40.0)


def test_str():
    assert_equal(String(Mole(10)), "10.0 mol^1")


def test_eq():
    assert_equal(Mole(10), Mole(10))
    assert_not_equal(Mole(10), Mole(20))
