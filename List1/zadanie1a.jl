#Joanna Szołomicka
function findMachineEpsilon(value)
    variable=one(value)
    constOne=one(value)
    while(constOne+variable>constOne)
        variable=variable/2
    end
    variable=variable*2
    return variable
end

println(findMachineEpsilon(Float16))
println(eps(Float16))
println(findMachineEpsilon(Float32))
println(eps(Float32))
println(findMachineEpsilon(Float64))
println(eps(Float64))

