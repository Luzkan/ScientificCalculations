# Marcel Jerzyk [03.12.2019 | 23:56-23:58]
# Task 6.

include("task4.jl")

f(x) = abs(x)
rysujNnfx(f, -1.0, 1.0, 5)
rysujNnfx(f, -1.0, 1.0, 10)
rysujNnfx(f, -1.0, 1.0, 15)

g(x) = 1/(1+(x^2))
rysujNnfx(g, -5.0, 5.0, 5)
rysujNnfx(g, -5.0, 5.0, 10)
rysujNnfx(g, -5.0, 5.0, 15)