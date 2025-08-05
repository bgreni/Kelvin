from .lexer import *
from kelvin.symbol import (
    Expr,
    UnaryOp,
    UnaryOpType,
    BinaryOp,
    BinaryOpType,
    Number,
    Symbol,
)


fn parse(s: String) raises -> Expr:
    var p = Parser(s)
    return p.parse()


struct Parser:
    var tokens: List[Token]
    var pos: Int

    var expr: String

    fn __init__(out self, expr: String):
        self.tokens = []
        self.pos = 0
        self.expr = expr

    fn curr_token(self) -> Optional[Token]:
        if self.pos < len(self.tokens):
            return self.tokens[self.pos]
        return None

    fn consume_token[Expected: Copyable & Movable](mut self) raises -> Token:
        var t = self.curr_token()

        if not t:
            raise "Unexpected end of expression"

        if not t.value().isa[Expected]():
            raise "Unexpected token type"

        self.pos += 1

        return t.value()

    fn consume_token(mut self) raises -> Token:
        var t = self.curr_token()
        if not t:
            raise "Unexpected end of expression"
        self.pos += 1

        return t.value()

    fn parse(mut self, out e: Expr) raises:
        self.tokens = lex(self.expr)
        e = self.parse_expression()

        if self.curr_token():
            raise "Unexpected token: " + String(self.curr_token().value())

    fn parse_expression(mut self) raises -> Expr:
        var left = self.parse_term()

        while (
            self.curr_token()
            and self.curr_token()[].one_of[AddToken, SubToken]()
        ):
            var op = self.consume_token()
            var right = self.parse_term()
            left = BinaryOp(
                left,
                BinaryOpType.Add if op.is_add() else BinaryOpType.Sub,
                right,
            )

        return left

    fn parse_term(mut self) raises -> Expr:
        var left = self.parse_power()

        while (
            self.curr_token()
            and self.curr_token()[].one_of[MultToken, DivToken]()
        ):
            var op = self.consume_token()
            var right = self.parse_power()
            return BinaryOp(
                left,
                BinaryOpType.Mult if op.is_mult() else BinaryOpType.Div,
                right,
            )

        return left

    fn parse_power(mut self) raises -> Expr:
        var left = self.parse_factor()

        var curr = self.curr_token()

        if curr and curr.value().is_power():
            self.pos += 1
            var right = self.parse_power()
            return BinaryOp(left, BinaryOpType.Pow, right)

        return left

    fn parse_factor(mut self) raises -> Expr:
        var tok_opt = self.curr_token()

        if not tok_opt:
            raise "Unexpected end of expression"

        var token = tok_opt.value()

        if token.is_sub():
            self.pos += 1
            return UnaryOp(UnaryOpType.Neg, self.parse_factor())

        elif token.is_add():
            self.pos += 1
            return self.parse_factor()

        elif token.is_number():
            return Number(self.consume_token().number().value)

        elif token.is_symbol():
            return Symbol(self.consume_token().symbol().value)

        elif token.is_lparen():
            self.pos += 1
            var result = self.parse_expression()
            _ = self.consume_token[RParenToken]()
            return result

        raise "Unexpected token: " + String(self.consume_token())
