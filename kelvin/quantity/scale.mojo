from math import pi


@register_passable("trivial")
struct Scale[value: FloatLiteral](Stringable, Writable):
    """A compile time, known value, used to represent the scale of a particular
    unit.
    """

    alias Quecto = Scale[1e-30]()
    alias Ronto = Scale[1e-27]()
    alias Yocto = Scale[1e-24]()
    alias Zepto = Scale[1e-21]()
    alias Atto = Scale[1e-18]()
    alias Femto = Scale[1e-15]()
    alias Pico = Scale[1e-12]()
    alias Nano = Scale[1e-9]()
    alias Micro = Scale[1e-6]()
    alias Milli = Scale[1e-3]()
    alias Centi = Scale[1e-2]()
    alias Deci = Scale[0.1]()
    alias Unitary = Scale[1]()
    alias Deca = Scale[10]()
    alias Hecto = Scale[1e2]()
    alias Kilo = Scale[1e3]()
    alias Mega = Scale[1e6]()
    alias Giga = Scale[1e9]()
    alias Tera = Scale[1e12]()
    alias Peta = Scale[1e15]()
    alias Exa = Scale[1e18]()
    alias Zetta = Scale[1e21]()
    alias Yotta = Scale[1e24]()
    alias Ronna = Scale[1e27]()
    alias Quetta = Scale[1e30]()

    alias PI = Scale[pi]

    alias Invalid = Scale[0]()

    @always_inline("builtin")
    fn __init__(out self):
        pass

    @always_inline("builtin")
    fn __bool__(self) -> Bool:
        return self != Scale.Invalid

    @always_inline("builtin")
    fn __as_bool__(self) -> Bool:
        return self.__bool__()

    @always_inline("builtin")
    fn __eq__(self, other: Scale) -> Bool:
        return value == other.value

    @always_inline("builtin")
    fn __ne__(self, other: Scale) -> Bool:
        return not self == other

    @always_inline
    fn __gt__(self, other: Scale) -> Bool:
        return value > other.value

    @always_inline
    fn __lt__(self, other: Scale) -> Bool:
        return other > self

    @always_inline
    fn __ge__(self, other: Scale) -> Bool:
        return value >= other.value

    @always_inline
    fn __le__(self, other: Scale) -> Bool:
        return other >= self

    @always_inline("builtin")
    fn __add__(self, other: Scale, out res: Scale[value + other.value]):
        return __type_of(res)()

    @always_inline("builtin")
    fn __mul__(self, other: Scale, out res: Scale[value * other.value]):
        return __type_of(res)()

    fn __mul__(self, other: Scalar) -> Scalar[other.dtype]:
        constrained[other.dtype.is_floating_point()]()
        return other * value

    @always_inline
    fn __rmul__(self, other: Scalar) -> Scalar[other.dtype]:
        constrained[other.dtype.is_floating_point()]()
        return other * value

    @always_inline("builtin")
    fn __truediv__(self, other: Scale, out res: Scale[value / other.value]):
        return __type_of(res)()

    @always_inline
    fn __truediv__(self, other: Scalar) -> Scalar[other.dtype]:
        constrained[other.dtype.is_floating_point()]()
        return value / other

    @always_inline
    fn __rtruediv__(
        self,
        other: Scalar,
    ) -> Scalar[other.dtype]:
        constrained[other.dtype.is_floating_point()]()
        return other / value

    # TODO: ? stdlib doesn't have FloatLiteral**FloatLiteral implemented yet
    # @always_inline
    # fn __pow__(self, p: FloatLiteral, out res: Scale[value**p]):
    #     return __type_of(res)()

    # TODO: ? is this even defined?
    # @always_inline("builtin")
    # fn __or__(self, other: Scale, out res: Scale[max(value, __type_of(other).value)]):
    #     constrained[value == 0 or other.value == 0]()
    #     return __type_of(res)()

    @always_inline
    fn write_to(self, mut writer: Some[Writer]):
        writer.write(value)

    @always_inline
    fn __str__(self) -> String:
        return String.write(self)
