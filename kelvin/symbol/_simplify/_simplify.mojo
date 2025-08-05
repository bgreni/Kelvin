from kelvin.symbol import *


fn simplify(orig: Expr, out e: Expr):
    var before = orig
    while True:
        e = expand(orig)
        e = apply_arithmetic_rules(e)

        if e == before:
            break
        before = e


fn expand(e: Expr) -> Expr:
    if e.is_binary_op():
        var op = e.binary_op()

        var left = expand(op.left())
        var right = expand(op.right())

        if op.is_mult():
            if left.is_binary_add():
                # (a + b) * c = a*c + b*c
                var t1 = Mul(left.binary_op().left(), right)
                var t2 = Mul(left.binary_op().right(), right)
                return expand(Add(t1, t2))

            elif right.is_binary_add():
                # a * (b + c) = a*b + a*c
                var t1 = Mul(left, right.binary_op().left())
                var t2 = Mul(left, right.binary_op().right())
                return expand(Add(t1, t2))

        return BinaryOp(left, op.op, right)

    elif e.is_unary_op():
        var op = e.unary_op()
        return UnaryOp(op.op, expand(op.expr()))

    return e


fn apply_arithmetic_rules(e: Expr) -> Expr:
    if e.is_binary_op():
        var op = e.binary_op()

        var left = apply_arithmetic_rules(op.left())
        var right = apply_arithmetic_rules(op.right())

        if left.is_number() and right.is_number():
            if op.is_add():
                return left.number() + right.number()
            elif op.is_sub():
                return left.number() - right.number()
            elif op.is_mult():
                return left.number() * right.number()
            elif op.is_div():
                if right.number() != 0:
                    return left.number() / right.number()
            elif op.is_pow():
                return left.number() ** right.number()

        # Identity rules
        if op.is_add():
            if left.is_zero():
                return right
            elif right.is_zero():
                return left

        elif op.is_mult():
            if left.is_number():
                if left.number() == 0:
                    return Number(0)
                elif left.number() == 1:
                    return right

            if right.is_number():
                if right.number() == 0:
                    return Number(0)
                elif right.number() == 1:
                    return left
        return BinaryOp(left, op.op, right)
    elif e.is_unary_op():
        var op = e.unary_op()
        var operand = apply_arithmetic_rules(op.expr())

        if op.op == UnaryOpType.Neg and operand.is_number():
            return Number(-operand.number().value)

        return UnaryOp(op.op, operand)

    return e


fn _collect_like_terms(e: Expr) -> Expr:
    return Number(0)
