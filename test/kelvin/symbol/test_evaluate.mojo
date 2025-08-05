from kelvin.symbol import *
from testing import *


def test_evaluate():
    var expr = Add(Symbol("a"), Number(10))

    assert_equal(evaluate(expr, {"a": Number(2)}), Number(12))
