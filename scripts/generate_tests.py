
template = \
"""from kelvin import *
from testing import *

# AUTOMATICALLY GENERATED TESTS, DO NOT EDIT

def test_ctor():
    var a = {0}(10)
    assert_equal(a.value(), 10.0)
    assert_equal(a.DT, DType.float64)

    var b = {0}[DType.int64](10)
    assert_equal(b.value(), 10)
    assert_equal(b.DT, DType.int64)

    var c: {0}[Width=4] = [1, 2, 3, 4]
    var d = {0}[Width=4](1, 2, 3, 4)
    assert_equal(c, d)
    for i in range(4):
        assert_equal(c[i], i + 1)


def test_add():
    assert_equal({0}(10) + {0}(5), {0}(15))
    var s = {0}(30)
    s += {0}(20)
    assert_equal(s, {0}(50))


def test_sub():
    assert_equal({0}(10) - {0}(5), {0}(5))
    var s = {0}(30)
    s -= {0}(20)
    assert_equal(s, {0}(10))

def test_div():
    var a = {0}(20) / {0}(10)
    assert_equal(a.value(), 2.0)
    assert_equal(String(a), '2.0')

def test_mul():
    var a = {0}(20) * {0}(2)
    assert_equal(a.value(), 40.0)

def test_str():
    assert_equal(String({0}(10)), "10.0 {1}")

def test_eq():
    assert_equal({0}(10), {0}(10))
    assert_not_equal({0}(10), {0}(20))

def test_scalar_arithmetic():
    var a = {0}(10)
    assert_equal(a * 5, {0}(50))
    a *= 5
    assert_equal(a, {0}(50))
    assert_equal(a / 5, {0}(10))
    a /= 5
    assert_equal(a, {0}(10))

    a = {0}(10)
    assert_equal(5 * a, {0}(50))
    assert_equal(20 / a, Quantity[-{0}.D](2))

def test_bool():
    assert_true(Bool({0}(10)))
    assert_false(Bool({0}(0)))

    if not {0}(10):
        assert_true(False)
    
    if {0}(0):
        assert_true(False)

def test_compare():
    assert_true({0}(10) == {0}(10))
    assert_true({0}(10) < {0}(20))
    assert_true({0}(20) > {0}(10))
    assert_true({0}(10) <= {0}(10))
    assert_true({0}(10) <= {0}(20))
    assert_true({0}(10) >= {0}(10))
    assert_true({0}(20) >= {0}(10))

    comptime T = {0}[Width=4]
    comptime B = SIMD[DType.bool, 4]
    assert_equal(T(1, 2, 3, 4).eq(T(1, 4, 3, 12)), B(True, False, True, False))
    assert_equal(T(1, 2, 3, 4).ne(T(4, 3, 3, 1)), B(True, True, False, True))
    assert_equal(T(1, 2, 3, 4).lt(T(1, 4, 5, 2)), B(False, True, True, False))
    assert_equal(T(1, 2, 3, 4).le(T(1, 4, 5, 2)), B(True, True, True, False))
    assert_equal(T(1, 2, 3, 4).gt(T(1, 4, 5, 2)), B(False, False, False, True))
    assert_equal(T(1, 2, 3, 4).ge(T(1, 4, 5, 2)), B(True, False, False, True))

def test_simd():
    comptime Vec = SIMD[DType.int64, 4]
    comptime S = {0}[DType.int64, 4]

    assert_equal(S(Vec(1, 2, 3, 4)), S(Vec(1, 2, 3, 4)))
    assert_equal(S(Vec(1, 2, 3, 4)) * 3, S(Vec(3, 6, 9, 12)))
    assert_equal(S(Vec(1, 2, 3, 4)) + S(Vec(1, 2, 3, 4)), S(Vec(2, 4, 6, 8)))
    assert_true(S(Vec(1, 2, 3, 4)))
    assert_false(S(Vec(0, 0, 0, 0)))
"""

cast_test_template = \
"""
def test_cast():
    var a = {0}(cast_from={1}(10))
    assert_equal(a.value(), {2})
"""

if __name__ == '__main__':
    test_configs = [
        {
            'module_name': 'time',
            'unit_name': 'Second',
            'str_suffix': 's^1',
            'cast_test_config': {
                'other_type': 'Minute',
                'expected_value': 600
            }
        },
        {
            'module_name': 'length',
            'unit_name': 'Meter',
            'str_suffix': 'm^1',
            'cast_test_config': {
                'other_type': 'Kilometer',
                'expected_value': 10000
            }
        },
        {
            'module_name': 'mass',
            'unit_name': 'Kilogram',
            'str_suffix': 'kg^1'
        },
        {
            'module_name': 'acceleration',
            'unit_name': 'MetersPerSecondSquared',
            'str_suffix': 'm^1 s^-2'
        },
        {
            'module_name': 'area',
            'unit_name': 'MetersSquared',
            'str_suffix': 'm^2'
        },
        {
            'module_name': 'velocity',
            'unit_name': 'MetersPerSecond',
            'str_suffix': 'm^1 s^-1',
            'cast_test_config': {
                'other_type': 'MilesPerHour',
                'expected_value': 4.4704
            }
        },
        {
            'module_name': 'electricity',
            'unit_name': 'Ampere',
            'str_suffix': 'A^1'
        },
        {
            'module_name': 'substance_amount',
            'unit_name': 'Mole',
            'str_suffix': 'mol^1'
        },
        {
            'module_name': 'temperature',
            'unit_name': 'Kelvin',
            'str_suffix': 'K^1'
        },
        {
            'module_name': 'luminosity',
            'unit_name': 'Candela',
            'str_suffix': 'cd^1'
        },
        {
            'module_name': 'energy',
            'unit_name': 'Joule',
            'str_suffix': 'm^2 kg^1 s^-2'
        },
        {
            'module_name': 'electric_charge',
            'unit_name': 'Coulomb',
            'str_suffix': 's^1 A^1'
        },
    ]

    for config in test_configs:
        s = template.format(config['unit_name'], config['str_suffix'])
        with open(f'test/kelvin/test_{config["module_name"]}.mojo', 'w') as f:
            f.write(s)

            if 'cast_test_config' in config:
                c = config['cast_test_config']
                s = cast_test_template.format(config['unit_name'], c['other_type'], c['expected_value'])
                f.write('\n' + s)
            
            f.write("""
def main():
    TestSuite.discover_tests[__functions_in_module()]().run()""")



