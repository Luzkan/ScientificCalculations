# Marcel Jerzyk [06.10.2019 | 18:17-20:24]
# Task 5.

# Declaring task values
x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
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

    println("[DESC Sum] $Type: $sum\t\t= ($sumPlus + $sumMinus)")
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








# Wrong Code 
# Sorted both arrays accordingly to desc/ascn and then
# Used formula from a)
function oldSumDescending(Type)
    sum = Type(0.0)
    sumPlus = Type(0.0)
    sumMinus = Type(0.0)
    newX = sort(x, rev=true)
    newY = sort(y, rev=true)

    for i = 1 : n
        if newX[i] <= 0 && newY[i] <= 0
            # print("\t[Debug]\t[DESC sumMinus] $sumMinus += $(newX[i]) * $(newY[i]) is equal to: ")
            sumMinus += Type(Type(newX[i]) * Type(newY[i]))
            # println("$sumMinus") 
            continue
        elseif newX[i] > 0 && newX[i] > 0
            # print("\t[Debug]\t[DESC sumPlus] $sumPlus += $(newX[i]) * $(newY[i]) is equal to: ")
            sumPlus += Type(Type(newX[i]) * Type(newY[i]))
            # println("$sumPlus") 
            continue
        else
            println("[Err] Arrays Missmatch")
        end           
    end
    sum += sumPlus + sumMinus

    println("[DESC Sum] $Type: $sum\t\t= ($sumPlus + $sumMinus)")
end   

function oldSumAscending(Type)
    sum = Type(0.0)
    sumPlus = Type(0.0)
    sumMinus = Type(0.0)
    newX = sort(x)
    newY = sort(y)

    for i = 1 : n
        if newX[i] <= 0 && newY[i] <= 0
            # print("\t[Debug]\t[ASCN sumMinus] $sumMinus += $(newX[i]) * $(newY[i]) is equal to: ")
            sumMinus += Type(Type(newX[i]) * Type(newY[i]))       
            # println("$sumMinus")     
            continue
        elseif newX[i] > 0 && newX[i] > 0
            # print("\t[Debug]\t[ASCN sumPlus] $sumPlus += $(newX[i]) * $(newY[i]) is equal to: ")
            sumPlus += Type(Type(newX[i]) * Type(newY[i]))
            # println("$sumPlus")
            continue
        else
            println("[Err] Arrays Missmatch")
        end           
    end
    sum += sumPlus + sumMinus

    println("[ASCN Sum] $Type: $sum\t\t= ($sumPlus + $sumMinus)")
end   