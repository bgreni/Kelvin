import z3


def Max(a, b):
    return z3.If(a > b, a, b)


def add(n1, d1, n2, d2):
    return n1 * d2 + n2 * d1, d1 * d2


def add_max(n1, d1, n2, d2):
    # alternatively:
    # return Max(n1 * d2, n1) + Max(n2 * d1, n2), Max(d1 * d2, Max(d1, d2))
    return Max(n1 * d2 + n2 * d1, n1 + n2), Max(d1 * d2, Max(d1, d2))


n1, d1 = z3.Int("n1"), z3.Int("d1")
n2, d2 = z3.Int("n2"), z3.Int("d2")

ref_n, ref_d = add(n1, d1, n2, d2)
res_n, res_d = add_max(n1, d1, n2, d2)

# add_max(p, q) == add(p, q) if p > 0 and q > 0
prop1 = z3.Implies(
    z3.And(n1 > 0, d1 > 0, n2 > 0, d2 > 0),
    z3.And(ref_n == res_n, ref_d == res_d),
)

# add_max(0, q) == q
prop2 = z3.Implies(
    z3.And(n1 == 0, d1 == 0, n2 >= 0, d2 >= 0),
    z3.And(n2 == res_n, d2 == res_d),
)

# add_max(q, 0) == q
prop3 = z3.Implies(
    z3.And(n1 >= 0, d1 >= 0, n2 == 0, d2 == 0),
    z3.And(n1 == res_n, d1 == res_d),
)

prop = z3.And(prop1, prop2, prop3)

s = z3.Solver()
s.add(z3.Not(prop))

if s.check() == z3.unsat:
    print("No counterexample found.")
else:
    print(s.model())
