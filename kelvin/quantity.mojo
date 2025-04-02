from .common import *

@register_passable("trivial")
struct Dimensions[L: IntLiteral, T: IntLiteral]:

    @always_inline("builtin")
    fn __init__(out self:Dimensions[L, T]): pass

    @always_inline("builtin")
    fn __sub__[
        OL: IntLiteral,
        OT: IntLiteral
    ](
        self,
        other: Dimensions[OL, OT],
        out result: Dimensions[L - OL, T - OT]):
        return __type_of(result)()

    @always_inline("builtin")
    fn __add__[
        OL: IntLiteral,
        OT: IntLiteral
    ](
        self,
        other: Dimensions[OL, OT],
        out result: Dimensions[L + OL, T + OT]):
        return __type_of(result)()

@value
@register_passable("trivial")
struct Quantity[D: Dimensions, DT: DType=DType.float64](EqualityComparableCollectionElement, Writable, Stringable):
    alias DataType = Scalar[DT]
    var _value: Self.DataType

    @always_inline
    fn __init__(out self, v: Self.DataType):
        self._value = v

    @always_inline
    fn __truediv__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D-OD, DT]):
        @parameter
        if DT.is_integral():
            return __type_of(res)(self._value // other._value)
        else:
            return __type_of(res)(self._value / other._value)

    @always_inline
    fn __mul__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D+OD, DT]):
        return __type_of(res)(self._value * other._value)

    @always_inline
    fn __add__(self, other: Self) -> Self:
        return Self(self._value + other._value)

    @always_inline
    fn __iadd__(mut self, other: Self):
        self._value += other._value

    @always_inline
    fn __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    fn __ne__(self, other: Self) -> Bool:
        return self._value != other._value

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)

    fn write_to[W: Writer](self, mut writer: W):
        writer.write(self._value)
        @parameter
        if D.L:
            writer.write(' m^', D.L)
        @parameter
        if D.T:
            writer.write(' s^', D.T)


