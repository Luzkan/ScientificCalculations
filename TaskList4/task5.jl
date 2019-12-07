# Marcel Jerzyk [03.12.2019 | 23:52-23:56]
# Task 5.

include("task4.jl")

f(x) = (Base.MathConstants.e)^x
rysujNnfx(f, 0.0, 1.0, 5)
rysujNnfx(f, 0.0, 1.0, 10)
rysujNnfx(f, 0.0, 1.0, 15)

g(x) = (x^2)*sin(x)
rysujNnfx(g, -1.0, 1.0, 5)
rysujNnfx(g, -1.0, 1.0, 10)
rysujNnfx(g, -1.0, 1.0, 15)