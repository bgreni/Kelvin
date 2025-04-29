@value
@register_passable("trivial")
struct Ratio[N: IntLiteral, D: IntLiteral](Stringable, Writable):
    """A compile time, known rational value, used to represent the scale
    of a particular unit.
    """

    alias Nano = Ratio[1, pow[10, 9]()]()
    alias Micro = Ratio[1, pow[10, 6]()]()
    alias Milli = Ratio[1, pow[10, 3]()]()
    alias Centi = Ratio[1, 100]()
    alias Deci = Ratio[1, 10]()
    alias Unitary = Ratio[1, 1]()
    alias Deca = Ratio[10, 1]()
    alias Hecto = Ratio[100, 1]()
    alias Kilo = Ratio[pow[10, 3](), 1]()
    alias Mega = Ratio[pow[10, 6](), 1]()
    alias Giga = Ratio[pow[10, 9](), 1]()

    alias PI = Ratio[355, 113]()

    alias _GCD = gcd[N, D]()

    alias Invalid = Ratio[0, 0]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return self != Ratio.Invalid

    @always_inline("builtin")
    fn __as_bool__(self) -> Bool:
        return self.__bool__()

    @always_inline("builtin")
    fn __eq__(self, other: Ratio) -> Bool:
        return N == other.N and D == other.D

    @always_inline("builtin")
    fn __ne__(self, other: Ratio) -> Bool:
        return not self == other

    @always_inline
    fn __gt__(self, other: Ratio) -> Bool:
        return N * other.D > D * other.N

    @always_inline
    fn __lt__(self, other: Ratio) -> Bool:
        return other > self

    @always_inline
    fn __ge__(self, other: Ratio) -> Bool:
        return N * other.D >= D * other.N

    @always_inline
    fn __le__(self, other: Ratio) -> Bool:
        return other >= self

    @always_inline
    fn __add__(
        self,
        other: Ratio,
        out res: Ratio[
            max[N * other.D + other.N * D, N + other.N](),
            IntLiteral[
                _max[(D * other.D).value, _max[D.value, other.D.value]()]()
            ](),
        ],
    ):
        """Bit of a hack so that Ratio[0, 0]() + Ratio[1, 2]() == Ratio[1, 2]().
        As otherwise that is undefined in standard rational arithmetic, but we
        need it so we can handle, and represent the lack of dimensions nicely.

        Proof of equivalence to standard addition at misc/ratio_add_proof.py
        """
        return __type_of(res)()

    @always_inline
    fn __mul__(self, other: SIMD) -> __type_of(other):
        return (other * N) / D

    @always_inline
    fn __rmul__(self, other: SIMD) -> __type_of(other):
        return self.__mul__(other)

    @always_inline("builtin")
    fn __mul__(self, other: Ratio, out res: Ratio[N * other.N, D * other.D]):
        return __type_of(res)()

    @always_inline("builtin")
    fn __truediv__(
        self,
        other: Ratio,
        out res: Ratio[Self.N * other.D, Self.D * other.N],
    ):
        return __type_of(res)()

    @always_inline
    fn __truediv__(self, other: SIMD) -> __type_of(other):
        return N / (other * D)

    @always_inline
    fn __rtruediv__(self, other: SIMD) -> __type_of(other):
        return other * Ratio[D, N]()

    # TODO: Not sure why this doesn't work
    # @always_inline
    # fn __pow__(
    #     self,
    #     p: IntLiteral,
    #     out res: Ratio[
    #         pow[ternary[N, D, __type_of(p)() >= 0](), abs(__type_of(p)())](),
    #         pow[ternary[D, N, __type_of(p)() >= 0](), abs(__type_of(p)())](),
    #     ],
    # ):
    #     return __type_of(res)()

    @always_inline("builtin")
    fn __or__(self, other: Ratio, out res: Ratio[N | other.N, D | other.D]):
        return __type_of(res)()

    @always_inline("builtin")
    fn simplify(self, out res: Ratio[N // Self._GCD, D // Self._GCD]):
        return __type_of(res)()

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(N, "/", D)

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)


# ===------------------------------------------------------------------=== #
# Private Helpers
# ===------------------------------------------------------------------=== #

alias _pop_int_literal = __mlir_type.`!pop.int_literal`


@always_inline("nodebug")
fn _gcd[a: _pop_int_literal, b: _pop_int_literal]() -> _pop_int_literal:
    alias a_ = IntLiteral[a]()
    alias b_ = IntLiteral[b]()

    @parameter
    if b_:
        return _gcd[b, (a_ % b_).value]()
    else:
        return a


@always_inline("nodebug")
fn gcd[
    a: IntLiteral, b: IntLiteral
](out res: IntLiteral[_gcd[a.value, b.value]()]):
    res = __type_of(res)()


@always_inline("nodebug")
fn _max[a: _pop_int_literal, b: _pop_int_literal]() -> _pop_int_literal:
    alias a_ = IntLiteral[a]()
    alias b_ = IntLiteral[b]()

    @parameter
    if a_ > b_:
        return a
    else:
        return b


@always_inline("nodebug")
fn max[
    a: IntLiteral, b: IntLiteral
](out res: IntLiteral[_max[a.value, b.value]()]):
    res = __type_of(res)()


@always_inline("nodebug")
fn _pow[
    x: _pop_int_literal, n: _pop_int_literal, acc: _pop_int_literal
]() -> _pop_int_literal:
    alias x_ = IntLiteral[x]()
    alias n_ = IntLiteral[n]()
    alias acc_ = IntLiteral[acc]()
    constrained[n_ >= 0, "Cannot use negative power"]()

    @parameter
    if n_ == 0:
        return acc
    else:
        return _pow[x, (n_ - 1).value, (acc_ * x_).value]()


@always_inline("nodebug")
fn pow[
    x: IntLiteral, n: IntLiteral
](out res: IntLiteral[_pow[x.value, n.value, (1).value]()]):
    res = __type_of(res)()


@always_inline("nodebug")
fn ternary[
    a: IntLiteral, b: IntLiteral, cond: Bool
](out res: IntLiteral[_ternary[a.value, b.value, cond]()]):
    return __type_of(res)()


@always_inline("nodebug")
fn _ternary[
    a: _pop_int_literal, b: _pop_int_literal, cond: Bool
]() -> _pop_int_literal:
    return a if cond else b
