# Marcel Jerzyk [24.10.2019 | 16:07 - 16:30]
# Task 5.

# Recursive function (logistic model, population growth model)
function recur(T, cut)

    # Population
    p = T(0.01)

    # Constant
    r = T(3)
    
    for i = 1 : 40
        p += r * p * (T(1.0)-p)

        # Cut to three digits
        # Round will not suit the need, so I use floor instead
        if(cut == true && i == 10)
            p = floor(p,  digits=3)
        end

        println("$i & $p")
    end
end

# recur(Float32, true)
# recur(Float32, false)
recur(Float64, false)