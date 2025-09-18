from utils import Variant


@fieldwise_init
@register_passable("trivial")
struct NumberToken(Copyable, Movable):
    var value: Int


@fieldwise_init
@register_passable("trivial")
struct AddToken(Copyable, Movable):
    ...


@fieldwise_init
@register_passable("trivial")
struct SubToken(Copyable, Movable):
    ...


@fieldwise_init
@register_passable("trivial")
struct PowerToken(Copyable, Movable):
    ...


@fieldwise_init
@register_passable("trivial")
struct MultToken(Copyable, Movable):
    ...


@fieldwise_init
@register_passable("trivial")
struct DivToken(Copyable, Movable):
    ...


@fieldwise_init
struct SymbolToken(Copyable, Movable):
    var value: String


@fieldwise_init
@register_passable("trivial")
struct RParenToken(Copyable, Movable):
    ...


@fieldwise_init
@register_passable("trivial")
struct LParenToken(Copyable, Movable):
    ...


@fieldwise_init
struct Token(
    Copyable, EqualityComparable, Movable, Representable, Stringable, Writable
):
    var value: Variant[
        NumberToken,
        AddToken,
        SubToken,
        MultToken,
        DivToken,
        PowerToken,
        SymbolToken,
        LParenToken,
        RParenToken,
    ]

    @implicit
    fn __init__(out self, n: NumberToken):
        self.value = n

    @implicit
    fn __init__(out self, n: AddToken):
        self.value = n

    @implicit
    fn __init__(out self, n: SubToken):
        self.value = n

    @implicit
    fn __init__(out self, n: PowerToken):
        self.value = n

    @implicit
    fn __init__(out self, n: MultToken):
        self.value = n

    @implicit
    fn __init__(out self, n: DivToken):
        self.value = n

    @implicit
    fn __init__(out self, var n: SymbolToken):
        self.value = n^

    @implicit
    fn __init__(out self, n: LParenToken):
        self.value = n

    @implicit
    fn __init__(out self, n: RParenToken):
        self.value = n

    fn is_sub(self) -> Bool:
        return self.isa[SubToken]()

    fn is_add(self) -> Bool:
        return self.isa[AddToken]()

    fn is_mult(self) -> Bool:
        return self.isa[MultToken]()

    fn is_div(self) -> Bool:
        return self.isa[DivToken]()

    fn is_number(self) -> Bool:
        return self.isa[NumberToken]()

    fn number(self) -> NumberToken:
        return self.value[NumberToken]

    fn is_lparen(self) -> Bool:
        return self.isa[LParenToken]()

    fn is_rparen(self) -> Bool:
        return self.isa[RParenToken]()

    fn is_symbol(self) -> Bool:
        return self.isa[SymbolToken]()

    fn is_power(self) -> Bool:
        return self.isa[PowerToken]()

    fn symbol(self) -> ref [self.value] SymbolToken:
        return self.value[SymbolToken]

    fn isa[T: Copyable & Movable](self) -> Bool:
        return self.value.isa[T]()

    fn one_of[*Ts: Copyable & Movable](self) -> Bool:
        @parameter
        for i in range(len(VariadicList(Ts))):
            if self.isa[Ts[i]]():
                return True
        return False

    fn __eq__(self, other: Self) -> Bool:
        if self.value._get_discr() != other.value._get_discr():
            return False

        if self.isa[NumberToken]():
            return (
                self.value[NumberToken].value == other.value[NumberToken].value
            )
        elif self.isa[SymbolToken]():
            return (
                self.value[SymbolToken].value == other.value[SymbolToken].value
            )
        return True

    fn __ne__(self, other: Self) -> Bool:
        return not self == other

    fn write_to[W: Writer](self, mut writer: W):
        if self.isa[NumberToken]():
            writer.write(self.value[NumberToken].value)
        elif self.isa[AddToken]():
            writer.write("+")
        elif self.isa[SubToken]():
            writer.write("-")
        elif self.isa[PowerToken]():
            writer.write("^")
        elif self.isa[MultToken]():
            writer.write("*")
        elif self.isa[DivToken]():
            writer.write("/")
        elif self.isa[SymbolToken]():
            writer.write(self.value[SymbolToken].value)
        elif self.isa[LParenToken]():
            writer.write("(")
        elif self.isa[RParenToken]():
            writer.write(")")

    fn __str__(self, out s: String):
        s = String()
        s.write(self)

    fn __repr__(self) -> String:
        return self.__str__()


fn lex(src: String) raises -> List[Token]:
    var pos = 0
    var output = List[Token]()
    while pos < len(src):
        var c = src[pos]

        pos += 1

        var node: Token

        if c.isspace():
            continue

        if c.is_ascii_digit():
            var start = pos - 1
            while pos < len(src) and src[pos].is_ascii_digit():
                pos += 1
            node = NumberToken(Int(src[start:pos]))
        elif c == "^":
            node = PowerToken()
        elif c == "*":
            node = MultToken()
        elif c == "+":
            node = AddToken()
        elif c == "-":
            node = SubToken()
        elif c == "*":
            node = MultToken()
        elif c == "/":
            node = DivToken()
        elif c == "(":
            node = LParenToken()
        elif c == ")":
            node = RParenToken()
        elif c.is_ascii_printable():
            node = SymbolToken(String(c))
        else:
            raise "Invalid token"

        output.append(node^)
    return output^
