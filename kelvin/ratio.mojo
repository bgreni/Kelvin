from math import gcd


@value
@register_passable("trivial")
struct Ratio[N: UInt, D: UInt = 1](Stringable, Writable):
    """A compile time, known rational value, used to represent the scale
    of a particular unit.
    """

    alias Nano = Ratio[1, 10**9]()
    alias Micro = Ratio[1, 10**6]()
    alias Milli = Ratio[1, 10**3]()
    alias Centi = Ratio[1, 100]()
    alias Deci = Ratio[1, 10]()
    alias Unitary = Ratio[1]()
    alias Deca = Ratio[10]()
    alias Hecto = Ratio[100]()
    alias Kilo = Ratio[10**3]()
    alias Mega = Ratio[10**6]()
    alias Giga = Ratio[10**9]()

    alias PI = Ratio[355, 113]()

    alias _GCD = gcd(N, D)

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

    @always_inline("builtin")
    fn __add__(
        self,
        other: Ratio,
        out res: Ratio[
            max(N * other.D + other.N * D, N + other.N),
            max(D * other.D, max(D, other.D)),
        ],
    ):
        """Bit of a hack so that Ratio[0, 0]() + Ratio[1, 2]() == Ratio[1, 2]().
        As otherwise that is undefined in standard rational arithmetic, but we
        need it so we can handle, and represent the lack of dimensions nicely.

        Proof of equivalence to standard addition at misc/ratio_add_proof.py
        """
        return __type_of(res)()

    @always_inline
    fn __mul__(self, other: Scalar) -> Scalar[other.dtype]:
        @parameter
        if other.dtype.is_integral():
            return (other * N) // D
        else:
            return (other * N) / D

    @always_inline
    fn __rmul__(self, other: Scalar) -> Scalar[other.dtype]:
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
    fn __truediv__(self, other: Scalar) -> Scalar[other.dtype]:
        @parameter
        if other.dtype.is_integral():
            return N // (other * D)
        else:
            return N / (other * D)

    @always_inline
    fn __rtruediv__(self, other: Scalar) -> Scalar[other.dtype]:
        return other * Ratio[D, N]()

    @always_inline
    fn __pow__(
        self,
        p: IntLiteral,
        out res: Ratio[
            (N if __type_of(p)() >= 0 else D) ** abs(__type_of(p)()),
            (D if __type_of(p)() >= 0 else N) ** abs(__type_of(p)()),
        ],
    ):
        return __type_of(res)()

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
