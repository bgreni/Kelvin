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
