from .ratio import Ratio, B


@value
@register_passable("trivial")
struct Dimension[Z: IntLiteral, R: Ratio, suffix: String]:
    alias Invalid = Dimension[0, Ratio.Invalid, ""]()

    @always_inline
    fn __eq__(self, other: Dimension) -> Bool:
        return Z == other.Z and R == other.R

    @always_inline
    fn __ne__(self, other: Dimension) -> Bool:
        return not self == other

    @always_inline
    fn __sub__(
        self,
        other: Dimension,
        # TODO: This is a little sketchy for the suffix
        out res: Dimension[
            Z - other.Z,
            (B[R]() * R) | (B[other.R]() * other.R),
            suffix or other.suffix,
        ],
    ):
        _same_scale_or_one_null_check[R, other.R]()
        return __type_of(res)()

    @always_inline
    fn __add__(
        self,
        other: Dimension,
        out res: Dimension[
            Z + other.Z,
            (B[R]() * R) | (B[other.R]() * other.R),
            suffix or other.suffix,
        ],
    ):
        _same_scale_or_one_null_check[R, other.R]()
        return __type_of(res)()

    @always_inline
    fn __mul__(
        self, m: IntLiteral, out res: Dimension[Z * __type_of(m)(), R, suffix]
    ):
        return __type_of(res)()

    @always_inline
    fn __bool__(self) -> Bool:
        return Z != 0

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(" ", suffix, "^", Z)


@value
@register_passable("trivial")
struct Dimensions[
    L: Dimension,
    M: Dimension,
    T: Dimension,
    EC: Dimension,
    TH: Dimension,
    A: Dimension,
    CD: Dimension,
]:
    @always_inline
    fn __eq__(self, O: Dimensions) -> Bool:
        return (
            L == O.L
            and M == O.M
            and T == O.T
            and EC == O.EC
            and TH == O.TH
            and A == O.A
            and CD == O.CD
        )

    @always_inline
    fn __ne__(self, O: Dimensions) -> Bool:
        return not self == O

    @always_inline
    fn __truediv__[
        OL: Dimension,
        OM: Dimension,
        OT: Dimension,
        OEC: Dimension,
        OTH: Dimension,
        OA: Dimension,
        OCD: Dimension,
    ](
        self,
        other: Dimensions[OL, OM, OT, OEC, OTH, OA, OCD],
        out result: Dimensions[
            L - OL, M - OM, T - OT, EC - OEC, TH - OTH, A - OA, CD - OCD
        ],
    ):
        return __type_of(result)()

    @always_inline
    fn __mul__[
        OL: Dimension,
        OM: Dimension,
        OT: Dimension,
        OEC: Dimension,
        OTH: Dimension,
        OA: Dimension,
        OCD: Dimension,
    ](
        self,
        other: Dimensions[OL, OM, OT, OEC, OTH, OA, OCD],
        out result: Dimensions[
            L + OL, M + OM, T + OT, EC + OEC, TH + OTH, A + OA, CD + OCD
        ],
    ):
        return __type_of(result)()

    @always_inline
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
        @always_inline
        fn write[W: Writer, //, Dim: Dimension](mut writer: W):
            @parameter
            if Dim:
                writer.write(Dim)

        write[L](writer)
        write[M](writer)
        write[T](writer)
        write[EC](writer)
        write[TH](writer)
        write[A](writer)
        write[CD](writer)


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
        """This exists to give a more helpful error message when one tries to use the
        wrong type implicitly.
        """
        constrained[
            Self.D == other.D,
            String.write("expected dimensions", Self.D, " received ", other.D),
        ]()
        self._value = other._value

    fn __init__(out self, *, cast_from: Quantity[DT = Self.DT]):
        _dimension_space_check[D, cast_from.D]()
        var val = cast_from.value()

        alias OD = cast_from.D

        alias LR = (OD.L.R / D.L.R)
        alias MR = (OD.M.R / D.M.R)
        alias TR = (OD.T.R / D.T.R)
        alias ECR = (OD.EC.R / D.EC.R)
        alias THR = (OD.TH.R / D.TH.R)
        alias AR = (OD.A.R / D.A.R)
        alias CDR = (OD.CD.R / D.CD.R)

        val = _scale_value[D.L.Z, LR](val)
        val = _scale_value[D.M.Z, MR](val)
        val = _scale_value[D.T.Z, TR](val)
        val = _scale_value[D.EC.Z, ECR](val)
        val = _scale_value[D.TH.Z, THR](val)
        val = _scale_value[D.A.Z, AR](val)
        val = _scale_value[D.CD.Z, CDR](val)

        self = Self(val)

    @always_inline
    fn __truediv__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D / OD, DT]):
        _dimension_scale_check[D, OD]()

        @parameter
        if DT.is_integral():
            return __type_of(res)(self._value // other._value)
        else:
            return __type_of(res)(self._value / other._value)

    @always_inline
    fn __mul__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D * OD, DT]):
        _dimension_scale_check[D, OD]()
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

    @always_inline
    fn value(self) -> Self.DataType:
        return self._value


fn _dimension_space_check[L: Dimensions, R: Dimensions]():
    constrained[L.L.Z == R.L.Z]()
    constrained[L.M.Z == R.M.Z]()
    constrained[L.T.Z == R.T.Z]()
    constrained[L.EC.Z == R.EC.Z]()
    constrained[L.TH.Z == R.TH.Z]()
    constrained[L.A.Z == R.A.Z]()
    constrained[L.CD.Z == R.CD.Z]()


fn _dimension_scale_check[L: Dimensions, R: Dimensions]():
    @always_inline
    fn check[LZ: IntLiteral, RZ: IntLiteral, LR: Ratio, RR: Ratio]():
        @parameter
        if LZ and RZ:
            constrained[LR == RR]()

    check[L.L.Z, R.L.Z, L.L.R, R.L.R]()
    check[L.M.Z, R.M.Z, L.M.R, R.M.R]()
    check[L.T.Z, R.T.Z, L.T.R, R.T.R]()
    check[L.EC.Z, R.EC.Z, L.EC.R, R.EC.R]()
    check[L.TH.Z, R.TH.Z, L.TH.R, R.TH.R]()
    check[L.A.Z, R.A.Z, L.A.R, R.A.R]()
    check[L.CD.Z, R.CD.Z, L.CD.R, R.CD.R]()


@always_inline
fn _same_scale_or_one_null_check[L: Ratio, R: Ratio]():
    constrained[(L == R) or (L == Ratio.Invalid) or (R == Ratio.Invalid)]()


@always_inline
fn _scale_value[Z: IntLiteral, R: Ratio](v: Scalar) -> __type_of(v):
    @parameter
    if Z > 0:
        return R * v
    elif Z < 0:
        return R.divide_scalar(v)
    return v
