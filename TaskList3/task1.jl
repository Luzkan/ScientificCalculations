# Marcel Jerzyk [12.11.2019-13.11.2019 | 19:28 - 16:04]
# Task 1.

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    r = 0.0           # interval midpoint, approximated zero of f(x) = 0
    v = 0.0           # and it's value
    it = 0            # iteration counter
    fa = f(a)         
    fb = f(b)         
    e = b - a         # error estimation

    # Function doesn't change sign in interval [a, b]
    if sign(fa) == sign(fb)
        return (r, v, it, 1)
    end

    # Until we find eps accuracy
    while e > epsilon
        it += 1         # iteration counter
        e /= 2.0        # error estimation
        r = a+e         # interval midpoint
        v = f(r)        # and it's value

        # Set Accuracies Quit Condition
        if (abs(e) < delta || abs(v) < epsilon)
            return (r, v, it, 0)
        end

        # Choose new interval (the one with different signs - there are is our ~f(x) = 0)
        if sign(v) != sign(fa)      # Midpoint becomes new interval end
            b = r                   
            fb = v      
        else                        # Else it becomes new interval beginning
            a = r       
            fa = v
        end
    end
    return (r, v, it, 0)
end
