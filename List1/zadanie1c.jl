#Joanna Szołomicka
function findMax(value)
    toAdd=one(value)
    max=one(value)
    while(!isinf(max*2))
        max*=2
    end
    half=max/2
    while(!isinf(max+half))
        max=max+half
        half=half/2
    end
    return max;
end

println(findMax(Float16))
println(floatmax(Float16))
println(findMax(Float32))
println(floatmax(Float32))

println(findMax(Float64))
println(floatmax(Float64))