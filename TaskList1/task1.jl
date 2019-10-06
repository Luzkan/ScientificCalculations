# Marcel Jerzyk [05.10.2019 - 17:47]
# Task 1.

# Testing what macheps, nextfloat and what what maximum is going to be returned from Float16, 32 & 64
println("Build-in Values:")
println("Float16: Macheps [", eps(Float16), "]\t\t\tNextFloat: [", nextfloat(Float16(0.0)), "]\t\tRealMax: [", floatmax(Float16), "]")
println("Float32: Macheps [", eps(Float32), "]\t\t\tNextFloat: [", nextfloat(Float32(0.0)), "]\t\tRealMax: [", floatmax(Float32), "]")
println("Float64: Macheps [", eps(Float64), "]\tNextFloat: [", nextfloat(Float64(0.0)), "]\t\tRealMax: [", floatmax(Float64), "]")

# Preparing eps, eta & max to be manually calculated
f16eps = Float16(1.0)
f32eps = Float32(1.0)
f64eps = Float64(1.0)

f16eta = Float16(1.0)
f32eta = Float32(1.0)
f64eta = Float64(1.0)

f16max = Float16(1.0)
f32max = Float32(1.0)
f64max = Float64(1.0)

# EPS Calculations
# Take half if: "/next half/ + 1" is grater than: "1"
# If while ends, it means that we reached macheps for this type, in "human" words:
# 1 + /something so tiny it looks like 0 in this type/ IS NOT greater than 1, so loop ends.
while (1 + (f16eps / 2)) > 1
    global f16eps /= 2
end

while (1 + (f32eps / 2)) > 1
    global f32eps /= 2
end

while (1 + (f64eps / 2)) > 1
    global f64eps /= 2
end

# ETA Calculations 
# Take half if: "/next half/" is greater than: "0"
# If while ends, it means that we reached eta for this type; in "human" words:
# /something so tiny it looks like 0 in this type/ IS NOT greater than 0, so loop ends.
while (f16eta / 2) > 0
    global f16eta /= 2
end

while (f32eta / 2) > 0
    global f32eta /= 2
end

while (f64eta / 2) > 0
    global f64eta /= 2
end

# MAX Calculations 
# Double the number if: "/next duplication/" will not be "inf"
# If while ends, it means that we reached half max for this type.
# To reach the max we need to subtract as little as its possible from "2" before next doubling to get as close as possible
# As little as its possible is previously calculated EPS
while (f16max*2) != typemax(Float16)
    global f16max *= 2
end
f16max *= (2-f16eps)

while (f32max*2) != typemax(Float32)
    global f32max *= 2
end
f32max *= (2-f32eps)

while (f64max*2) != typemax(Float64)
    global f64max *= 2
end
f64max *= (2-f64eps)

# Printing found numbers
println("\nResults:")
println("Float16: Macheps [", f16eps, "]\t\t\tNextFloat: [", f16eta, "]\t\tRealMax: [", f16max, "]")
println("Float32: Macheps [", f32eps, "]\t\t\tNextFloat: [", f32eta, "]\t\tRealMax: [", f32max, "]")
println("Float64: Macheps [", f64eps, "]\tNextFloat: [", f64eta, "]\t\tRealMax: [", f64max, "]")