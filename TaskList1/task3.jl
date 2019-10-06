# Marcel Jerzyk [06.10.2019 | 16:33-17:20]
# Task 3.

# Delta
d = Float64(2.0)^(-52)

# Step testing function
function testRange(x, y, d)
    println("\nRange: [$x - $y]")

    # Testing for first 5 and last 5 numbers in k range
    for k in [1, 2, 3, 4, 5, 2^52-4, 2^52-3, 2^52-2, 2^52-1, 2^52]
        answ = (x + k * d)
        println("$answ = $x + $k*d |-| Last five bin numbers: [$(bitstring(answ)[end-4:end])]")
        if k == 5 
            println("...")
        end
    end
end

# Testing ranges from the Task
testRange(Float64(1.0), Float64(2.0), d)
testRange(Float64(0.5), Float64(1.0), Float64(2.0)^(-53))
testRange(Float64(2.0), Float64(4.0), Float64(2.0)^(-51))

# As it turned out, delta had to be changed in order to keep counting evenly
# 2.0^(-53) for 0.5 ... 1.0, divided by two compared to original range
# 2.0^(-51) for 2.0 ... 4.0, doubled by two compared to original range