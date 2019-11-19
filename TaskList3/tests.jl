# Marcel Jerzyk [13.11.2019 | 17:32-18:10]
# Tasks 1-3 Tests.

include("methods.jl")

# f(x) root = 2
f(x) = x^3 - 8
df(x) = 3*(x^2)
fa = 1.0
fb = 3.5

# g(x) root = 1
g(x) = x^2 - 1
dg(x) = 2*x
ga = -1.0
gb = 2.0

# h(x) root = -3
h(x) = x^2 + 6x + 9
dh(x) = 2x + 6
ha = -5.0
hb = 0.0

# accuracy
epsilon = 10.0^(-6.0) 
delta = 10.0^(-6.0)
maxit = 10^(2)

# f(x)
printstyled("\nf(x) = x^3 - 8\n"; color = :green)
printstyled("Method & Root & Value & Iterations & Error\n"; color = :magenta)
(r, v, it, err) = methods.mbisekcji(f, fa, fb, delta, epsilon)
println("Bisection & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.mstycznych(f, df, fa, delta, epsilon, maxit)
println("Newton & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.msiecznych(f, fa, fb, delta, epsilon, maxit)
println("Secant & $(r) & $(v) & $(it) & $(err)")

# g(x)
printstyled("\ng(x) = x^2 - 1\n"; color = :green)
printstyled("Method & Root & Value & Iterations & Error\n"; color = :magenta)
(r, v, it, err) = methods.mbisekcji(g, ga, gb, delta, epsilon)
println("Bisection & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.mstycznych(g, dg, ga, delta, epsilon, maxit)
println("Newton & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.msiecznych(g, ga, gb, delta, epsilon, maxit)
println("Secant & $(r) & $(v) & $(it) & $(err)")

# h(x)
printstyled("\ng(x) = x^2 - 1\n"; color = :green)
printstyled("Method & Root & Value & Iterations & Error\n"; color = :magenta)
(r, v, it, err) = methods.mbisekcji(h, ha, hb, delta, epsilon)
println("Bisection & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.mstycznych(h, dh, ha, delta, epsilon, maxit)
println("Newton & $(r) & $(v) & $(it) & $(err)")

(r, v, it, err) = methods.msiecznych(h, ha, hb, delta, epsilon, maxit)
println("Secant & $(r) & $(v) & $(it) & $(err)")