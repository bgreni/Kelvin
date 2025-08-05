from testing import *
from kelvin.symbol.parser.lexer import *


def test_add():
    var a = "2 + 5 + 1"
    var expected = List[Token](
        NumberToken(2), AddToken(), NumberToken(5), AddToken(), NumberToken(1)
    )

    var actual = lex(a)
    assert_equal(expected, actual)


def test_sub():
    var a = "2 - 5 - 123"
    var expected = List[Token](
        NumberToken(2), SubToken(), NumberToken(5), SubToken(), NumberToken(123)
    )

    var actual = lex(a)
    assert_equal(expected, actual)


def test_power():
    var a = "a^2"
    var expected = List[Token](SymbolToken("a"), PowerToken(), NumberToken(2))

    var actual = lex(a)
    assert_equal(expected, actual)


def test_mult():
    var a = "2 * 12 * 41"
    var expected = List[Token](
        NumberToken(2),
        MultToken(),
        NumberToken(12),
        MultToken(),
        NumberToken(41),
    )

    var actual = lex(a)
    assert_equal(expected, actual)


def test_div():
    var a = "2 / 12 / 41"
    var expected = List[Token](
        NumberToken(2), DivToken(), NumberToken(12), DivToken(), NumberToken(41)
    )

    var actual = lex(a)
    assert_equal(expected, actual)


def test_symbol():
    var a = "a + b"
    var expected = List[Token](SymbolToken("a"), AddToken(), SymbolToken("b"))

    var actual = lex(a)
    assert_equal(expected, actual)


def test_with_parens():
    var a = "(1 + 2) * b"
    var expected = List[Token](
        LParenToken(),
        NumberToken(1),
        AddToken(),
        NumberToken(2),
        RParenToken(),
        MultToken(),
        SymbolToken("b"),
    )

    var actual = lex(a)
    assert_equal(expected, actual)
