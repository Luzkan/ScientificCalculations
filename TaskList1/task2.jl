# Marcel Jerzyk [06.10.2019 - 14:47]
# Task 2.

# Khan theory:
# It's true to get macheps by calculating
#           3 * ((4/3) - 1) - 1

function khanMacheps(Type)
    eps = Type(3.0) * ((Type(4.0))/Type(3.0) - Type(1.0)) - Type(1.0)
    return eps
end

# Printing out to check thesis
println("Build-in vs. Khan:")
println("Float16: Macheps [", eps(Float16), "]\t\t\tKhan: [", khanMacheps(Float16), "]")
println("Float32: Macheps [", eps(Float32), "]\t\t\tKhan: [", khanMacheps(Float32), "]")
println("Float64: Macheps [", eps(Float64), "]\tKhan: [", khanMacheps(Float64), "]")
# Busted for Float16 and Float64 (sgn is not correct)



# Trying to figure out why that happend
function testKhanForSomeKnowledge(Type)
    t1 = Type(4.0)/Type(3.0)
    t2 = ((Type(4.0))/Type(3.0) - Type(1.0))
    t3 = Type(3.0) * ((Type(4.0))/Type(3.0) - Type(1.0))
    t4 = Type(3.0) * ((Type(4.0))/Type(3.0) - Type(1.0)) - Type(1.0)
    println(Type, ": t1 [", t1, "]\tt2: [", t2, "]", "\tt3: [", t3, "]", "\tt4: [", t4, "]")
end

println("\nStep by step calculations and the answer: ")
testKhanForSomeKnowledge(Float16)
testKhanForSomeKnowledge(Float32)
testKhanForSomeKnowledge(Float64)