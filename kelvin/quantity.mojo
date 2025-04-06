from .ratio import *


@value
@register_passable("trivial")
struct Dimensions[
    L: IntLiteral,
    M: IntLiteral,
    T: IntLiteral,
    EC: IntLiteral,
    TH: IntLiteral,
    A: IntLiteral,
    CD: IntLiteral,
]:
    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __eq__(self, o: Dimensions) -> Bool:
        return (
            L == o.L
            and M == o.M
            and T == o.T
            and EC == o.EC
            and TH == o.TH
            and A == o.A
            and CD == o.CD
        )

    @always_inline("builtin")
    fn __ne__(self, o: Dimensions) -> Bool:
        return not self == o

    @always_inline("builtin")
    fn __truediv__[
        OL: IntLiteral,
        OM: IntLiteral,
        OT: IntLiteral,
        OEC: IntLiteral,
        OTH: IntLiteral,
        OA: IntLiteral,
        OCD: IntLiteral,
    ](
        self,
        other: Dimensions[OL, OM, OT, OEC, OTH, OA, OCD],
        out result: Dimensions[
            L - OL, M - OM, T - OT, EC - OEC, TH - OTH, A - OA, CD - OCD
        ],
    ):
        return __type_of(result)()

    @always_inline("builtin")
    fn __mul__[
        OL: IntLiteral,
        OM: IntLiteral,
        OT: IntLiteral,
        OEC: IntLiteral,
        OTH: IntLiteral,
        OA: IntLiteral,
        OCD: IntLiteral,
    ](
        self,
        other: Dimensions[OL, OM, OT, OEC, OTH, OA, OCD],
        out result: Dimensions[
            L + OL, M + OM, T + OT, EC + OEC, TH + OTH, A + OA, CD + OCD
        ],
    ):
        return __type_of(result)()

    @always_inline("builtin")
    fn __pow__(
        self,
        p: IntLiteral[_],
        out result: Dimensions[
            __type_of(L * p)(),
            __type_of(M * p)(),
            __type_of(T * p)(),
            __type_of(EC * p)(),
            __type_of(TH * p)(),
            __type_of(A * p)(),
            __type_of(CD * p)(),
        ],
    ):
        return __type_of(result)()

    fn write_to[W: Writer](self, mut writer: W):
        @parameter
        if L:
            writer.write(" m^", L)

        @parameter
        if M:
            writer.write(" kg^", M)

        @parameter
        if T:
            writer.write(" s^", T)

        @parameter
        if EC:
            writer.write(" A^", EC)

        @parameter
        if TH:
            writer.write(" K^", TH)

        @parameter
        if A:
            writer.write(" mol^", A)

        @parameter
        if CD:
            writer.write(" cd^", CD)


@value
@register_passable("trivial")
struct Quantity[D: Dimensions, DT: DType = DType.float64](
    EqualityComparableCollectionElement, Writable, Stringable
):
    alias DataType = Scalar[DT]
    var _value: Self.DataType

    @always_inline
    fn __init__(out self, v: Self.DataType):
        self._value = v

    @always_inline
    @implicit
    fn __init__(out self, other: Quantity[DT = Self.DT]):
        constrained[
            Self.D == other.D,
            String.write("expected dimensions", Self.D, " received ", other.D),
        ]()
        self._value = other._value

    @always_inline
    fn __truediv__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D / OD, DT]):
        @parameter
        if DT.is_integral():
            return __type_of(res)(self._value // other._value)
        else:
            return __type_of(res)(self._value / other._value)

    @always_inline
    fn __mul__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D * OD, DT]):
        return __type_of(res)(self._value * other._value)

    @always_inline
    fn __add__(self, other: Self) -> Self:
        return Self(self._value + other._value)

    @always_inline
    fn __iadd__(mut self, other: Self):
        self._value += other._value

    @always_inline
    fn __sub__(self, other: Self) -> Self:
        return Self(self._value - other._value)

    @always_inline
    fn __isub__(mut self, other: Self):
        self._value -= other._value

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
        writer.write(D)
