from kelvin import *
from testing import *


def test_seconds_to_minutes():
    assert_equal(Minute(cast_from=Second(600)), Minute(10))
    assert_equal(Second(cast_from=Minute(10)), Second(600))


def test_mph_to_mps():
    assert_equal(
        MetersPerSecond(cast_from=MilesPerHour(50)), MetersPerSecond(22.352)
    )
