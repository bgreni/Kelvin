@register_passable("trivial")
struct Number(
    EqualityComparable, ImplicitlyCopyable, Movable, Stringable, Writable
):
    var value: Int

    @implicit
    fn __init__(out self, i: Int):
        self.value = i

    fn __eq__(self, other: Self) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn __add__(self, other: Self) -> Self:
        return Self(self.value + other.value)

    fn __sub__(self, other: Self) -> Self:
        return Self(self.value - other.value)

    fn __mul__(self, other: Self) -> Self:
        return Self(self.value * other.value)

    fn __truediv__(self, other: Self) -> Self:
        return Self(self.value // other.value)

    fn __pow__(self, other: Self) -> Self:
        return Self(self.value**other.value)

    fn write_to(self, mut writer: Some[Writer]):
        writer.write(self.value)

    fn __str__(self, out s: String):
        return String.write(self)

    fn __repr__(self) -> String:
        return self.__str__()


@fieldwise_init
struct Symbol(
    Copyable, EqualityComparable, Movable, Representable, Stringable, Writable
):
    var name: String

    fn __eq__(self, other: Self) -> Bool:
        return self.name == other.name

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn write_to(self, mut writer: Some[Writer]):
        writer.write(self.name)

    fn __str__(self) -> String:
        return self.name

    fn __repr__(self) -> String:
        return self.name
