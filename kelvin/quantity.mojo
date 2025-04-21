from .ratio import Ratio


@value
@register_passable("trivial")
struct Angle[R: Ratio, suffix: StaticString](
    Boolable, Writable, ImplicitlyBoolable
):
    alias Invalid = Angle[Ratio.Invalid, ""]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __eq__(self, other: Angle) -> Bool:
        return R == other.R

    @always_inline("builtin")
    fn __ne__(self, other: Angle) -> Bool:
        return not self == other

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return R.__bool__()

    @always_inline("builtin")
    fn __as_bool__(self) -> Bool:
        return R.__bool__()

    @always_inline("builtin")
    fn pick_non_null(
        self, other: Angle, out res: Angle[R | other.R, suffix or other.suffix]
    ):
        return __type_of(res)()

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(suffix)


@value
@register_passable("trivial")
struct Dimension[Z: IntLiteral, R: Ratio, suffix: StaticString]:
    """Represents a single dimension.

    Params:
        Z: The dimension space, eg. 2 for X^2 where X is a unit.
        R: The scale of the dimension unit, eg. Ratio.Kilo.
        suffix: The string suffix for the unit (m, kg, s, etc).
    """

    # Represents the lack of a dimension
    alias Invalid = Dimension[0, Ratio.Invalid, ""]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __eq__(self, other: Dimension) -> Bool:
        return Z == other.Z and R == other.R

    @always_inline("builtin")
    fn __ne__(self, other: Dimension) -> Bool:
        return not self == other

    @always_inline("builtin")
    fn __add__(
        self,
        other: Dimension,
        out res: Dimension[Z + other.Z, R | other.R, suffix or other.suffix],
    ):
        return __type_of(res)()

    @always_inline("builtin")
    fn __sub__(
        self,
        other: Dimension,
        out res: Dimension[Z - other.Z, R | other.R, suffix or other.suffix],
    ):
        return __type_of(res)()

    @always_inline("builtin")
    fn __mul__(
        self,
        m: IntLiteral,
        out res: Dimension[Z * __type_of(m)(), R, suffix],
    ):
        return __type_of(res)()

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return Z != 0

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(suffix, "^", Z)


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
    Ang: Angle,
]:
    """Represents the 7 SI unit dimensions + angle, all within the parameter
    domain.

    Params:
        L: Length dimension.
        M: Mass dimension.
        T: Time dimension.
        EC: Electric current dimension.
        TH: Temperature dimension.
        A: Substance amount dimension.
        CD: Luminosity dimension.
        Ang: The angle component of the quantity
    """

    alias Null = Dimensions[
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Dimension.Invalid,
        Angle.Invalid,
    ]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __eq__(self, O: Dimensions) -> Bool:
        return (
            L == O.L
            and M == O.M
            and T == O.T
            and EC == O.EC
            and TH == O.TH
            and A == O.A
            and CD == O.CD
            and Ang == O.Ang
        )

    @always_inline("builtin")
    fn __ne__(self, O: Dimensions) -> Bool:
        return not self == O

    @always_inline("builtin")
    fn __truediv__(
        self,
        other: Dimensions,
        out res: Dimensions[
            L - other.L,
            M - other.M,
            T - other.T,
            EC - other.EC,
            TH - other.TH,
            A - other.A,
            CD - other.CD,
            Ang.pick_non_null(other.Ang),
        ],
    ):
        return __type_of(res)()

    @always_inline("builtin")
    fn __mul__(
        self,
        other: Dimensions,
        out res: Dimensions[
            L + other.L,
            M + other.M,
            T + other.T,
            EC + other.EC,
            TH + other.TH,
            A + other.A,
            CD + other.CD,
            Ang.pick_non_null(other.Ang),
        ],
    ):
        return __type_of(res)()

    @always_inline("builtin")
    fn __pow__(
        self,
        p: IntLiteral,
        out res: Dimensions[
            __type_of(L * p)(),
            __type_of(M * p)(),
            __type_of(T * p)(),
            __type_of(EC * p)(),
            __type_of(TH * p)(),
            __type_of(A * p)(),
            __type_of(CD * p)(),
            Ang,
        ],
    ):
        return __type_of(res)()

    fn write_to[W: Writer](self, mut writer: W):
        @parameter
        @always_inline
        fn write[d: Dimension]():
            @parameter
            if d:
                writer.write(" ", d)

        write[L]()
        write[M]()
        write[T]()
        write[EC]()
        write[TH]()
        write[A]()
        write[CD]()

        @parameter
        if Ang:
            writer.write(" ", Ang)


@value
@register_passable("trivial")
struct Quantity[D: Dimensions, DT: DType = DType.float64](
    EqualityComparableCollectionElement, Writable, Stringable
):
    """Represents an abstract quantity over some given dimensions.

    Params:
        D: The dimension which the value exists in eg. (meters per second)
        DT: The numerical type of the value, defaults to Float64
    """

    alias ScalarType = Scalar[DT]
    var _value: Self.ScalarType

    @always_inline
    fn __init__(out self, v: Self.ScalarType):
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
        """Cast the value from the incoming quanitity into this quantity.
        Both quantities must live in the same dimensional space (eg. velocity in, velocity out).

        Args:
            cast_from: Some quantity of matching dimension to cast from.
        """
        _dimension_space_check[D, cast_from.D]()
        var val = cast_from.value()

        alias OD = cast_from.D

        # Calculate the difference between the ratios on each dimension
        alias LR = OD.L.R / D.L.R
        alias MR = OD.M.R / D.M.R
        alias TR = OD.T.R / D.T.R
        alias ECR = OD.EC.R / D.EC.R
        alias THR = OD.TH.R / D.TH.R
        alias AR = OD.A.R / D.A.R
        alias CDR = OD.CD.R / D.CD.R
        alias AngR = D.Ang.R / OD.Ang.R

        val = _scale_value[D.L.Z, LR](val)
        val = _scale_value[D.M.Z, MR](val)
        val = _scale_value[D.T.Z, TR](val)
        val = _scale_value[D.EC.Z, ECR](val)
        val = _scale_value[D.TH.Z, THR](val)
        val = _scale_value[D.A.Z, AR](val)
        val = _scale_value[D.CD.Z, CDR](val)

        @parameter
        if AngR:
            val = AngR * val

        self._value = val

    @always_inline
    fn value(self) -> Self.ScalarType:
        """
        Returns:
            the value of the quantity.
        """
        return self._value

    # ===------------------------------------------------------------------=== #
    # Quantity operations
    # ===------------------------------------------------------------------=== #

    @always_inline
    fn __truediv__[
        OD: Dimensions
    ](self, other: Quantity[OD, DT], out res: Quantity[D / OD, DT]):
        """Divide on quantity by another.
        Output dimensions are the difference of the inputs.

        `m^1 / s^1 -> m^1 s^-1` (aka velocity).

        Inputs must have matching scale on all shared dimensions.
        Uses floor division for integer data types.

        Args:
            other: A quantity with matching scale to use as the denominator.

        Returns:
            The quotient of self / other.
        """
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
        """Compute the product between two quantities
        Output dimensions are the sum of the inputs.

        `m^1 * m^1 -> m^2` (aka area).

        Inputs must have matching scale on all shared dimensions.

        Args:
            other: A quantity of matching scale.

        Returns:
            The product of self * other.
        """
        _dimension_scale_check[D, OD]()
        return __type_of(res)(self._value * other._value)

    @always_inline
    fn __add__(self, other: Self) -> Self:
        """Compute sum of two quantities.
        Addition is only defined on quantities of matching types.

        Args:
            other: A quantity of matching type.

        Returns:
            The sum of self + other.
        """
        return Self(self._value + other._value)

    @always_inline
    fn __iadd__(mut self, other: Self):
        """Compute sum of two quantities in place.
        Addition is only defined on quantities of matching types.

        Args:
            other: A quantity of matching type.
        """
        self._value += other._value

    @always_inline
    fn __sub__(self, other: Self) -> Self:
        """Compute differecnce of two quantities.
        Subtraction is only defined on quantities of matching types.

        Args:
            other: A quantity of matching type.

        Returns:
            The difference of self - other.
        """
        return Self(self._value - other._value)

    @always_inline
    fn __isub__(mut self, other: Self):
        """Compute difference of two quantities in place.
        Subtraction is only defined on quantities of matching types.

        Args:
            other: A quantity of matching type.
        """
        self._value -= other._value

    @always_inline
    fn __eq__(self, other: Self) -> Bool:
        """Returns true of the two matching quantities have the same value.

        Args:
            other: A quantity of matching type.
        """
        return self._value == other._value

    @always_inline
    fn __ne__(self, other: Self) -> Bool:
        """Returns true of the two matching quantities have different values.

        Args:
            other: A quantity of matching type.
        """
        return self._value != other._value

    # ===------------------------------------------------------------------=== #
    # Scalar operations
    # ===------------------------------------------------------------------=== #

    @always_inline
    fn __truediv__(self, v: Self.ScalarType) -> Self:
        """Divides the value by the given scalar.

        Args:
            v: A scalar.

        Returns:
            The quotient of self / v.
        """

        @parameter
        if DT.is_integral():
            return Self(self._value // v)
        else:
            return Self(self._value / v)

    @always_inline
    fn __rtruediv__(self, v: Self.ScalarType) -> Self:
        """Divides the scalar by the value of self.

        Args:
            v: A scalar.

        Returns:
            The quotient of v / self.
        """

        @parameter
        if DT.is_integral():
            return Self(v // self.value())
        else:
            return Self(v / self.value())

    @always_inline
    fn __itruediv__(mut self, v: Self.ScalarType):
        """Divides the value by the given scalar in place.

        Args:
            v: A scalar.
        """

        @parameter
        if DT.is_integral():
            self._value //= v
        else:
            self._value /= v

    @always_inline
    fn __mul__(self, v: Self.ScalarType) -> Self:
        """Multiply the value but a given scalar.

        Args:
            v: The input scalar.

        Returns
            The product of self * v.
        """
        return Self(self.value() * v)

    @always_inline
    fn __rmul__(self, v: Self.ScalarType) -> Self:
        """Multiply the value but a given scalar.

        Args:
            v: The input scalar.

        Returns
            The product of v * self.
        """
        return Self(v * self.value())

    @always_inline
    fn __imul__(mut self, v: Self.ScalarType):
        """Multiply the value but a given scalar in place.

        Args:
            v: The input scalar.
        """
        self._value *= v

    @always_inline
    fn __add__(self, v: Self.ScalarType) -> Self:
        """Compute the sum of self and the give scalar.

        Args:
            v: A scalar.

        Returns:
            The sum of self + v.
        """
        return Self(self.value() + v)

    @always_inline
    fn __radd__(self, v: Self.ScalarType) -> Self:
        """Compute the sum of self and the give scalar.

        Args:
            v: A scalar.

        Returns:
            The sum of v + self.
        """
        return Self(v + self.value())

    @always_inline
    fn __iadd__(mut self, v: Self.ScalarType):
        """Compute the sum of self and the give scalar in place.

        Args:
            v: A scalar.
        """
        self._value += v

    @always_inline
    fn __sub__(self, v: Self.ScalarType) -> Self:
        """Compute the difference of self and the give scalar.

        Args:
            v: A scalar.

        Returns:
            The difference of self - v.
        """
        return Self(self.value() - v)

    @always_inline
    fn __rsub__(self, v: Self.ScalarType) -> Self:
        """Compute the difference of self and the give scalar.

        Args:
            v: A scalar.

        Returns:
            The difference of v - self.
        """
        return Self(v - self.value())

    @always_inline
    fn __isub__(mut self, v: Self.ScalarType):
        """Compute the difference of self and the give scalar in place.

        Args:
            v: A scalar.
        """
        self._value -= v

    @always_inline
    fn __pow__(self, p: IntLiteral, out res: Quantity[D ** __type_of(p)(), DT]):
        """Compute self ** p.

        Args:
            p: A compile time known IntLiteral.

        Returns:
            The value raised to the power p, with the corresponding units transformed.
        """
        return __type_of(res)(self.value() ** p)

    # ===------------------------------------------------------------------=== #
    # Trait implementations
    # ===------------------------------------------------------------------=== #

    @always_inline
    fn __str__(self) -> String:
        """
        Returns:
            The string representation of the quantity.
        """
        return String.write(self)

    fn write_to[W: Writer](self, mut writer: W):
        """Writes the representation of the quantity to the given writer.

        Args:
            writer: The writer to write to.
        """
        writer.write(self._value)
        writer.write(D)


# ===------------------------------------------------------------------=== #
# Private helpers
# ===------------------------------------------------------------------=== #


fn _dimension_space_check[L: Dimensions, R: Dimensions]():
    constrained[L.L.Z == R.L.Z]()
    constrained[L.M.Z == R.M.Z]()
    constrained[L.T.Z == R.T.Z]()
    constrained[L.EC.Z == R.EC.Z]()
    constrained[L.TH.Z == R.TH.Z]()
    constrained[L.A.Z == R.A.Z]()
    constrained[L.CD.Z == R.CD.Z]()
    constrained[Bool(L.Ang) == Bool(R.Ang)]()


fn _dimension_scale_check[L: Dimensions, R: Dimensions]():
    fn check[l: Dimension, r: Dimension]():
        @parameter
        if l.Z and r.Z:
            constrained[l.R == r.R]()

    check[L.L, R.L]()
    check[L.M, R.M]()
    check[L.T, R.T]()
    check[L.EC, R.EC]()
    check[L.TH, R.TH]()
    check[L.A, R.A]()
    check[L.CD, R.CD]()

    @parameter
    if Bool(L.Ang) and Bool(R.Ang):
        constrained[L.Ang.R == R.Ang.R]()


@always_inline
fn _scale_value[Z: IntLiteral, R: Ratio](v: Scalar) -> __type_of(v):
    @parameter
    if Z > 0:
        var res = v

        @parameter
        for _ in range(Z):
            res = R * res
        return res
    elif Z < 0:
        var res = v

        @parameter
        for _ in range(-Z):
            res = R.divide_scalar(res)
        return res
    return v
