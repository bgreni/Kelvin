from .expression import Expr
from memory import ArcPointer


@fieldwise_init
@register_passable("trivial")
struct UnaryOpType(Copyable, EqualityComparable, Movable, Writable):
    var value: Int

    alias Neg = UnaryOpType(0)

    fn __eq__(self, other: Self) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn write_to[W: Writer](self, mut writer: W):
        if self == Self.Neg:
            writer.write("-")


@fieldwise_init
struct UnaryOp(Copyable, EqualityComparable, Movable, Writable):
    var op: UnaryOpType
    var _expr: ArcPointer[Expr]

    fn __init__(out self, op: UnaryOpType, owned expr: Expr):
        self.op = op
        self._expr = ArcPointer(expr^)

    fn __eq__(self, other: Self) -> Bool:
        return self.op == other.op and self._expr[] == other._expr[]

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn is_neg(self) -> Bool:
        return self.op == UnaryOpType.Neg

    fn expr(self) -> ref [self._expr] Expr:
        return self._expr[]

    fn simplify(self) -> Expr:
        if self.expr().is_number():
            return Number(-self.expr().number().value)
        return self

    fn write_to[W: Writer](self, mut writer: W):
        writer.write(self.op)
        writer.write(self.expr())
