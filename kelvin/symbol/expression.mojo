from utils import Variant
from .atom import *
from .binary_op import *
from .unary_op import *


struct Expr(
    Copyable, EqualityComparable, Movable, Representable, Stringable, Writable
):
    var value: Variant[Number, Symbol, BinaryOp, UnaryOp]

    @implicit
    fn __init__(out self, n: Number):
        self.value = n

    @implicit
    fn __init__(out self, a: BinaryOp):
        self.value = a

    @implicit
    fn __init__(out self, a: Symbol):
        self.value = a

    @implicit
    fn __init__(out self, a: UnaryOp):
        self.value = a

    fn is_atom(self) -> Bool:
        return self.is_number() or self.is_symbol()

    @always_inline
    fn is_number(self) -> Bool:
        return self.value.isa[Number]()

    @always_inline
    fn is_binary_op(self) -> Bool:
        return self.value.isa[BinaryOp]()

    @always_inline
    fn binary_op(self) -> BinaryOp:
        return self.value[BinaryOp]

    @always_inline
    fn is_unary_op(self) -> Bool:
        return self.value.isa[UnaryOp]()

    @always_inline
    fn unary_op(self) -> UnaryOp:
        return self.value[UnaryOp]

    @always_inline
    fn is_symbol(self) -> Bool:
        return self.value.isa[Symbol]()

    @always_inline
    fn symbol(self) -> Symbol:
        return self.value[Symbol]

    @always_inline
    fn number(self) -> Number:
        return self.value[Number]

    fn is_zero(self) -> Bool:
        return self.is_number() and self.number() == 0

    fn is_binary_add(self) -> Bool:
        return self.is_binary_op() and self.binary_op().is_add()

    fn write_to(self, mut writer: Some[Writer]):
        if self.is_number():
            writer.write(self.number())
        elif self.is_unary_op():
            writer.write(self.unary_op())
        elif self.is_binary_op():
            writer.write(self.binary_op())
        elif self.is_symbol():
            writer.write(self.symbol())
        else:
            abort("unreachable: no write branch for this type")

    fn __str__(self, out s: String):
        s = String()
        s.write(self)

    fn __repr__(self) -> String:
        return self.__str__()

    fn __eq__(self, other: Self) -> Bool:
        if self.value._get_discr() != other.value._get_discr():
            return False

        if self.is_number():
            return self.number() == other.number()
        elif self.is_symbol():
            return self.symbol() == other.symbol()
        elif self.is_binary_op():
            return self.binary_op() == other.binary_op()
        elif self.is_unary_op():
            return self.unary_op() == other.unary_op()

        return True

    fn __ne__(self, other: Self) -> Bool:
        return not self == other
