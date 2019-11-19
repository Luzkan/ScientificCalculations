# Marcel Jerzyk [13.11.2019 | 17:50-18:12]
# Task 4.

include("methods.jl")

f(x) = sin(x) - (x/2)^2
df(x) = cos(x) - (x/2)
delta = 0.5 * 10^(-5.0)
epsilon = 0.5 * 10^(-5.0)
maxit = 10^(2)

printstyled("\nf(x) = sin(x) - (x/2)^2\n"; color = :green)
printstyled("Method & Root & Value & Iterations & Error\n"; color = :magenta)
(r, v, it, err) = methods.mbisekcji(f, 1.5, 2.0, delta, epsilon)
println("Bisection & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.mstycznych(f, df, 1.5, delta, epsilon, maxit)
println("Newton & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.msiecznych(f, 1.0, 2.0, delta, epsilon, maxit)
println("Secant & $(r) & $(v) & $(it) & $(err)")