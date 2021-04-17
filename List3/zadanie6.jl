#Joanna Szołomicka
#244937
include("FindZeros.jl")

f1(x) =  exp.(1.0 - x) - 1.0
f2(x) = x * exp.(-x)

pf(x) = -exp.(1.0 - x)
pf2(x) = exp.(-x) - x * exp.(-x)

delta = 10.0^-5.0               # dokładność obliczeń
epsilon = 10.0^-5.0             # dokładność obliczeń
maxit = 100000                      # maksymalna dopuszczalna liczba iteracji

println("y = e^(1-x)-1: ")

println("Metoda bisekcji: ")
(r,v,it,err) = FindZeros.mbisekcji(f1, -100.0, 1000.0, delta, epsilon)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")
println("\$[-100.0,1000.0]\$&$r&$v&$it\\\\")
println("Metoda Newtona: ")
(r,v,it,err) = FindZeros.mstycznych(f1, pf,8.0, delta, epsilon, maxit)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")

println("14.0&$r&$v&$it&$err\\\\")

println("Metoda siecznych: ")
(r,v,it,err) = FindZeros.msiecznych(f1,-3.0,4.0, delta, epsilon, maxit)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")
println("-3.0&4.0&$r&$v&$it&$err\\\\")

println("y = xe^-x: ")

println("Metoda bisekcji: ")
(r,v,it,err) = FindZeros.mbisekcji(f2, -100.0,1000.0, delta, epsilon)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")
println("\$[-2.0,50.0]\$&$r&$v&$it\\\\")

println("Metoda Newtona: ")
(r,v,it,err) = FindZeros.mstycznych(f2, pf2, 10.0, delta, epsilon, maxit)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")
println("200.0&$r&$v&$it&$err\\\\")

println("Metoda siecznych: ")
(r,v,it,err) = FindZeros.msiecznych(f2, 5.0,1000.0, delta, epsilon, maxit)
println("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)")
println("5.0&1000.0&$r&$v&$it&$err\\\\")



