from kelvin import *
from testing import assert_equal


def test_simplify():
    def _test[N1: UInt, D1: UInt, N2: UInt, D2: UInt]():
        var r1 = Ratio[N1, D1]()
        assert_equal(r1.N, N1)
        assert_equal(r1.D, D1)
        var r2 = r1.simplify()
        assert_equal(r2.N, N2)
        assert_equal(r2.D, D2)

    _test[2, 4, 1, 2]()
    _test[4, 2, 2, 1]()
    _test[4, 4, 1, 1]()
    _test[1, 1, 1, 1]()
    _test[3, 4, 3, 4]()
    _test[4, 3, 4, 3]()
    _test[10 * 4, 10 * 3, 4, 3]()
    _test[10 * 3, 10 * 4, 3, 4]()


def test_add():
    assert_equal(
        String((Ratio[2, 3]() + Ratio[1, 3]()).simplify()),
        String(Ratio[1, 1]()),
    )
    assert_equal(
        String((Ratio[2, 3]() + Ratio[3, 1]()).simplify()),
        String(Ratio[11, 3]()),
    )
    assert_equal(
        String((Ratio[2, 3]() + Ratio[3, 2]()).simplify()),
        String(Ratio[13, 6]()),
    )
    assert_equal(
        String((Ratio[2 * 3, 3 * 5]() + Ratio[2, 5]()).simplify()),
        String(Ratio[4, 5]()),
    )


def test_multiply():
    assert_equal(
        String((Ratio[2, 3]() * Ratio[1, 3]()).simplify()),
        String(Ratio[2, 9]()),
    )
    assert_equal(
        String((Ratio[2, 3]() * Ratio[3, 1]()).simplify()),
        String(Ratio[2, 1]()),
    )
    assert_equal(
        String((Ratio[2, 3]() * Ratio[3, 2]()).simplify()),
        String(Ratio[1, 1]()),
    )
    assert_equal(
        String((Ratio[2 * 3, 3 * 5]() * Ratio[5, 2]()).simplify()),
        String(Ratio[1, 1]()),
    )
