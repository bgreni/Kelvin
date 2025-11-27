from .ratio import Ratio
from hashlib.hasher import Hasher


@register_passable("trivial")
struct Angle[R: Ratio, suffix: String](
    Boolable, ImplicitlyBoolable, ImplicitlyCopyable, Stringable, Writable
):
    """Represents the angle component of a quantity.

    This is not treated as a proper dimension, but is meant to prevent you
    from mixing angular, and non-angular values, as well as mixing angular units.
    """

    alias Invalid = Angle[Ratio.Invalid, ""]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __eq__(self, other: Angle) -> Bool:
        return Self.R == other.R

    @always_inline("builtin")
    fn __ne__(self, other: Angle) -> Bool:
        return not self == other

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return Self.R.__bool__()

    @always_inline("builtin")
    fn __as_bool__(self) -> Bool:
        return Self.R.__bool__()

    @always_inline("builtin")
    fn pick_non_null(
        self, other: Angle
    ) -> Angle[Self.R | other.R, Self.suffix or other.suffix]:
        return {}

    @always_inline
    fn write_to(self, mut writer: Some[Writer]):
        writer.write(Self.suffix)

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)


@register_passable("trivial")
struct Dimension[Z: IntLiteral, R: Ratio, suffix: String](
    Boolable, ImplicitlyBoolable, ImplicitlyCopyable, Stringable, Writable
):
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
        return Self.Z == other.Z and Self.R == other.R

    @always_inline("builtin")
    fn __ne__(self, other: Dimension) -> Bool:
        return not self == other

    @always_inline("builtin")
    fn __add__(
        self, other: Dimension
    ) -> Dimension[
        Self.Z + other.Z, Self.R | other.R, Self.suffix or other.suffix
    ]:
        return {}

    @always_inline("builtin")
    fn __sub__(
        self, other: Dimension
    ) -> Dimension[
        Self.Z - other.Z, Self.R | other.R, Self.suffix or other.suffix
    ]:
        return {}

    @always_inline("builtin")
    fn __mul__(
        self, m: IntLiteral
    ) -> Dimension[Self.Z * type_of(m)(), Self.R, Self.suffix]:
        return {}

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return Self.Z != 0

    @always_inline("builtin")
    fn __as_bool__(self) -> Bool:
        return self.__bool__()

    @always_inline("builtin")
    fn __neg__(self) -> Dimension[-Self.Z, Self.R, Self.suffix]:
        return {}

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(Self.suffix, "^", Self.Z)


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
](ImplicitlyCopyable, Stringable, Writable):
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
        Ang: The angle component of the quantity.
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
            Self.L == O.L
            and Self.M == O.M
            and Self.T == O.T
            and Self.EC == O.EC
            and Self.TH == O.TH
            and Self.A == O.A
            and Self.CD == O.CD
            and Self.Ang == O.Ang
        )

    @always_inline("builtin")
    fn __ne__(self, O: Dimensions) -> Bool:
        return not self == O

    @always_inline("builtin")
    fn __truediv__(
        self, other: Dimensions
    ) -> Dimensions[
        Self.L - other.L,
        Self.M - other.M,
        Self.T - other.T,
        Self.EC - other.EC,
        Self.TH - other.TH,
        Self.A - other.A,
        Self.CD - other.CD,
        Self.Ang.pick_non_null(other.Ang),
    ]:
        return {}

    @always_inline("builtin")
    fn __mul__(
        self, other: Dimensions
    ) -> Dimensions[
        Self.L + other.L,
        Self.M + other.M,
        Self.T + other.T,
        Self.EC + other.EC,
        Self.TH + other.TH,
        Self.A + other.A,
        Self.CD + other.CD,
        Self.Ang.pick_non_null(other.Ang),
    ]:
        return {}

    @always_inline("builtin")
    fn __pow__(
        self, p: IntLiteral
    ) -> Dimensions[
        type_of(Self.L * p)(),
        type_of(Self.M * p)(),
        type_of(Self.T * p)(),
        type_of(Self.EC * p)(),
        type_of(Self.TH * p)(),
        type_of(Self.A * p)(),
        type_of(Self.CD * p)(),
        Self.Ang,
    ]:
        return {}

    @always_inline("builtin")
    fn __neg__(
        self,
    ) -> Dimensions[
        -Self.L,
        -Self.M,
        -Self.T,
        -Self.EC,
        -Self.TH,
        -Self.A,
        -Self.CD,
        Self.Ang,
    ]:
        return {}

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)

    fn write_to(self, mut writer: Some[Writer]):
        @parameter
        @always_inline
        fn write[d: Dimension]():
            @parameter
            if d:
                writer.write(" ", d)

        write[Self.L]()
        write[Self.M]()
        write[Self.T]()
        write[Self.EC]()
        write[Self.TH]()
        write[Self.A]()
        write[Self.CD]()

        @parameter
        if Self.Ang:
            writer.write(" ", Self.Ang)


@register_passable("trivial")
struct Quantity[D: Dimensions, DT: DType = DType.float64, Width: Int = 1](
    Boolable,
    Comparable,
    Hashable,
    ImplicitlyBoolable,
    ImplicitlyCopyable,
    KeyElement,
    Movable,
    Representable,
    Stringable,
    Writable,
):
    """Represents an abstract quantity over some given dimensions.

    Params:
        D: The dimension which the value exists in eg. (meters per second)
        DT: The numerical type of the value, defaults to Float64
        Width: The SIMD width of the value representation.
    """

    alias ValueType = SIMD[Self.DT, Self.Width]
    alias Mask = SIMD[DType.bool, Self.Width]
    var _value: Self.ValueType

    @always_inline("builtin")
    fn __init__(out self, v: Self.ValueType):
        self._value = v

    @always_inline("nodebug")
    fn __init__(out self, *elems: Scalar[Self.DT], __list_literal__: () = ()):
        self._value = Self.ValueType()
        debug_assert(
            len(elems) == Self.Width,
            "Wrong number of elements in variadic constructor",
        )
        for i in range(len(elems)):
            self._value[i] = elems[i]

    @always_inline
    @implicit
    fn __init__(out self, other: Quantity[DT = Self.DT, Width = Self.Width]):
        """This exists to give a more helpful error message when one tries to use the
        wrong type implicitly.
        """
        constrained[
            Self.D == other.D,
            String.write("expected dimensions", Self.D, " received ", other.D),
        ]()
        self._value = other._value

    fn __init__(
        out self, *, cast_from: Quantity[DT = Self.DT, Width = Self.Width]
    ):
        """Cast the value from the incoming quanitity into this quantity.
        Both quantities must live in the same dimensional space (eg. velocity in, velocity out).

        Args:
            cast_from: Some quantity of matching dimension to cast from.
        """
        _dimension_space_check[Self.D, cast_from.D]()
        var val = cast_from.value()

        alias OD = cast_from.D

        # Calculate the difference between the ratios on each dimension
        alias LR = OD.L.R / Self.D.L.R
        alias MR = OD.M.R / Self.D.M.R
        alias TR = OD.T.R / Self.D.T.R
        alias ECR = OD.EC.R / Self.D.EC.R
        alias THR = OD.TH.R / Self.D.TH.R
        alias AR = OD.A.R / Self.D.A.R
        alias CDR = OD.CD.R / Self.D.CD.R
        alias AngR = OD.Ang.R / Self.D.Ang.R

        val = _scale_value[Self.D.L.Z, LR](val)
        val = _scale_value[Self.D.M.Z, MR](val)
        val = _scale_value[Self.D.T.Z, TR](val)
        val = _scale_value[Self.D.EC.Z, ECR](val)
        val = _scale_value[Self.D.TH.Z, THR](val)
        val = _scale_value[Self.D.A.Z, AR](val)
        val = _scale_value[Self.D.CD.Z, CDR](val)

        @parameter
        if AngR:
            val = AngR * val

        self._value = val

    @always_inline("builtin")
    fn value(self) -> Self.ValueType:
        """
        Returns:
            the value of the quantity.
        """
        return self._value

    @always_inline
    fn __getitem__(self, ind: Some[Indexer]) -> Scalar[Self.DT]:
        return self.value()[Int(index(ind))]

    # ===------------------------------------------------------------------=== #
    # Quantity operations
    # ===------------------------------------------------------------------=== #

    @always_inline
    fn __truediv__[
        OD: Dimensions
    ](self, other: Quantity[OD, Self.DT, Self.Width]) -> Quantity[
        Self.D / OD, Self.DT, Self.Width
    ]:
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
        _dimension_scale_check[Self.D, OD]()
        return {self._value / other._value}

    @always_inline
    fn __mul__[
        OD: Dimensions
    ](self, other: Quantity[OD, Self.DT, Self.Width]) -> Quantity[
        Self.D * OD, Self.DT, Self.Width
    ]:
        """Compute the product between two quantities
        Output dimensions are the sum of the inputs.

        `m^1 * m^1 -> m^2` (aka area).

        Inputs must have matching scale on all shared dimensions.

        Args:
            other: A quantity of matching scale.

        Returns:
            The product of self * other.
        """
        _dimension_scale_check[Self.D, OD]()
        return {self._value * other._value}

    @always_inline
    fn __add__(self, other: Self) -> Self:
        """Compute sum of two quantities.
        Addition is only defined on quantities of matching types.

        Args:
            other: A quantity of matching type.

        Returns:
            The sum of self + other.
        """
        return {self._value + other._value}

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
        return {self._value - other._value}

    @always_inline
    fn __isub__(mut self, other: Self):
        """Compute difference of two quantities in place.
        Subtraction is only defined on quantities of matching types.

        Args:
            other: A quantity of matching type.
        """
        self._value -= other._value

    # ===------------------------------------------------------------------=== #
    # Scalar operations
    # ===------------------------------------------------------------------=== #

    @always_inline
    fn __truediv__(self, v: Self.ValueType) -> Self:
        """Divides the value by the given scalar.

        Args:
            v: A scalar.

        Returns:
            The quotient of self / v.
        """
        return {self._value / v}

    @always_inline
    fn __rtruediv__(
        self, v: Self.ValueType
    ) -> Quantity[-Self.D, Self.DT, Self.Width]:
        """Divides the scalar by the value of self.

        Args:
            v: A scalar.

        Returns:
            The quotient of v / self.
        """
        return {v / self.value()}

    @always_inline
    fn __itruediv__(mut self, v: Self.ValueType):
        """Divides the value by the given scalar in place.

        Args:
            v: A scalar.
        """
        self._value /= v

    @always_inline
    fn __mul__(self, v: Self.ValueType) -> Self:
        """Multiply the value but a given scalar.

        Args:
            v: The input scalar.

        Returns
            The product of self * v.
        """
        return {self.value() * v}

    @always_inline
    fn __rmul__(self, v: Self.ValueType) -> Self:
        """Multiply the value but a given scalar.

        Args:
            v: The input scalar.

        Returns
            The product of v * self.
        """
        return {v * self.value()}

    @always_inline
    fn __imul__(mut self, v: Self.ValueType):
        """Multiply the value but a given scalar in place.

        Args:
            v: The input scalar.
        """
        self._value *= v

    @always_inline
    fn __pow__(
        self, p: IntLiteral
    ) -> Quantity[Self.D ** type_of(p)(), Self.DT, Self.Width]:
        """Compute self ** p.

        Args:
            p: A compile time known IntLiteral.

        Returns:
            The value raised to the power p, with the corresponding units transformed.
        """
        return {self.value() ** p}

    # ===------------------------------------------------------------------=== #
    # Trait implementations
    # ===------------------------------------------------------------------=== #

    @always_inline
    fn __eq__(self, other: Self) -> Bool:
        """
        Args:
            other: A quantity of matching type.
        Returns:
            True of the two matching quantities have the same value.
        """
        return self.value() == other.value()

    @always_inline
    fn eq(self, other: Self) -> Self.Mask:
        """Performs an elementwise equality.

        Args:
            other: A quantity of matching type.

        Returns:
            An elementwise mask.
        """
        return self.value().eq(other.value())

    @always_inline
    fn __ne__(self, other: Self) -> Bool:
        """
        Args:
            other: A quantity of matching type.
        Returns:
            True of the two matching quantities have different values.
        """
        return self.value() != other.value()

    @always_inline
    fn ne(self, other: Self) -> Self.Mask:
        """Performs an elementwise not equal.

        Args:
            other: A quantity of matching type.

        Returns:
            An elementwise mask.
        """
        return self.value().ne(other.value())

    @always_inline
    fn __lt__(self, other: Self) -> Bool:
        """
        Args:
            other: A quantity of matching type.
        Returns:
            True of the value of self is less than other.
        """
        return self.value() < other.value()

    @always_inline
    fn lt(self, other: Self) -> Self.Mask:
        """Performs an elementwise less than.

        Args:
            other: A quantity of matching type.

        Returns:
            An elementwise mask.
        """
        return self.value().lt(other.value())

    @always_inline
    fn __le__(self, other: Self) -> Bool:
        """
        Args:
            other: A quantity of matching type.
        Returns:
            True of the value of self is less than or equal to other.
        """
        return self.value() <= other.value()

    @always_inline
    fn le(self, other: Self) -> Self.Mask:
        """Performs an elementwise less than equal.

        Args:
            other: A quantity of matching type.

        Returns:
            An elementwise mask.
        """
        return self.value().le(other.value())

    @always_inline
    fn __gt__(self, other: Self) -> Bool:
        """
        Args:
            other: A quantity of matching type.
        Returns:
            True of the value of self is greater than other.
        """
        return self.value() > other.value()

    @always_inline
    fn gt(self, other: Self) -> Self.Mask:
        """Performs an elementwise greater than.

        Args:
            other: A quantity of matching type.

        Returns:
            An elementwise mask.
        """
        return self.value().gt(other.value())

    @always_inline
    fn __ge__(self, other: Self) -> Bool:
        """
        Args:
            other: A quantity of matching type.
        Returns:
            True of the value of self is greater than or equal to other.
        """
        return self.value() >= other.value()

    @always_inline
    fn ge(self, other: Self) -> Self.Mask:
        """Performs an elementwise greater equal.

        Args:
            other: A quantity of matching type.

        Returns:
            An elementwise mask.
        """
        return self.value().ge(other.value())

    @always_inline
    fn __str__(self) -> String:
        """
        Returns:
            The string representation of the quantity.
        """
        return String.write(self)

    @always_inline
    fn __repr__(self) -> String:
        """
        Returns:
            The string representation of the quantity.
        """
        return String.write(self)

    @always_inline
    fn __bool__(self) -> Bool:
        return any(self.value())

    @always_inline
    fn __as_bool__(self) -> Bool:
        return {self}

    @always_inline
    fn __hash__(self, mut hasher: Some[Hasher]):
        return hasher.update(self.value())

    fn write_to[W: Writer](self, mut writer: W):
        """Writes the representation of the quantity to the given writer.

        Args:
            writer: The writer to write to.
        """
        writer.write(self._value)
        writer.write(Self.D)


# ===------------------------------------------------------------------=== #
# Private helpers
# ===------------------------------------------------------------------=== #


fn _scale_value[Z: IntLiteral, R: Ratio](var v: SIMD) -> type_of(v):
    @parameter
    if Z > 0:

        @parameter
        for _ in range(Z):
            v = R * v
    elif Z < 0:

        @parameter
        for _ in range(-Z):
            v = v / R
    return v


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
