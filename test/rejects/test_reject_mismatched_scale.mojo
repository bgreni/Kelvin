from kelvin import *
from sys.param_env import *


def main():
    alias CASE = env_get_string["CASE"]()

    @parameter
    if CASE == "mul":
        var a = Meter(10) * Mile(10)
    elif CASE == "div":
        var a = Meter(10) / Mile(10)
