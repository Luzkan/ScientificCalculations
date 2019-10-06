# Marcel Jerzyk [06.10.2019 | 17:54-18:03]
# Task 4.

# Define x as the lowest number that is not 1.0
x = nextfloat(Float64(1.0))

# Define upper bound as the higher number that is not 2.0
while x < prevfloat(Float64(2.0))
    if x * (1/x) != 1
        println(x)
        println("$(x * (1/x))")
        break
    end
    global x = nextfloat(x)
end
# X is the number that satisfies both conditions in the Task