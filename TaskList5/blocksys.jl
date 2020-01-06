# Marcel Jerzyk [02.01.2020-06.01.2020 | 16:09-16:02]

include("./matrixgen.jl")
using SparseArrays

##### -------------- FILE OPERATIONS --------------

function relativePath(path :: String)
    file = string(@__DIR__, "/", path)      # Relative Path (points current directory)
    return file
end

function openFileMatrix(path :: String, swap :: Bool)
    open(relativePath(path), "r") do f      # Opens file in readmode      
        info = split(readline(f))           
        n = parse(Int64, info[1])           # Size of matrix A
        l = parse(Int64, info[2])           # Size of matrix Ak, Bk, Ck
        A = spzeros(Float64, n, n)          # Declare empty sparse matrix of size n by n
        while !eof(f)
            value = split(readline(f))
            i = parse(Int64, value[1])       # Indexes...
            j = parse(Int64, value[2])
            value = parse(Float64, value[3]) # ...and their values
            if swap; A[j, i] = value else; A[i, j] = value; end
        end
        return A, n, l
    end
end

function openFileRightVector(path :: String)
    open(relativePath(path), "r") do f      # Opens file in readmode   
        info = readline(f)
        n = parse(Int64, info)              # Get the size of vector
        b = zeros(Float64, n)               # Create the vector's representation
        i = 0                               # Store current index of vector
        while !eof(f)
            value = readline(f)             
            b[i+=1] = parse(Float64, value) # Store and Iterate 
        end
        return b
    end
end

# LinearAlgebra for norm()
using LinearAlgebra
function saveMatrix(path :: String, x :: Array{Float64}, n :: Int64, err :: Bool)
    open(relativePath(path), "w") do f
        println(f, "Size: $n")
        if err; println(f, "Relative Error: $(norm(ones(n) - x) / norm(x))") end
        for i in 1 : n
            println(f, x[i])
        end
    end
end

function saveRightVector(path :: String, b :: Array{Float64}, n :: Int64)
    open(relativePath(path), "w") do f
        println(f, "$n")
        for i in 1 : n
            println(b[i])
        end
    end
end

##### -------------- Calculations --------------

function calculateRightVector(A :: SparseMatrixCSC{Float64, Int64}, n :: Int64, l :: Int64)
    x = ones(Float64, n)        # Identity matrix       -   (1, ..., 1)^T 
    b = zeros(Float64, n)       # Right-side vector     -   b = Ax
    ba = Int64(n / l)           # Block amount          -   v = MatrixSize/BlockSize
    for k in 1 : ba                             # Iterate on each block
        for i in (k - 1) * l + 1 : k * l
            rightVector = 0                     # Value for each row of right-side vector
            for j in 1 : k * l                  # Block * BlockSize
                rightVector += A[i, j] * x[j]
            end
            if k != ba;                         # Check if not last block
                rightVector += A[i, i + l] * x[i + l]
            end
            b[i] = rightVector                  # Assign the value
        end
    end
    return b
end

function gaussEliminationMethod(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, myLU :: Bool)
    for i in 1 : n - 1
        lastColumn = min(i + l, n)                          # Calculations on these two last index
        lastRow = min(n, l + l * div((i+1), l))             # should be performed for sparse matrix

        for k in i + 1 : lastRow
            if isapprox(eps(Float64), abs(A[i, i]))
                error("Zero at the diagonal. Aborting.")
            end

            z = A[i, k] / A[i, i]

            # If LU -> Store the L matrix inside of A -> else zero out values under diagonal
            if myLU; A[i, k] = z; else A[i, k] = 0; end

            for c in i + 1 : lastColumn
                A[c, k] -= z * A[c, i]
            end

            # Transform the right-side vector
            if !myLU; b[k] -= z * b[i]; end
        end
    end
    return A
end

function gaussEliminationMethodPivoted(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, myLU :: Bool)
    perm = collect(1 : n)                          # Declares the permutation vector storing the position of block in matrix (used instead of performing swaps)
    for pivot in 1 : n - 1
        if !myLU; lastRow = min(2*l + l*div(pivot+1, l), n); else; lastRow = min(2*l + l*div(pivot+1, l), n); end
        lastColumn = min(l + l*div(pivot+1, l), n)

        for k in pivot + 1 : lastColumn
            
            maxIndex = pivot                       # Find the max value in the column
            maxVal = abs(A[pivot, perm[pivot]])

            for i in k : lastColumn
                absVal = abs(A[pivot, perm[i]])

                if absVal > maxVal
                    maxIndex = i
                    maxVal = absVal               # Save the new maximum
                end
            end

            if isapprox(maxVal, eps(Float64))
                error("Zero in the column. Aborting.")
            end

            # Perform the swap of chosen "main element"
            perm[pivot], perm[maxIndex] = perm[maxIndex], perm[pivot]

            # Compute the value of elimination multiplier
            z = A[pivot, perm[k]] / A[pivot, perm[pivot]]

            # If LU -> store the values of L matrix inside of A, else -> zero out values (gauss elimination) 
            if myLU; A[pivot, perm[k]] = z; else A[pivot, perm[k]] = 0; end

            for c in pivot + 1 : lastRow
                A[c, perm[k]] -= z * A[c, perm[pivot]]          # Perform the reduction
            end

            if !myLU; b[perm[k]] -= z * b[perm[pivot]]; end     # Transform the right-side vector
        end
    end
    if !myLU; return perm; else return perm, A; end             # Return the permutation vector used for solving the equation
end

##### -------------- Final Solving --------------
# Works on Upper Triangular Matrix

function triangularUpper(A :: SparseMatrixCSC{Float64, Int64}, b :: Array{Float64}, n :: Int64, l :: Int64, perm :: Array, pivotLU :: Bool)
    x = zeros(Float64, n)
    for k in n : -1 : 1
        sum = 0
        if perm == [0]                                  # Not Pivoted
            last = min(k + l, n)                        # Last Column      
            for c in k + 1 : last                       # Columns in Last Block (iterating to last column [either the last block or n])
                sum += A[c, k] * x[c]
            end
            x[k] = (b[k] - sum) / A[k, k]
        else                                            # Pivoted
            last = min(2*l + l*div(perm[k] + 1, l), n)  # Last Column
            for c = k + 1 : last                        # Columns in Last Block (iterating to last column [either the last block or n])
                sum += x[c] * A[c, perm[k]]
                # println("sum ($c): $sum | $(x[c]) * $([A[c, perm[k]]])")
            end
            if !pivotLU; x[k] = (b[perm[k]] - sum)/A[k, perm[k]]; else;
                         x[k] = (b[k] - sum) / A[k, perm[k]]; end
            # println("X[$k]: $(x[k]) | $(b[perm[k]]) - $sum | $(A[k, perm[k]])")
        end
    end
    return x
end

function triangularLower(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, perm :: Array)
    x = zeros(Float64, n)
    for k in 1 : n
        sum = 0
        if perm == [0]                              # Not Pivoted
            last = max(1, (div((k - 1), l) * l) - 1)
            for c in last : k - 1
                sum += A[c, k] * x[c]
            end
            x[k] = b[k] - sum
        else                                        # Pivoted
            last = max(l * div(perm[k] - 1, l) - 1, 1)
            for c in last : k - 1
                sum += A[c, perm[k]] * x[c]
            end
            x[k] = b[perm[k]] - sum
        end
    end
    return x
end

##### -------------- Managing Functions --------------

# Working on a Sparse Matrix with GEM
function doGauss(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, s :: Bool)
    gaussEliminationMethod(A, b, n, l, false)
    x = triangularUpper(A, b, n, l, [0], false)
    if s; saveMatrix("results/$(n)/x.txt", x, n, false); end
    return x
end

# Working on a Sparse Matrix with Pivoted GEM
function doGaussPivot(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, s :: Bool)
    perm = gaussEliminationMethodPivoted(A, b, n, l, false)
    x = triangularUpper(A, b, n, l, perm, false)
    if s; saveMatrix("results/$(n)/x.txt", x, n, false); end
    return x
end

# Performs the LU decomposition of sparse matrix and computes the solutions
function doLU(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, s :: Bool)
    nA = gaussEliminationMethod(A, b, n, l, true)
    x = finishLU(nA, b, n, l)
    if s; saveMatrix("results/$(n)/x.txt", x, n, false); end
    return x
end

# Performs the pivoted LU decomposition of sparse matrix and computes the solutions
function doLUPivot(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, s :: Bool)
    perm, nA = gaussEliminationMethodPivoted(A, b, n, l, true)
    x = finishLUPivot(nA, b, n, l, perm)
    if s; saveMatrix("results/$(n)/x.txt", x, n, false); end
    return x
end

##### -------------- Helping Functions --------------

# Solves the Ax = b equation using the previously computed LU breakdown (Combined L and U Matrices)
function finishLU(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64)
    nB = triangularLower(A, b, n, l, [0])           # Forward substitution
    x = triangularUpper(A, nB, n, l, [0], false)    # Backward substitution
    return x
end

# Solves the Ax = b equation using the previously computed pivoted LU breakdown (Combined L and U Matrices)
function finishLUPivot(A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, perm :: Array)
    nB = triangularLower(A, b, n, l, perm)         # Forward substitution
    x = triangularUpper(A, nB, n, l, perm, true)   # Backward substitution
    return x
end

##### -------------- Calculate and Save --------------

function getRightVector(size :: String)
    A, n, l = openFileMatrix("tests/$(size)/A.txt", true)   # Retrieve Matrix
    b = calculateRightVector(A, n, l)                       # Calculate b
    saveRightVector("tests/$(size)/b.txt", b, n)
end

# Computes user options
function precalculate(which :: String, pivo :: String, bvec :: String, size :: String)
    gauss = false;
    pivoted = false;
    calcB = false;

    if which == "gauss"; gauss = true; end
    if pivo == "true"; pivoted = true; end
    if bvec == "true"; calcB = true; end
    
    A, n, l = openFileMatrix("tests/$(size)/A.txt", true)   # Retrieve Matrix
    b = openFileRightVector("tests/$(size)/b.txt")          # Retrieve b

    calculate("results/$(size)/x.txt", gauss, calcB, A, b, n, l, pivoted, false)
end

# Calculates with given options and saves to file
function calculate(path :: String, gauss :: Bool, calcB :: Bool, A :: SparseMatrixCSC{Float64, Int64}, b :: Vector{Float64}, n :: Int64, l :: Int64, pivoted :: Bool, save_error :: Bool)
    if calcB; b = calculateRightVector(A, n, l); end        # Calculate RightVector if wanted
    if gauss                                                # Gauss 
        if !pivoted; doGauss(A, b, n, l, true)
        else doGaussPivot(A, b, n, l, true)
        end
    else                                                    # LU
        if !pivoted; doLU(A, b, n, l, true)
        else doLUPivot(A, b, n, l, true)
        end
    end
    println("Calculation completed! Saved to: [$path].")
end

testSizes = [16, 1000, 2500, 5000, 7500, 10000, 25000, 50000, 75000, 100000]
function compare(what :: String)
    for size in testSizes
        A, n, l = openFileMatrix("tests/$(size)/A.txt", true)   # Matrix GEM
        b = openFileRightVector("tests/$(size)/b.txt")
        Ap, bp = deepcopy(A), deepcopy(b)                       # Matrix GEM Pivoted
        Al, bl = deepcopy(A), deepcopy(b)                       # Matrix LU
        Alu, blu = deepcopy(A), deepcopy(b)                     # Matrix LU Pivoted
        # Anoopt, bnoopt = Array(A), deepcopy(b)                # Matrix no optimization
        # Ajulia, bjulia = deepcopy(A), deepcopy(b)             # Matrix optimized by Julia

        if what == "all" || what == "gauss"; gem = @timed doGauss(A, b, n, l, false); end
        if what == "all" || what == "gauss"; gemPivoted = @timed doGaussPivot(Ap, bp, n, l, false); end
        if what == "all" || what == "lu"; lu = @timed doLU(Al, bl, n, l, false); end
        if what == "all" || what == "lu"; luPivoted = @timed doLUPivot(Alu, blu, n, l, false); end
        # if what == "all" || what == "gauss"; noopt = @timed (x = Anoopt \ bnoopt); end
        # if what == "all" || what == "gauss"; julia = @timed (x = Ajulia \ bjulia); end

        # Console Print
            if what == "all" || what == "gauss"; println("[GAUSS] Size: $size | $(gem[2])s | w/ pivot: $(gemPivoted[2])s | $(gem[3]/2^20)MB | w/ pivot: $(gemPivoted[3]/2^20)MB"); end
            if what == "all" || what == "lu"; println("[LU] Size: $size | $(lu[2])s | w/ pivot: $(luPivoted[2])s | $(lu[3]/2^20)MB | w/ pivot: $(luPivoted[3]/2^20)MB"); end
        
        # Time / Mem for Latex Table (no optimization)
            # if what == "all"; println("$size & $(round(noopt[2], digits=6)) & $(round(noopt[3]/2^20, digits=3)) \\\\ \\hline"); end

        # Time / Mem for Latex Table (julia optimization)
            # if what == "all"; println("$size & $(round(julia[2], digits=6)) & $(round(julia[3]/2^20, digits=3)) \\\\ \\hline"); end

        # Time for Latex table
            # if what == "all"; println("$size & $(round(gem[2], digits=6)) & $(round(gemPivoted[2], digits=6)) & $(round(lu[2], digits=6)) & $(round(luPivoted[2], digits=6)) \\\\ \\hline"); end
        
        # Memory for Latex table
            # if what == "all"; println("$size & $(round(gem[3]/2^20, digits=3)) & $(round(gemPivoted[3]/2^20, digits=3)) & $(round(lu[3]/2^20, digits=3)) & $(round(luPivoted[3]/2^20, digits=3)) \\\\ \\hline"); end
        
        # Points for Latex Plot
            # Time
            # if what == "all" || what == "gauss"; print("($size , $(round(gem[2], digits=6))) "); end
            # if what == "all" || what == "gauss"; print("($size , $(round(gemPivoted[2], digits=6))) "); end
            # if what == "all" || what == "lu"; print("($size , $(round(lu[2], digits=6))) "); end
            # if what == "all" || what == "lu"; print("($size , $(round(luPivoted[2], digits=6))) "); end

        # Memory
            # if what == "all" || what == "gauss"; print("($size , $(round(gem[3]/2^20, digits=3))) "); end
            # if what == "all" || what == "gauss"; print("($size , $(round(gemPivoted[3]/2^20, digits=3))) "); end
            # if what == "all" || what == "lu"; print("($size , $(round(lu[3]/2^20, digits=3))) "); end
            # if what == "all" || what == "lu"; print("($size , $(round(luPivoted[3]/2^20, digits=3))) "); end
    end
end

##### -------------- TESTS --------------

using Test

originalSizes = [16, 10000, 50000]
function doTest()
    @testset "Matrix of Size [$size]:" for size in originalSizes
        A, n, l = openFileMatrix("tests/$(size)/A.txt", false)
        b = openFileRightVector("tests/$(size)/b.txt")
        x = A \ b
        errorLimit = 0                          

        @testset "Calculating Right Vector" begin
            @test isapprox(calculateRightVector(A, n, l), b)
        end

        A, n, l = openFileMatrix("tests/$(size)/A.txt", true)
        b = openFileRightVector("tests/$(size)/b.txt")

        @testset "Gaussian Elimination" begin
            @test isapprox(doGauss(A, b, n, l, false), x, atol = errorLimit)
        end

        A, n, l = openFileMatrix("tests/$(size)/A.txt", true)
        b = openFileRightVector("tests/$(size)/b.txt")

        @testset "Gaussian Elimination with Pivot" begin
            @test isapprox(doGaussPivot(A, b, n, l, false), x, atol = errorLimit)
        end

        A, n, l = openFileMatrix("tests/$(size)/A.txt", true)
        b = openFileRightVector("tests/$(size)/b.txt")

        @testset "LU" begin
            @test isapprox(doLU(A, b, n, l, false), x, atol = errorLimit)
        end

        A, n, l = openFileMatrix("tests/$(size)/A.txt", true)
        b = openFileRightVector("tests/$(size)/b.txt")

        @testset "LU with Pivot" begin
            @test isapprox(doLUPivot(A, b, n, l, false), x, atol = errorLimit)
        end
    end
end

##### -------------- UserManager --------------

function start() 
    input = ""
    printstyled("\n=== User Manager ==="; color = :yellow)

    while input != "exit"
        printstyled("\nAvailable Commands:"; color = :yellow)
        printstyled("\ncompare"; color = :green)
        printstyled("\nb"; color = :green)
        printstyled("\ntest"; color = :green)
        printstyled("\ncalculate"; color = :green)
        printstyled("\nType 'exit' to quit.\n"; color = :magenta)

        input = readline()

        if input == "test"
            println("Performing Tests!")
            doTest()
        elseif input == "compare"
            printstyled("Options: 'all' / 'gauss' / 'lu'\n"; color = :green)
            input = readline()
            compare(input)
        elseif input == "b"
            printstyled("Type in the size:\n"; color = :green)
            input = readline()
            getRightVector(input)
        elseif input == "calculate"
            printstyled("Choose: (gauss / lu)\n"; color = :green)
            option1 = readline()
            printstyled("Pivoted: (true / false)\n"; color = :green)
            option2 = readline()
            printstyled("Should Right Vector (b) be calculated? (true / false)\n"; color = :green)
            option3 = readline()
            printstyled("Size: (16, 1000, 2500, 5000, 7500, 10000, 25000, 50000, 75000, 100000)\n"; color = :green)
            option4 = readline()
            precalculate(option1, option2, option3, option4)
        elseif input != "exit"
            println("Command doesn't exist.")
        end
    end
end

printstyled("\nType in: '"; color = :yellow)
printstyled("start()"; color = :green)
printstyled("' to run the program! :3"; color = :yellow)