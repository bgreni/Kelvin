# Kelvin

A powerful dimensional analysis library written in Mojo for all you scientific computing needs.


## Usage

```mojo
from kelvin import *

# time dimension
var s = Seconds(10)

# length dimension
var m = Meter(10)

# velocity
var v = m / s


# Define arbitrary units
alias kg = Kilogram.D
alias m = Meter.D
alias s = Second.D
alias Newton = Quantity[kg * m * (s ** -2)]
var n = Newton(10)
```