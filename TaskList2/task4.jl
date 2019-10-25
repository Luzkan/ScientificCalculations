# Marcel Jerzyk [24.10.2019 | 14:24 - 16:05]
# Task 4.
# a)

using Polynomials

p=[1.0, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

# Reversed P to start it from the lowest degree
pReversed = reverse(p)

# Constructs a polynomial from its roots.
# The constructed polynomial is (x−r1)(x−r2)⋯(x−rn).
ppoly20to1 = poly([20.0, 19.0, 18.0, 17.0, 16.0, 15.0, 14.0, 13.0, 12.0,
             11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0])

# Poly
# Construct a polynomial from its coefficients a, lowest order first.
#                        If         p = anx^n + ⋯ + a2 x^2 + a1x + a0
# we construct this through         Poly([a0, a1, a2, ⋯ , an])
f = Poly(pReversed)
z = roots(f)

# Quick Explanation why this below is wrong is to just uncomment it and run the file
# f2 = Poly(p)
# z2 = roots(f2)
# println("Polynomials:\nf1: $f \nf2: $f2\n")
# println("Roots:\nz1: $z \nz2: $z2\n")


# polyval
# Evaluate the polynomial p at x using Horner's method.
# println(polyval(f, z[3]))

# -------------------------------------------------------

for k = 1:20
    printstyled("k:$k\tRoot: $(z[k])\n"; color = :green)
    
    println("|P(z)|: $(abs(polyval(f, z[k])))")
    
    println("|p(z)|: $(abs(polyval(ppoly20to1, z[k])))")
    
    println("|z-k|: $(abs(z[k] - k))")

    # LaTeX Println
    # println("$k & $(z[k]) & $(abs(polyval(f, z[k]))) & $(abs(polyval(ppoly20to1, z[k]))) & $(abs(z[k] - k)) \\\\ \\hline")

	print("\n")
end

# -------------------------------------------------------
# b)

# Because p is reversed, -210 stands on second place counting from last (21-1 = 20)
pReversed[20] = Float64(-210.0 - (1/2)^(23))

# Copy-Paste
f = Poly(pReversed)
z = roots(f)

for k = 1:20
    printstyled("k:$k\tRoot: $(z[k])\n"; color = :green)
    
    println("|P(z)|: $(abs(polyval(f, z[k])))")
    
    println("|p(z)|: $(abs(polyval(ppoly20to1, z[k])))")
    
    println("|z-k|: $(abs(z[k] - k))")

    # LaTeX Println
    # println("$k & $(z[k]) & $(abs(polyval(f, z[k]))) & $(abs(polyval(ppoly20to1, z[k]))) & $(abs(z[k] - k)) \\\\ \\hline")

	print("\n")
end