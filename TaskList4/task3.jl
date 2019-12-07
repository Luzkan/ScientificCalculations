# Marcel Jerzyk [29.11.2019 | 20:43-]
# Task 3.

function naturalna(x::Vector{Float64}, fx::Vector{Float64})

    n = length(fx)
    coefficient = Vector{Float64}(n)
    coefficient = fx[n] 

    for i = n - 1 : -1: 1
        
        temp = coefficient[i + 1] * x[i]
        coefficient[i] = fx[i] - temp

        for k in range(i + 1, n - 1)

            temp = coefficient[k + 1] * x[i]
            coefficient[k] = coefficient[k] - temp

        end
    end

    return coefficient
end