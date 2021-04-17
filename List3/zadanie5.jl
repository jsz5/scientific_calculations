#Joanna Szołomicka
#244937
include("FindZeros.jl")

f(x) = exp.(x) - 3.0 * x
delta = 10.0^-4.0        
epsilon = 10.0^-4.0      


println("Wartości x, dla których przecinają się wykresy funkcji 3x i e^x")

println("Przedział (0,1): ") 
(r,v,it,err) = FindZeros.mbisekcji(f, 0.0, 1.0, delta, epsilon)
println("x1: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")

println("Przedział (1,2): ")
(r,v,it,err) = FindZeros.mbisekcji(f, 1.0, 2.0, delta, epsilon) 
println("x2: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")