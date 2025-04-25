from kelvin import *
from sys.param_env import *


def main():
    alias A = Second[_, 4]
    alias B = Second[_, 2]

    var c = A(10) + B(20)
