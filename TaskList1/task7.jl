# Marcel Jerzyk [06.10.2019 | 21:25-21:52]
# Task 7.

# Calculating derivative:
#
# f(x) = sin(x) + cos(3*x)
# 
# (sin(x))' = cos(x)
#
# (cos(3x))' 
#       (cos(u))' = -sin(u)
#       (3x)'     = 3
#       _____________________
#                 = -3sin(3x)

x0 = Float64(1.0)
f(x0) = sin(x0) + cos(3*x0)
g(x0) = cos(x0) - 3*sin(3*x0)

for i = Float64(0) : Float64(54.0) 
    h = Float64(2.0)^(-i)
    point = ((f(x0 + h) - f(x0)) / h)
    error = abs(g(x0) - point)
    println("[h^(-$i)]\tpoint = $point\terr = $error")
end