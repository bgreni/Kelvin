from kelvin import *
from testing import assert_equal, TestSuite


def test_add():
    assert_equal(
        String(Scale[2.0 / 3.0]() + Scale[1.0 / 3.0]()),
        String(Scale[1.0 / 1.0]()),
    )
    assert_equal(
        String(Scale[2.0 / 3.0]() + Scale[3.0 / 1.0]()),
        String(Scale[11.0 / 3.0]()),
    )
    assert_equal(
        String(Scale[2.0 / 3.0]() + Scale[3.0 / 2.0]()),
        String(Scale[13.0 / 6.0]()),
    )
    assert_equal(
        String(Scale[(2.0 * 3.0) / (3.0 * 5.0)]() + Scale[2.0 / 5.0]()),
        String(Scale[4 / 5.0]()),
    )
    assert_equal(
        String(Scale.Invalid + Scale[1.0 / 2.0]()), String(Scale[1.0 / 2.0]())
    )
    assert_equal(
        String(Scale[1.0 / 2.0]() + Scale.Invalid), String(Scale[1.0 / 2.0]())
    )


def test_multiply():
    assert_equal(
        String(Scale[2.0 / 3.0]() * Scale[1.0 / 3.0]()),
        String(Scale[2.0 / 9.0]()),
    )
    assert_equal(
        String(Scale[2.0 / 3.0]() * Scale[3.0 / 1.0]()),
        String(Scale[2.0 / 1.0]()),
    )
    assert_equal(
        String(Scale[2.0 / 3.0]() * Scale[3.0 / 2.0]()),
        String(Scale[1.0 / 1.0]()),
    )
    assert_equal(
        String(Scale[(2.0 * 3.0) / (3.0 * 5.0)]() * Scale[5.0 / 2.0]()),
        String(Scale[1.0 / 1.0]()),
    )


def main():
    TestSuite.discover_tests[__functions_in_module()]().run()
