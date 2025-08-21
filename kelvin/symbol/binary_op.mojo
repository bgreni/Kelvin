from memory import ArcPointer
from .expression import Expr
from os import abort


fn Add(var left: Expr, var right: Expr) -> BinaryOp:
    return BinaryOp(left, BinaryOpType.Add, right)


fn Sub(var left: Expr, var right: Expr) -> BinaryOp:
    return BinaryOp(left, BinaryOpType.Sub, right)


fn Mul(var left: Expr, var right: Expr) -> BinaryOp:
    return BinaryOp(left, BinaryOpType.Mult, right)


fn Div(var left: Expr, var right: Expr) -> BinaryOp:
    return BinaryOp(left, BinaryOpType.Div, right)


fn Pow(var left: Expr, var right: Expr) -> BinaryOp:
    return BinaryOp(left, BinaryOpType.Pow, right)


@fieldwise_init
@register_passable("trivial")
struct BinaryOpType(Copyable, Movable, Writable):
    var value: Int

    alias Add = BinaryOpType(0)
    alias Sub = BinaryOpType(1)
    alias Mult = BinaryOpType(2)
    alias Div = BinaryOpType(3)
    alias Pow = BinaryOpType(4)

    fn __eq__(self, other: Self) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn write_to(self, mut writer: Some[Writer]):
        if self == Self.Add:
            writer.write("+")
        elif self == Self.Sub:
            writer.write("-")
        elif self == Self.Mult:
            writer.write("*")
        elif self == Self.Div:
            writer.write("/")
        elif self == Self.Pow:
            writer.write("**")


struct BinaryOp(Copyable, EqualityComparable, Movable, Writable):
    var left_expr: ArcPointer[Expr]
    var op: BinaryOpType
    var right_expr: ArcPointer[Expr]

    fn __init__(out self, var l: Expr, op: BinaryOpType, var r: Expr):
        self.left_expr = ArcPointer(l^)
        self.right_expr = ArcPointer(r^)
        self.op = op

    fn left(self) -> ref [self.left_expr] Expr:
        return self.left_expr[]

    fn right(self) -> ref [self.right_expr] Expr:
        return self.right_expr[]

    fn is_add(self) -> Bool:
        return self.op == BinaryOpType.Add

    fn is_sub(self) -> Bool:
        return self.op == BinaryOpType.Sub

    fn is_mult(self) -> Bool:
        return self.op == BinaryOpType.Mult

    fn is_div(self) -> Bool:
        return self.op == BinaryOpType.Div

    fn is_pow(self) -> Bool:
        return self.op == BinaryOpType.Pow

    fn __eq__(self, other: Self) -> Bool:
        return (
            self.left() == other.left()
            and self.right() == other.right()
            and self.op == other.op
        )

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn write_to(self, mut writer: Some[Writer]):
        writer.write(self.left())
        writer.write(self.op)
