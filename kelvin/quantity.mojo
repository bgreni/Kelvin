from .common import *


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
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    L.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    M.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    T.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    EC.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    TH.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    A.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
            IntLiteral[
                __mlir_attr[
                    `#pop<int_literal_bin<mul `,
                    CD.value,
                    `,`,
                    p.value,
                    `>> : !pop.int_literal`,
                ]
            ](),
        ],
    ):
        return __type_of(result)()


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

        @parameter
        if D.L:
            writer.write(" m^", D.L)
        elif D.M:
            writer.write(" kg^", D.M)
        elif D.T:
            writer.write(" s^", D.T)
        elif D.EC:
            writer.write(" A^", D.EC)
        elif D.TH:
            writer.write(" K^", D.TH)
        elif D.A:
            writer.write(" mol^", D.A)
        elif D.CD:
            writer.write(" cd^", D.CD)
