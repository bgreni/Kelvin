from kelvin import *
from sys.param_env import *


def main():
    alias CASE = env_get_string["CASE"]()

    @parameter
    if CASE == "add":
        var a = Meter(10) + Second(10)
    elif CASE == "sub":
        var a = Meter(10) - Second(10)
