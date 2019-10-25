# Marcel Jerzyk [24.10.2019 | 16:33 - 16:42]
# Task 6.

function recur(c, x)
    c = Float64(c)
    x = Float64(x)

    printstyled("C: $c  X: $x\n"; color = :yellow)
    for n = 1:40
        x = Float64(x^(Float64(2.0)) + c)
        printstyled("($n,$x)"; color = :magenta)
        # println("$x")
    end
    println("-----\n")
end

recur(-2, 1)
recur(-2, 2)
recur(-2, 1.99999999999999)
recur(-1, 1)
recur(-1, -1)
recur(-1, 0.75)
recur(-1, 0.25)