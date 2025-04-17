from kelvin import *
from testing import *


def test_seconds_to_minutes():
    assert_equal(Minute(cast_from=Second(600)), Minute(10))
    assert_equal(Second(cast_from=Minute(10)), Second(600))


def test_mph_to_mps():
    assert_equal(
        MetersPerSecond(cast_from=MilesPerHour(50)), MetersPerSecond(22.352)
    )


def test_unit_squared():
    alias S2 = Quantity[Second.D * Second.D, _]
    alias M2 = Quantity[Minute.D * Minute.D, _]
    assert_equal(S2(cast_from=M2(1)), S2(3600))  # Example assertion
    assert_equal(M2(cast_from=S2(1)), M2(1 / 3600))  # Example assertion
