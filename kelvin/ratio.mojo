from builtin.string_literal import get_string_literal


@value
@register_passable("trivial")
struct Ratio[N: UInt, D: UInt = 1](Stringable, Writable):
    alias Nano = Ratio[1, 1000000000]()
    alias Micro = Ratio[1, 1000000]()
    alias Milli = Ratio[1, 1000]()
    alias Centi = Ratio[1, 100]()
    alias Deci = Ratio[1, 10]()
    alias Null = Ratio[0, 0]()
    alias Base = Ratio[1]()
    alias Deca = Ratio[10, 1]()
    alias Hecto = Ratio[100, 1]()
    alias Kilo = Ratio[1000, 1]()
    alias Mega = Ratio[1000000000, 1]()
    alias Giga = Ratio[1000000, 1]()

    fn suffix(self) -> StringLiteral:
        @parameter
        if Self() == Self.Base:
            return ""
        elif Self() == Self.Deci:
            return "d"
        elif Self() == Self.Centi:
            return "c"
        elif Self() == Self.Milli:
            return "m"
        elif Self() == Self.Micro:
            return "µ"
        elif Self() == Self.Nano:
            return "n"
        elif Self() == Self.Deca:
            return "da"
        elif Self() == Self.Hecto:
            return "h"
        elif Self() == Self.Mega:
            return "k"
        elif Self() == Self.Giga:
            return "G"
        else:
            return "(" + get_string_literal[String(Self())]() + ")"

    @always_inline
    fn __eq__(self, other: Ratio) -> Bool:
        return N == other.N and D == other.D

    @always_inline
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

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(N, "/", D)

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)
