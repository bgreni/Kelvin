from math import pi


@register_passable("trivial")
struct Scale[value: FloatLiteral](ImplicitlyCopyable, Stringable, Writable):
    """A compile time, known value, used to represent the scale of a particular
    unit.
    """

    comptime Quecto = Scale[1e-30]()
    comptime Ronto = Scale[1e-27]()
    comptime Yocto = Scale[1e-24]()
    comptime Zepto = Scale[1e-21]()
    comptime Atto = Scale[1e-18]()
    comptime Femto = Scale[1e-15]()
    comptime Pico = Scale[1e-12]()
    comptime Nano = Scale[1e-9]()
    comptime Micro = Scale[1e-6]()
    comptime Milli = Scale[1e-3]()
    comptime Centi = Scale[1e-2]()
    comptime Deci = Scale[0.1]()
    comptime Unitary = Scale[1]()
    comptime Deca = Scale[10]()
    comptime Hecto = Scale[1e2]()
    comptime Kilo = Scale[1e3]()
    comptime Mega = Scale[1e6]()
    comptime Giga = Scale[1e9]()
    comptime Tera = Scale[1e12]()
    comptime Peta = Scale[1e15]()
    comptime Exa = Scale[1e18]()
    comptime Zetta = Scale[1e21]()
    comptime Yotta = Scale[1e24]()
    comptime Ronna = Scale[1e27]()
    comptime Quetta = Scale[1e30]()

    comptime PI = Scale[pi]

    comptime Invalid = Scale[0]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return self != Scale.Invalid

    @always_inline("builtin")
    fn __eq__(self, other: Scale) -> Bool:
        return Self.value == other.value

    @always_inline("builtin")
    fn __ne__(self, other: Scale) -> Bool:
        return not self == other

    @always_inline
    fn __gt__(self, other: Scale) -> Bool:
        return Self.value > other.value

    @always_inline
    fn __lt__(self, other: Scale) -> Bool:
        return other > self

    @always_inline
    fn __ge__(self, other: Scale) -> Bool:
        return Self.value >= other.value

    @always_inline
    fn __le__(self, other: Scale) -> Bool:
        return other >= self

    @always_inline("builtin")
    fn __add__(self, other: Scale) -> Scale[Self.value + other.value]:
        return {}

    @always_inline("builtin")
    fn __mul__(self, other: Scale) -> Scale[Self.value * other.value]:
        return {}

    @always_inline
    fn __mul__(self, other: Scalar) -> Scalar[other.dtype]:
        __comptime_assert other.dtype.is_floating_point()
        return other * Self.value

    @always_inline
    fn __rmul__(self, other: Scalar) -> Scalar[other.dtype]:
        __comptime_assert other.dtype.is_floating_point()
        return other * Self.value

    @always_inline("builtin")
    fn __truediv__(self, other: Scale) -> Scale[Self.value / other.value]:
        return {}

    @always_inline
    fn __truediv__(self, other: Scalar) -> Scalar[other.dtype]:
        __comptime_assert other.dtype.is_floating_point()
        return Self.value / other

    @always_inline
    fn __rtruediv__(
        self,
        other: Scalar,
    ) -> Scalar[other.dtype]:
        __comptime_assert other.dtype.is_floating_point()
        return other / Self.value

    # TODO: ? stdlib doesn't have FloatLiteral**FloatLiteral implemented yet
    # @always_inline
    # fn __pow__(self, p: FloatLiteral, out res: Scale[value**p]):
    #     return type_of(res)()

    # TODO: ? is this even defined?
    # @always_inline("builtin")
    # fn __or__(self, other: Scale, out res: Scale[max(value, type_of(other).value)]):
    #     __comptime_assert value == 0 or other.value == 0
    #     return type_of(res)()

    @always_inline
    fn write_to(self, mut writer: Some[Writer]):
        writer.write(Self.value)

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)
