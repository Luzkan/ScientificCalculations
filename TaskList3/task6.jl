# Marcel Jerzyk [13.11.2019 | 14:57-17:17]
# Task 6.

include("methods.jl")

# f(x), zero place = 1
f(x) = Base.MathConstants.e^(1.0 - x) - 1.0
df(x) = -Base.MathConstants.e^(-x + 1)

# g(x), zero place = 0
g(x) = x * Base.MathConstants.e^(-x)
dg(x) = -(Base.MathConstants.e^(-x) * x) * Base.MathConstants.e^(-x) 

delta = 10^(-5.0)
epsilon = 10^(-5.0)
maxit = 10^2

# Range and Initial Approximations
rangeBottom = [0.0, 0.0, 1.0, -0.1, -3.41, -0.03, 1.0, 1.98]
rangeUpper = [2.0, 1.0, 9.0, 1.7, 4.253, 941.5, 9.0^(300), 2.0]
newtonApprox = [0.999, 1.001, 0.0, 1.0, 0.5, -2.0, 123.0, 9.0^(300)]


# f(x), zero place = 1
printstyled("\nf(x) = e^(1-x) - 1"; color = :green)
printstyled("\nMethod & Range & Root & Iterations & Error\n"; color = :magenta)
for n in eachindex(rangeBottom)
    a = rangeBottom[n]
    b = rangeUpper[n]

    printstyled("Bisection [$a, $b]"; color = :yellow)
    (r, v, it, err) = methods.mbisekcji(f, a, b, delta, epsilon)
    println(" & $(r) & $(v) & $(it) & $(err)")
end

printstyled("\nMethod & Approximation & Root & Iterations & Error & [maxit = $maxit]\n"; color = :magenta)
for n in eachindex(newtonApprox)
    x0 = newtonApprox[n]

    printstyled("Newton [$x0]"; color = :yellow)
    (r, v, it, err) = methods.mstycznych(f, df, x0, delta, epsilon, maxit)
    println(" & $(r) & $(v) & $(it) & $(err)")
end

printstyled("\nMethod & Range & Root & Iterations & Error & [maxit = $maxit]\n"; color = :magenta)
for n in eachindex(rangeBottom)
    x0 = rangeBottom[n]
    x1 = rangeUpper[n]

    printstyled("Secant [$x0, $x1]"; color = :yellow)
    (r, v, it, err) = methods.msiecznych(f, x0, x1, delta, epsilon, maxit)
    println(" & $(r) & $(v) & $(it) & $(err)")
end

# g(x), zero place = 0
printstyled("\ng(x) = xe^(-x)"; color = :green)
printstyled("\nMethod & Range & Root & Iterations & Error\n"; color = :magenta)
for n in eachindex(rangeBottom)
    a = rangeBottom[n]
    b = rangeUpper[n]

    printstyled("Bisection [$a, $b]"; color = :yellow)
    (r, v, it, err) = methods.mbisekcji(g, a, b, delta, epsilon)
    println(" & $(r) & $(v) & $(it) & $(err)")
end

printstyled("\nMethod & Range & Root & Iterations & Error & [maxit = $maxit]\n"; color = :magenta)
for n in eachindex(newtonApprox)
    x0 = newtonApprox[n]

    printstyled("Newton [$x0]"; color = :yellow)
    (r, v, it, err) = methods.mstycznych(g, dg, x0, delta, epsilon, maxit)
    println(" & $(r) & $(v) & $(it) & $(err)")
end

printstyled("\nMethod & Range & Root & Iterations & Error & [maxit = $maxit]\n"; color = :magenta)
for n in eachindex(rangeBottom)
    x0 = rangeBottom[n]
    x1 = rangeUpper[n]

    printstyled("Secant [$x0, $x1]"; color = :yellow)
    (r, v, it, err) = methods.msiecznych(g, x0, x1, delta, epsilon, maxit)
    println(" & $(r) & $(v) & $(it) & $(err)")
end
