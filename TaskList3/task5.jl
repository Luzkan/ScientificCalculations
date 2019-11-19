# Marcel Jerzyk [15.11.2019 | 12:51-13:38]
# Task 5.

include("methods.jl")

f(x) = (3.0 * x) - Base.MathConstants.e^x
g(x) = Base.MathConstants.e^x - (3.0 * x)
delta = 10^(-4.0)
epsilon = 10^(-4.0)

printstyled("\nRange  \t   & Root & Iterations & Error\n"; color = :magenta)

# f(x) version
printstyled("f(x) = 3x - e^x\n"; color = :green)
printstyled("[0.0, 1.0]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(f, 0.0, 1.0, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

printstyled("[0.5, 1.0]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(f, 0.5, 1.0, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

printstyled("[1.0, 2.0]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(f, 1.0, 2.0, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

printstyled("[1.4, 1.6]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(f, 1.4, 1.6, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

# g(x) version
printstyled("g(x) = e^x - 3x\n"; color = :green)
printstyled("[0.0, 1.0]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(g, 0.0, 1.0, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

printstyled("[0.5, 1.0]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(g, 0.5, 1.0, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

printstyled("[1.0, 2.0]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(g, 1.0, 2.0, delta, epsilon)
println(" & $(r) & $(it) & $(err)")

printstyled("[1.4, 1.6]"; color = :yellow)
(r, v, it, err) = methods.mbisekcji(g, 1.4, 1.6, delta, epsilon)
println(" & $(r) & $(it) & $(err)")
