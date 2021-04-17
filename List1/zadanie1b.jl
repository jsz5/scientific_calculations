#Joanna Szołomicka
function findEta(value)
    variable=one(value)
    while(variable/2>zero(value))
        variable=variable/2
    end
    return variable
end

println(findEta(Float16))
println(nextfloat(Float16(0.0)))
println(bitstring(findEta(Float64)))
println(nextfloat(Float32(0.0)))
println(findEta(Float64))
println(nextfloat(Float64(0.0)))
