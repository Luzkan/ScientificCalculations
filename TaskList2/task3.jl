# Marcel Jerzyk [24.10.2019 | 13:10 - 14:23]
#                                   ^ Used wrong slash >:"(
# Task 3.
include("task3hilb.jl")
include("task3matcond.jl")
using LinearAlgebra

# (a) Hilbert
for i in 1:20

    # Hilbert Matrix
    A = hilb(i)

    # http://www.jlhub.com/julia/manual/en/function/function/ones
    x = ones(i) 

    # Vector b
    b = A * x

    printstyled("\n[Hilbert] Size: ($i x $i)\tCond: $(cond(A))\tRank: $(rank(A))\n"; color = :yellow)
    # Gaussian Elimantion (Divide Arrays [A / b])
    printstyled("[GE]\tRelative Error: $(norm(A\b - x) / norm(x))\n"; color = :green)
    println("$(A\b)")

    # Reverse Matrix A (Inverse and Multiplication [A^-1 * b])
    printstyled("[RM]\tRelative Error: $(norm(inv(A) * b - x) / norm(x))\n"; color = :magenta)
    println("$(inv(A) * b)")

    # Print for LaTeX
    # println("$i & $(norm(A\b - x) / norm(x)) & $(norm(inv(A) * b - x) / norm(x)) & $(cond(A)) \\\\ \\hline")
end

# ------------------------------------------------------------------------------------------------------

# (b) Matcond
n = [5, 10, 20]
c = [1.0, 10.0, 10^3, 10^7, 10^12, 10^16]

for i = n
    for j = c

        # Matcond Matrix (n degree, c ind cond)
        A = matcond(i,j)
        x = ones(i)
        b = A * x

        # printstyled("\n[Mathcond]\tSize: ($i x $j)\tCond: $(cond(A))\tRank: $(rank(A))\n"; color = :yellow)
        # # Gaussian Elimantion (Divide Arrays [A / b])
        # printstyled("[GE]\tRelative Error: $(norm(A\b - x) / norm(x))\n"; color = :green)
        # println("$(A\b)")
    
        # # Reverse Matrix A (Inverse and Multiplication [A^-1 * b])
        # printstyled("[RM]\tRelative Error: $(norm(inv(A) * b - x) / norm(x))\n"; color = :magenta)
        # println("$(inv(A) * b)")

        # Print for LaTeX
        println("$i & $(norm(A\b - x) / norm(x)) & $(norm(inv(A) * b - x) / norm(x)) & $(cond(A)) \\\\ \\hline")
    end
end