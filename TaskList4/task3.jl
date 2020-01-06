# Marcel Jerzyk [29.11.2019 | 20:43-]
# 17.12.2019 Fix, was unfinished
# Task 3.

function naturalna(x::Vector{Float64}, fx::Vector{Float64})

    n = length(fx)] 
    coefficient = zeros(n)
    coefficient[n] = fx[n]

    for i = n - 1 : -1: 1

        temp = coefficient[i + 1] * x[i]
        coefficient[i] = fx[i] - temp

        for k = i + 1 : n - 1

            temp = coefficient[k + 1] * x[i]
            coefficient[k] = coefficient[k] - temp

        end
    end

    return coefficient
end
