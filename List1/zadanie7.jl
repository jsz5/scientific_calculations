#Joanna Szołomicka
function f(x)
    return sin(x)+cos(3x)
end

function derivative(h)
    x0=one(Float64)
    fx0=f(x0)
    return (f(x0+h)-fx0)/h
end
#wypisuje przybliżenie pochodnej
function printDerivatives()
    h=2^zero(Float64)
    for i=0:54
        println(i," ",derivative(h))
        h=h/2
    end
end
#wypisuje 1+h
function printH()
    h=2^zero(Float64)
    for i=0:54
       println(i," ",1+h)
        h=h/2
    end
end
#zwraca rzeczywistą pochodną
function realDerivative()
    x0=one(Float64)
    return cos(x0)-3*sin(3*x0)    
end
#wypisuje błąd
function approximation()
    h=2^zero(Float64)
    real=realDerivative()
    for i=0:54
        println(i," ",abs(real-derivative(h)))
        h=h/2
    end
end
printDerivatives()
println()
printH()
println()
approximation()