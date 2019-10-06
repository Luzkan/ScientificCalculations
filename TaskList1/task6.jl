# Marcel Jerzyk [06.10.2019 | 20:56-21:07]
# Task 6.

function fg(n)
    for i = 1 : n
        x = 8.0^(-i)
        f = sqrt((x)^2.0 + 1.0) - 1.0
        g = (x)^2 / (sqrt((x)^2.0 + 1.0) + 1.0)
        println("[8^(-$i)] f = $f\tg = $g")
    end
end

fg(200)