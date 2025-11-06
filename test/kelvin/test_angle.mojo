from kelvin import *
from testing import *


def test_ctor():
    assert_equal(Radian(10).value(), 10.0)


def test_add():
    assert_equal(Radian(20) + Radian(10), Radian(30))

    var r = Radian(20)
    r += Radian(15)
    assert_equal(r, Radian(35))


def test_sub():
    assert_equal(Radian(14) - Radian(10), Radian(4))

    var r = Radian(30)
    r -= Radian(10)
    assert_equal(r, Radian(20))


def test_cast():
    assert_equal(Radian(cast_from=Degree(70)), Radian(1.22173058013766))
    assert_equal(Degree(cast_from=Radian(2)), Degree(114.59154929577464))


def test_str():
    assert_equal(String(Radian(10)), "10.0 rad")
    assert_equal(String(Degree(30)), "30.0 °")
    assert_equal(String(Radian(30) / Meter(5)), "6.0 m^-1 rad")
    assert_equal(String(Radian.D * Second.D), " s^1 rad")


def main():
    var s = TestSuite.discover_tests[__functions_in_module()]()
    print(s.generate_report())
