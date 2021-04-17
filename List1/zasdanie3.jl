#Joanna Szołomicka
function printNumbers(a,b)
    delta = 2^(-52+floor(log(2,a)))
    for i = 0:3
        println(bitstring(a + i*delta))
        if a+i*delta>b
             return
        end
    end
    println()
    for i = 2^(52)-3:2^52-1
        println(bitstring(a + i*delta))
        if a+i*delta>b
             return
        end
    end
end


printNumbers(1,2)

#2^53 dla 0.5,1.0
#2^51 dla 2.0 4.0