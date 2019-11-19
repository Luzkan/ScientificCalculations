# Marcel Jerzyk [13.11.2019 | 16:42-17:32]
# Task 3.

function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fx0 = f(x0)     # value of starting approximation (of f(x) = 0)
    fx1 = f(x1)     # same for next x
    it = 0          # iteration counter
    
    for it = 1:maxit

        # Swap if previous value is greater than next one
        if (abs(fx0) > abs(fx1))
            x0, x1, = x1, x0
            fx0, fx1 = fx1, fx0
        end

        s = (x1 - x0)/(fx1 - fx0)   # calculate the differential quotient
        x1 = x0
        fx1 = fx0
        x0 = x0 - (fx0 * s)         # approximation of the solution
        fx0 = f(x0)                 # and it's value

        # Set Accuracies Quit Condition
        if (abs(x1 - x0) < delta || abs(fx0) < epsilon)
            return (x0, fx0, it, 0)
        end
    end

    # Error occurs if no result found in maxit
    return (x0, fx0, maxit, 1)
end