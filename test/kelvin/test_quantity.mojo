from kelvin import *
from testing import *
from collections import Dict


def test_seconds_to_minutes():
    assert_equal(Minute(cast_from=Second(600)), Minute(10))
    assert_equal(Second(cast_from=Minute(10)), Second(600))


def test_mph_to_mps():
    assert_equal(
        MetersPerSecond(cast_from=MilesPerHour(50)), MetersPerSecond(22.352)
    )


def test_unit_squared():
    comptime S2 = Quantity[Second.D * Second.D]
    comptime M2 = Quantity[Minute.D * Minute.D]
    assert_equal(S2(cast_from=M2(1)), S2(3600))
    assert_equal(M2(cast_from=S2(1)), M2(1 / 3600))


def test_mul():
    assert_equal(Meter(20) * Meter(3), MetersSquared(60))


def test_div():
    assert_equal(Meter(30) / Second(5), MetersPerSecond(6))


def test_integer_values():
    comptime DT = DType.int64
    comptime S = Second[DT]
    comptime M = Meter[DT]
    comptime MPS = Quantity[M.D / S.D, DT]
    comptime MPH = Quantity[Mile.D / Hour.D, DT]

    assert_equal(S(20).value(), Int64(20))
    assert_equal(M(5) / S(2), MPS(2))
    assert_equal(MPS(cast_from=MPH(10)), MPS(4))


def test_pow():
    assert_equal(Meter(10) ** 2, MetersSquared(100))


def test_can_be_used_in_container():
    var l = List(Second(1), Second(2))
    assert_equal(l[0], Second(1))

    var d = Dict[Second, Meter]()
    d[Second(1)] = Meter(10)
    assert_equal(d[Second(1)], Meter(10))


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
