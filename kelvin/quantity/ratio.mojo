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

    @always_inline("nodebug")
    fn __init__(out self):
        pass

    @always_inline("nodebug")
    fn __bool__(self) -> Bool:
        return self != Ratio.Invalid

    @always_inline("nodebug")
    fn __eq__(self, other: Ratio) -> Bool:
        return Self.N == other.N and Self.D == other.D

    @always_inline("nodebug")
    fn __ne__(self, other: Ratio) -> Bool:
        return not self == other

    @always_inline("nodebug")
    fn __gt__(self, other: Ratio) -> Bool:
        return Self.N * other.D > Self.D * other.N

    @always_inline("nodebug")
    fn __lt__(self, other: Ratio) -> Bool:
        return other > self

    @always_inline("nodebug")
    fn __ge__(self, other: Ratio) -> Bool:
        return Self.N * other.D >= Self.D * other.N

    @always_inline("nodebug")
    fn __le__(self, other: Ratio) -> Bool:
        return other >= self

    @always_inline
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
        return (other * Self.N) / Self.D

    @always_inline
    fn __rmul__(self, other: SIMD) -> type_of(other):
        return self.__mul__(other)

    @always_inline("nodebug")
    fn __mul__(self, other: Ratio) -> Ratio[Self.N * other.N, Self.D * other.D]:
        return {}

    @always_inline("nodebug")
    fn __truediv__(
        self, other: Ratio
    ) -> Ratio[Self.N * other.D, Self.D * other.N]:
        return {}

    @always_inline
    fn __truediv__(self, other: SIMD) -> type_of(other):
        return Self.N / (other * Self.D)

    @always_inline
    fn __rtruediv__(self, other: SIMD) -> type_of(other):
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

    @always_inline("nodebug")
    fn __or__(self, other: Ratio) -> Ratio[Self.N | other.N, Self.D | other.D]:
        return {}

    @always_inline("nodebug")
    fn inverse(self) -> Ratio[Self.D, Self.N]:
        return {}

    @always_inline("nodebug")
    fn simplify(self) -> Ratio[Self.N // Self._GCD, Self.D // Self._GCD]:
        return {}

    @always_inline
    fn write_to(self, mut writer: Some[Writer]):
        writer.write(Self.N, "/", Self.D)

    @always_inline
    fn __str__(self) -> String:
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


@always_inline("nodebug")
fn _max[a: _pop_int_literal, b: _pop_int_literal]() -> _pop_int_literal:
    comptime a_ = IntLiteral[a]()
    comptime b_ = IntLiteral[b]()

    @parameter
    if a_ > b_:
        return a
    else:
        return b


@always_inline("nodebug")
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


@always_inline("nodebug")
fn ternary[
    a: IntLiteral, b: IntLiteral, cond: Bool
]() -> IntLiteral[_ternary[a.value, b.value, cond]()]:
    return {}


@always_inline("nodebug")
fn _ternary[
    a: _pop_int_literal, b: _pop_int_literal, cond: Bool
]() -> _pop_int_literal:
    return a if cond else b
