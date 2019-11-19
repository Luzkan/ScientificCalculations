# Marcel Jerzyk [13.11.2019 | 16:04-16:42]
# Task 2.

function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v = f(x0)       # value of starting approximation (of f(x) = 0)
    it = 0          # iteration counter
    
    # Value of the function is already close to zero
    if abs(v) < epsilon
        err = 2
        return (x0, v, it, 2)
    end

    for it = 1:maxit
        x1 = x0 - (v / pf(x0))      # approximation of the solution
        v = f(x1)                   # and it's value

        # Set Accuracies Quit Condition
        if (abs(x1 - x0) < delta || abs(v) < epsilon)
            return (x1, v, it, 0)
        end

        # Next iteration x_(k+1) = x_(k)
        x0 = x1
    end
    return (x0, v, maxit, 1)
end