# Marcel Jerzyk [24.11.2019 | 17:35-18:35]
# Task 1.

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})

    fx = copy(f)
    n = length(x)

    for k = 2 : n
        for i = n : -1 : k
            # Differential Quotient at x2:
            #     = (f(x2) - f(x1)) / (x2 - x1)
			fx[i] = (fx[i] - fx[i - 1]) / (x[i] - x[i - k + 1])
		end
    end
    
    return fx
end