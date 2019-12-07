# Marcel Jerzyk [24.11.2019-29.11.2019 | 18:38-20:42]
# Task 2.

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)

    f = copy(fx)
    n = length(x)
    nt = f[n] 

	for i = n - 1 : -1 : 1
		nt = f[i] + (t - x[i]) * nt
    end
    
    return nt
end