from kelvin.symbol.parser import *
from kelvin.symbol import *
from testing import *


def test_add():
    var p = Parser("1 + 2")
    var expected = Expr(BinaryOp(Number(1), BinaryOpType.Add, Number(2)))

    var actual = p.parse()

    assert_equal(expected, actual)


def test_mult():
    var p = Parser("1 + 2 * 4")
    var expected = Expr(
        BinaryOp(
            Number(1),
            BinaryOpType.Add,
            BinaryOp(Number(2), BinaryOpType.Mult, Number(4)),
        )
    )

    var actual = p.parse()

    assert_equal(expected, actual)


def test_paren():
    var p = Parser("(1 + 2) * 4")
    var expected = Expr(
        BinaryOp(
            BinaryOp(Number(1), BinaryOpType.Add, Number(2)),
            BinaryOpType.Mult,
            Number(4),
        )
    )

    var actual = p.parse()

    assert_equal(expected, actual)


def test_power():
    var p = Parser("1 ^ 2 ^ 3")
    var expected = Expr(
        BinaryOp(
            Number(1),
            BinaryOpType.Pow,
            BinaryOp(Number(2), BinaryOpType.Pow, Number(3)),
        )
    )

    var actual = p.parse()

    assert_equal(expected, actual)


def test_unary():
    var p = Parser("1 + -4")
    var expected = Expr(
        BinaryOp(
            Number(1), BinaryOpType.Add, UnaryOp(UnaryOpType.Neg, Number(4))
        )
    )

    var actual = p.parse()

    assert_equal(expected, actual)
