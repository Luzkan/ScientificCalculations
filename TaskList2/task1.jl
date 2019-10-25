# Marcel Jerzyk [22.10.2019 | 15:40-15:42 ]
# Task 1.

# Copy-Paste of Task5. from TaskList1 with change in
#      x4 is now = 0.577215664      (from 0.5772156649)
#      x5 is now = 0.301029995      (from 0.3010299957)
# So now, all the values are up to 9 digits after unity digit

# Declaring task values
x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
n = 5

function sumForward(Type)
    sum = Type(0.0)
    for i = 1 : n
        sum += Type(Type(x[i]) * Type(y[i]))
    end
    println("[FRWR Sum] $Type: $sum")
end

function sumBackward(Type)
    sum = Type(0.0)
    for i = n:-1:1
        sum += Type(Type(x[i]) * Type(y[i]))
    end
    println("[BKWR Sum] $Type: $sum")
end

function sumDescending(Type)
    sum = Type(0.0)
    sumPlus = Type(0.0)
    sumMinus = Type(0.0)
    vectors = Type[]

    # Creating new vector array and sorting it
    for i = 1 : n
        push!(vectors, (x[i] * y[i]))
    end
    sort!(vectors, rev=true) 

    # Adding them from the biggest to the smallest for positive
    #             and from smallest to the biggest for negative
    for i = 1 : n
        if vectors[i] > 0
            sumPlus += vectors[i]
        end
        if i == n
            for k = 0 : (n-1)
                if vectors[(i-k)] <= 0
                    sumMinus += vectors[i-k]
                end
            end
        end
    end
    sum = sumPlus + sumMinus

    println("[DESC Sum] $Type: $sum\t\t= ($sumPlus + $sumMinus)")
end   

function sumAscending(Type)
    sum = Type(0.0)
    sumPlus = Type(0.0)
    sumMinus = Type(0.0)
    vectors = Type[]

    # Creating new vector array and sorting it
    for i = 1 : n
        push!(vectors, (x[i] * y[i]))
    end
    sort!(vectors, rev=false)

    # Adding them from the smallest to the biggest for positive
    #             and from biggest to the smallest for negative
    for i = 1 : n
        if vectors[i] > 0
            sumPlus += vectors[i]
        end
        if i == n
            for k = 0 : (n-1)
                if vectors[(i-k)] <= 0
                    sumMinus += vectors[i-k]
                end
            end
        end
    end
    sum = sumPlus + sumMinus

    println("[ASCN Sum] $Type: $sum\t\t= ($sumPlus + $sumMinus)")
end   


sumForward(Float32)
sumBackward(Float32)
sumDescending(Float32)
sumAscending(Float32)
println("")
sumForward(Float64)
sumBackward(Float64)
sumDescending(Float64)
sumAscending(Float64)
