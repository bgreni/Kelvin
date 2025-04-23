from kelvin import *
from sys.param_env import *


def main():
    alias CASE = env_get_string["CASE"]()

    @parameter
    if CASE == "add":
        var a = Meter(10) + 10
    elif CASE == "radd":
        var a = 10 + Meter(10)
    elif CASE == "iadd":
        var a = Meter(10)
        a += 10
    elif CASE == "sub":
        var a = Meter(10) - 10
    elif CASE == "rsub":
        var a = 10 - Meter(10)
    elif CASE == "isub":
        var a = Meter(10)
        a -= 10
