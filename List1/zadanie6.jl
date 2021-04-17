#Joanna Szołomicka
function f()
    numberOne=one(Float64)
    numberTwo=2*numberOne
    x=8^(-1)
    for i=1:11
        println(sqrt(x^numberTwo+numberOne)-numberOne)
        x=x/8
    end
end

function g()
    numberOne=one(Float64)
    numberTwo=2*numberOne
    x=8^(-1)
    for i=1:11
        println(x^2/(sqrt(x^numberTwo+numberOne)+numberOne))
        x=x/8
    end
end

f()
println()
g()