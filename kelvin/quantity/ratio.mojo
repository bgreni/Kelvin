from utils._select import _select_register_value as select


@register_passable("trivial")
struct Ratio[N: IntLiteral, D: IntLiteral](
    ImplicitlyCopyable, Stringable, Writable
):
    """A compile time, known rational value, used to represent the scale
    of a particular unit.
    """

    comptime Nano = Ratio[1, pow[10, 9]()]()
    comptime Micro = Ratio[1, pow[10, 6]()]()
    comptime Milli = Ratio[1, pow[10, 3]()]()
    comptime Centi = Ratio[1, 100]()
    comptime Deci = Ratio[1, 10]()
    comptime Unitary = Ratio[1, 1]()
    comptime Deca = Ratio[10, 1]()
    comptime Hecto = Ratio[100, 1]()
    comptime Kilo = Ratio[pow[10, 3](), 1]()
    comptime Mega = Ratio[pow[10, 6](), 1]()
    comptime Giga = Ratio[pow[10, 9](), 1]()

    comptime PI = Ratio[355, 113]()

    comptime _GCD = gcd[Self.N, Self.D]()

    comptime Invalid = Ratio[0, 0]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        """Returns True if the ratio is valid (non-zero denominator).

        Returns:
            True if valid.
        """
        return self != Ratio.Invalid

    @always_inline("builtin")
    fn __eq__(self, other: Ratio) -> Bool:
        """Check if two ratios are equal.

        Args:
            other: The other ratio to compare.

        Returns:
            True if equal.
        """
        # Resolve logic at compile time, use select to choose result (folded)
        comptime is_invalid = (Self.D == 0) or (other.D == 0)
        return select(
            is_invalid,
            (Self.N == other.N) and (Self.D == other.D),
            (Self.N * other.D) == (Self.D * other.N),
        )

    @always_inline("builtin")
    fn __ne__(self, other: Ratio) -> Bool:
        """Check if two ratios are not equal.

        Args:
            other: The other ratio to compare.

        Returns:
            True if not equal.
        """
        return not self == other

    @always_inline("builtin")
    fn __gt__(self, other: Ratio) -> Bool:
        """Check if self is greater than other.

        Args:
            other: The other ratio to compare.

        Returns:
            True if self > other.
        """
        return Self.N * other.D > Self.D * other.N

    @always_inline("builtin")
    fn __lt__(self, other: Ratio) -> Bool:
        """Check if self is less than other.

        Args:
            other: The other ratio to compare.

        Returns:
            True if self < other.
        """
        return other > self

    @always_inline("builtin")
    fn __ge__(self, other: Ratio) -> Bool:
        """Check if self is greater than or equal to other.

        Args:
            other: The other ratio to compare.

        Returns:
            True if self >= other.
        """
        return Self.N * other.D >= Self.D * other.N

    @always_inline("builtin")
    fn __le__(self, other: Ratio) -> Bool:
        """Check if self is less than or equal to other.

        Args:
            other: The other ratio to compare.

        Returns:
            True if self <= other.
        """
        return other >= self

    @always_inline("builtin")
    fn __add__(
        self, other: Ratio
    ) -> Ratio[
        max[Self.N * other.D + other.N * Self.D, Self.N + other.N](),
        IntLiteral[
            _max[
                (Self.D * other.D).value, _max[Self.D.value, other.D.value]()
            ]()
        ](),
    ]:
        """Bit of a hack so that Ratio[0, 0]() + Ratio[1, 2]() == Ratio[1, 2]().
        As otherwise that is undefined in standard rational arithmetic, but we
        need it so we can handle, and represent the lack of dimensions nicely.

        Proof of equivalence to standard addition at misc/ratio_add_proof.py
        """
        return {}

    @always_inline
    fn __mul__(self, other: SIMD) -> type_of(other):
        """Multiply the ratio by a scalar.

        Args:
            other: The scalar to multiply.

        Returns:
            The product.
        """
        return (other * Self.N) / Self.D

    @always_inline
    fn __rmul__(self, other: SIMD) -> type_of(other):
        """Multiply a scalar by the ratio.

        Args:
            other: The scalar to multiply.

        Returns:
            The product.
        """
        return self.__mul__(other)

    @always_inline("builtin")
    fn __mul__(self, other: Ratio) -> Ratio[Self.N * other.N, Self.D * other.D]:
        """Multiply two ratios.

        Args:
            other: The other ratio to multiply.

        Returns:
            The product ratio.
        """
        return {}

    @always_inline("builtin")
    fn __truediv__(
        self, other: Ratio
    ) -> Ratio[Self.N * other.D, Self.D * other.N]:
        """Divide two ratios.

        Args:
            other: The denominator ratio.

        Returns:
            The quotient ratio.
        """
        return {}

    @always_inline
    fn __truediv__(self, other: SIMD) -> type_of(other):
        """Divide the ratio by a scalar.

        Args:
            other: The scalar denominator.

        Returns:
            The quotient.
        """
        return Self.N / (other * Self.D)

    @always_inline
    fn __rtruediv__(self, other: SIMD) -> type_of(other):
        """Divide a scalar by the ratio.

        Args:
            other: The scalar numerator.

        Returns:
            The quotient.
        """
        return other * self.inverse()

    # TODO: Not sure why this doesn't work
    # @always_inline
    # fn __pow__(
    #     self,
    #     p: IntLiteral,
    #     out res: Ratio[
    #         pow[ternary[N, D, type_of(p)() >= 0](), abs(type_of(p)())](),
    #         pow[ternary[D, N, type_of(p)() >= 0](), abs(type_of(p)())](),
    #     ],
    # ):
    #     return type_of(res)()

    @always_inline("builtin")
    fn __or__(self, other: Ratio) -> Ratio[Self.N | other.N, Self.D | other.D]:
        """Compute the bitwise OR of two ratios.

        Args:
            other: The other ratio.

        Returns:
            The bitwise OR result.
        """
        return {}

    @always_inline("builtin")
    fn inverse(self) -> Ratio[Self.D, Self.N]:
        """Invert the ratio (swap numerator and denominator).

        Returns:
            The inverted ratio.
        """
        return {}

    @always_inline("builtin")
    fn simplify(self) -> Ratio[Self.N // Self._GCD, Self.D // Self._GCD]:
        """Simplify the ratio by dividing by the GCD.

        Returns:
            The simplified ratio.
        """
        return {}

    @always_inline
    fn write_to(self, mut writer: Some[Writer]):
        """Write the ratio to a writer.

        Args:
            writer: The writer to write to.
        """
        writer.write(Self.N, "/", Self.D)

    @always_inline
    fn __str__(self) -> String:
        """Returns the string representation of the ratio.

        Returns:
            The string representation.
        """
        return String.write(self)


# ===------------------------------------------------------------------=== #
# Private Helpers
# ===------------------------------------------------------------------=== #

comptime _pop_int_literal = __mlir_type.`!pop.int_literal`


@always_inline("nodebug")
fn _gcd[a: _pop_int_literal, b: _pop_int_literal]() -> _pop_int_literal:
    comptime a_ = IntLiteral[a]()
    comptime b_ = IntLiteral[b]()

    @parameter
    if b_:
        return _gcd[b, (a_ % b_).value]()
    else:
        return a


@always_inline("nodebug")
fn gcd[a: IntLiteral, b: IntLiteral]() -> IntLiteral[_gcd[a.value, b.value]()]:
    return {}


@always_inline("builtin")
fn _max[a: _pop_int_literal, b: _pop_int_literal]() -> _pop_int_literal:
    comptime a_ = IntLiteral[a]()
    comptime b_ = IntLiteral[b]()
    return select(a_ > b_, a, b)


@always_inline("builtin")
fn max[a: IntLiteral, b: IntLiteral]() -> IntLiteral[_max[a.value, b.value]()]:
    return {}


@always_inline("nodebug")
fn _pow[
    x: _pop_int_literal, n: _pop_int_literal, acc: _pop_int_literal
]() -> _pop_int_literal:
    comptime x_ = IntLiteral[x]()
    comptime n_ = IntLiteral[n]()
    comptime acc_ = IntLiteral[acc]()
    __comptime_assert n_ >= 0, "Cannot use negative power"

    @parameter
    if n_ == 0:
        return acc
    else:
        return _pow[x, (n_ - 1).value, (acc_ * x_).value]()


@always_inline("nodebug")
fn pow[
    x: IntLiteral, n: IntLiteral
]() -> IntLiteral[_pow[x.value, n.value, (1).value]()]:
    return {}


@always_inline("builtin")
fn ternary[
    a: IntLiteral, b: IntLiteral, cond: Bool
]() -> IntLiteral[_ternary[a.value, b.value, cond]()]:
    return {}


@always_inline("builtin")
fn _ternary[
    a: _pop_int_literal, b: _pop_int_literal, cond: Bool
]() -> _pop_int_literal:
    return select(cond, a, b)
