#Joanna Szołomicka
#244937
include("FindZeros.jl")


f(x) = sin(x) - (0.5 * x)^2.0
pf(x) = cos(x) - 0.5 * x

delta = 0.5 * 10.0^-5.0             
epsilon = 0.5 * 10.0^-5.0           
maxit = 25                         

println("Metoda bisekcji: ")
(r,v,it,err) = FindZeros.mbisekcji(f, 1.5, 2.0, delta, epsilon)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")

println("Metoda Newtona: ")
(r,v,it,err) = FindZeros.mstycznych(f, pf, 1.5, delta, epsilon, maxit)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")

println("Metoda siecznych: ")
(r,v,it,err) = FindZeros.msiecznych(f, 1.0, 2.0, delta, epsilon, maxit)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")