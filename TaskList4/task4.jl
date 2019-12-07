# Marcel Jerzyk [29.11.2019-03.12.2019 | 20:55-20:52]
# Task 4.

include("methods.jl")
using Plots

function rysujNnfx(f,a::Float64,b::Float64,n::Int)
    
	h = (b - a)/n                   # Space between nodes
	x = zeros(n + 1)                # Two arrays to store
	y = zeros(n + 1)                # Nodes and their Values

    # Filling those arrays with nodes and values
	for i = 0 : n
		x[i + 1] = a + i * h
		y[i + 1] = f(x[i + 1])
	end

    # Now we can calculate differential quotients
	fx = methods.ilorazyRoznicowe(x, y)

	# Preparing graphs
	graphPoints = 10^3
    acc = (b - a) / graphPoints
    fxVal = zeros(graphPoints + 1)
    ip = zeros(graphPoints + 1)

    for i = 0 : (graphPoints)
        t = a + (i) * acc
        fxVal[i + 1] = f(t)
        ip[i + 1] = methods.warNewton(x, fx, t)
	end
	
	# Drawing graphs
    graph = plot(range(a, stop=b, length=(graphPoints + 1)), fxVal, color = :blue, label = "Function")
    graph = plot!(range(a, stop=b, length=(graphPoints + 1)), ip, color = :red, label = "Interpolation")
	savefig(graph, "TaskList4/graphs/task6$f($n).png")
end
