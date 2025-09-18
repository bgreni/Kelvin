from kelvin.symbol import *
from os import abort


fn evaluate(e: Expr, vars: Dict[String, Number]) raises -> Number:
    if e.is_binary_op():
        ref op = e.binary_op()
        var left = evaluate(op.left(), vars)
        var right = evaluate(op.right(), vars)

        if op.is_add():
            return left + right
        elif op.is_sub():
            return left - right
        elif op.is_mult():
            return left * right
        elif op.is_div():
            return left / right
        elif op.is_pow():
            return left**right

        abort("unreachable: evaluate binary op")

    elif e.is_unary_op():
        ref op = e.unary_op()
        var operand = evaluate(op.expr(), vars)

        if op.is_neg():
            return Number(-operand.value)

        abort("unreachable: evaluate unary op")

    elif e.is_symbol():
        var sym = e.symbol().name

        if sym not in vars:
            raise "Variable definition not given for: " + sym

        return vars[sym]

    return e.number()
