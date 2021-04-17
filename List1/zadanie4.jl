#Joanna Szołomicka
#najmniejsza z przedziału (1,2)
function printNumbers(type)
    i=nextfloat(one(type))
    while(i<2*one(type))
        if (1/i)*i!=one(type)
            return i
        end
        i=nextfloat(i)
    end
    return -1
end
#najmniejsza liczba
function minNumber(type)
    i=-floatmax(type)
    while(i<floatmax(type))
        if (1/i)*i!=one(type)
            return i
        end
        i=nextfloat(i)
    end
    return -1
end

println(printNumbers(Float64))
# println(minNumber(Float64))