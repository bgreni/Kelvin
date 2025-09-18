from kelvin.symbol import *
from testing import *


def test_expand():
    var a = Symbol("a")
    var b = Symbol("b")
    var c = Symbol("c")

    var expr: Expr = Mul(Add(a.copy(), b.copy()), c.copy())
    var expected: Expr = Add(Mul(a.copy(), c.copy()), Mul(b.copy(), c.copy()))

    assert_equal(expected, expand(expr))

    expr = Mul(a.copy(), Add(b.copy(), c.copy()))
    expected = Add(Mul(a.copy(), b.copy()), Mul(a.copy(), c.copy()))
    assert_equal(expected, expand(expr))

    expr = UnaryOp(UnaryOpType.Neg, Mul(a.copy(), Add(b.copy(), c.copy())))
    expected = UnaryOp(
        UnaryOpType.Neg, Add(Mul(a.copy(), b.copy()), Mul(a.copy(), c.copy()))
    )
    assert_equal(expected, expand(expr))


def test_arithemtic_rules():
    var expr: Expr = Add(Number(3), Number(4))
    var expected: Expr = Number(7)
    assert_equal(expected, apply_arithmetic_rules(expr))

    expr: Expr = Mul(Number(3), Number(4))
    expected: Expr = Number(12)
    assert_equal(expected, apply_arithmetic_rules(expr))

    expr: Expr = Sub(Number(3), Number(4))
    expected: Expr = Number(-1)
    assert_equal(expected, apply_arithmetic_rules(expr))

    expr: Expr = Div(Number(12), Number(4))
    expected: Expr = Number(3)
    assert_equal(expected, apply_arithmetic_rules(expr))

    expr: Expr = Pow(Number(2), Number(4))
    expected: Expr = Number(16)
    assert_equal(expected, apply_arithmetic_rules(expr))

    # expr: Expr = parse("a + 4 * 3 - 7")
    # expected: Expr = Add(Symbol("a"), Number(5))
    # assert_equal(expected, apply_arithmetic_rules(expr))
