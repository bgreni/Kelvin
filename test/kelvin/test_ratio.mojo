from kelvin import *
from testing import assert_equal


def test_simplify():
    def _test[N1: IntLiteral, D1: IntLiteral, N2: IntLiteral, D2: IntLiteral]():
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
    assert_equal(String(Ratio.Invalid + Ratio[1, 2]()), String(Ratio[1, 2]()))
    assert_equal(String(Ratio[1, 2]() + Ratio.Invalid), String(Ratio[1, 2]()))


def test_ratio_mul():
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


def test_scalar_mul():
    assert_equal(Float64(1) * Ratio[1, 2](), 0.5)
    assert_equal(Int64(1) * Ratio[1, 2](), 0)
    assert_equal(Float64(3) * Ratio[1, 2](), 1.5)
    assert_equal(Int64(2) * Ratio[1, 2](), 1)

    # int rounding behavior
    assert_equal(Ratio[999, 1000]() * Int64(1), 0)
    assert_equal(Ratio[3, 2]() * Int64(1), 1)
    assert_equal(Ratio[3 * 999, 2 * 1000]() * Int64(1), 1)


# def test_pow():
#     assert_equal(String(Ratio[2, 3]() ** 1), String(Ratio[2, 3]()))
#     assert_equal(String(Ratio[2, 3]() ** 2), String(Ratio[4, 9]()))
#     assert_equal(String(Ratio[2, 3]() ** 0), String(Ratio[1, 1]()))
#     assert_equal(String(Ratio[2, 3]() ** -1), String(Ratio[3, 2]()))
#     assert_equal(String(Ratio[2, 3]() ** -2), String(Ratio[9, 4]()))


def test_ratio_div():
    assert_equal(
        String((Ratio[2, 3]() / Ratio[3, 1]()).simplify()),
        String(Ratio[2, 9]()),
    )
    assert_equal(
        String((Ratio[2, 3]() / Ratio[1, 3]()).simplify()),
        String(Ratio[2, 1]()),
    )
    assert_equal(
        String((Ratio[2, 3]() / Ratio[2, 3]()).simplify()),
        String(Ratio[1, 1]()),
    )
    assert_equal(
        String((Ratio[2 * 3, 3 * 5]() / Ratio[2, 5]()).simplify()),
        String(Ratio[1, 1]()),
    )


def test_scalar_div():
    # truediv
    assert_equal(Ratio[1, 2]() / Float64(1), 0.5)
    assert_equal(Ratio[1, 2]() / Int64(1), 0)
    assert_equal(Ratio[9, 2]() / Float64(3), 1.5)
    assert_equal(Ratio[12, 2]() / Int64(3), 2)
    assert_equal(Ratio[6, 3]() / Int64(2), 1)

    # rtruediv
    assert_equal(Float64(1) / Ratio[2, 1](), 0.5)
    assert_equal(Int64(1) / Ratio[2, 1](), 0)
    assert_equal(Float64(3) / Ratio[2, 1](), 1.5)
    assert_equal(Int64(3) / Ratio[3, 2](), 2)
    assert_equal(Int64(2) / Ratio[2, 1](), 1)

    # int rounding behavior
    assert_equal(Ratio[999, 1000]() / Int64(1), 0)
    assert_equal(Ratio[3, 2]() / Int64(1), 1)
    assert_equal(Ratio[3 * 999, 2 * 1000]() / Int64(1), 1)


def test_or():
    var r1 = Ratio.Invalid
    var r2 = Ratio[1, 2]()
    assert_equal(String(r1 | r2), String(r2))
    assert_equal(String(r2 | r1), String(r2))
    assert_equal(String(r2 | r2), String(r2))
