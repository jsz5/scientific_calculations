#Joanna Szołomicka
function kahan(type)
    oneN=one(type)
    println((3*oneN)*((4*oneN)/(3*oneN)-oneN)-oneN)
    println(eps(type))
end

kahan(Float16)
kahan(Float32)
kahan(Float64)
