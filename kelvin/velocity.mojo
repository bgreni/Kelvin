from .time import Time
from .length import Length

@value
@register_passable("trivial")
struct Velocity[LRatio: Ratio, TRatio: Ratio]:

    alias L = Length[LRatio]
    alias T = Time[TRatio]
    var _value: Float64

    fn __init__(out self, l: Self.L, t: Self.T):
        self._value = l.count() / t.count()

    @always_inline
    fn write_to[W: Writer](self, mut writer: W):
        writer.write(self._value, " ", Self.L.suffix_for_ratio(), "/", Self.T.suffix_for_ratio())
    
    @always_inline
    fn __eq__(self, other: Self) -> Bool:
        return self._value == other._value

    @always_inline
    fn __ne__(self, other: Self) -> Bool:
        return self._value != other._value

    @always_inline
    fn __gt__(self, other: Self) -> Bool:
        return self._value > other._value

    @always_inline
    fn __lt__(self, other: Self) -> Bool:
        return self._value < other._value

    @always_inline
    fn __ge__(self, other: Self) -> Bool:
        return self._value >= other._value

    @always_inline
    fn __le__(self, other: Self) -> Bool:
        return self._value <= other._value

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
    fn __mul__(self, other: Self) -> Self:
        return Self(self._value * other._value)

    @always_inline
    fn __imul__(mut self, other: Self):
        self._value *= other._value

    @always_inline
    fn __truediv__(self, other: Self) -> Self:
        return Self(self._value // other._value)

    @always_inline
    fn __itruediv__(mut self, other: Self):
        self._value //= other._value

    @always_inline
    fn __div__(self, other: Self) -> Self:
        return Self(self._value // other._value)

    @always_inline
    fn __idiv__(mut self, other: Self):
        self._value //= other._value

    @always_inline
    fn __mod__(self, other: Self) -> Self:
        return Self(self._value % other._value)

    @always_inline
    fn __imod__(mut self, other: Self):
        self._value %= other._value

    @always_inline
    fn count(self) -> Int:
        return self._value
