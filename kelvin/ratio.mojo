from math import gcd


@value
struct B[b: Bool]:
    alias M = UInt(b)

    fn __mul__[
        N: UInt, D: UInt
    ](self, other: Ratio[N, D], out res: Ratio[N * Self.M, D * Self.M]):
        return __type_of(res)()


@value
@register_passable("trivial")
struct Ratio[N: UInt, D: UInt = 1](Stringable, Writable):
    alias Nano = Ratio[
        1,
        1000000000,
    ]()
    alias Micro = Ratio[1, 1000000]()
    alias Milli = Ratio[1, 1000]()
    alias Centi = Ratio[1, 100]()
    alias Deci = Ratio[1, 10]()
    alias Unitary = Ratio[1]()
    alias Deca = Ratio[10, 1]()
    alias Hecto = Ratio[100, 1]()
    alias Kilo = Ratio[1000, 1]()
    alias Mega = Ratio[1000000000, 1]()
    alias Giga = Ratio[1000000, 1]()
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
        return self != Ratio.Invalid

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
        return N * other.D < D * other.N

    @always_inline
    fn __ge__(self, other: Ratio) -> Bool:
        return N * other.D >= D * other.N

    @always_inline
    fn __le__(self, other: Ratio) -> Bool:
        return N * other.D <= D * other.N

    @always_inline
    fn __mul__(self, other: Scalar) -> Scalar[other.dtype]:
        @parameter
        if other.dtype.is_integral():
            return (other * N) // D
        else:
            return (other * N) / D

    @always_inline("builtin")
    fn __add__[
        NO: UInt, DO: UInt, //
    ](self, other: Ratio[NO, DO], out result: Ratio[N * DO + NO * D, D * DO],):
        return __type_of(result)()

    @always_inline("builtin")
    fn __mul__[
        NO: UInt, DO: UInt, //
    ](self, other: Ratio[NO, DO], out result: Ratio[N * NO, D * DO]):
        return __type_of(result)()

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(N, "/", D)

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)

    @always_inline("builtin")
    fn simplify(self, out output: Ratio[N // Self._GCD, D // Self._GCD]):
        output = __type_of(output)()

    @always_inline("builtin")
    fn __or__(self, other: Ratio, out res: Ratio[N | other.N, D | other.D]):
        return __type_of(res)()

    @always_inline("builtin")
    fn __truediv__(
        self,
        other: Ratio,
        out res: Ratio[(Self.N * other.D), (Self.D * other.N)],
    ):
        return __type_of(res)()

    @always_inline
    fn divide_scalar(self, owned v: Scalar) -> __type_of(v):
        var OD = 1
        v *= D
        OD *= N

        @parameter
        if v.dtype.is_integral():
            return v // OD
        else:
            return v / OD
