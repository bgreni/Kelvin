from kelvin import *
from sys.param_env import *


def main():
    comptime A = Second[_, 4]
    comptime B = Second[_, 2]

    var c = A(10) + B(20)
