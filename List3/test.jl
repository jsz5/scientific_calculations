#Joanna Szołomicka
#244937
using Test
include("FindZeros.jl")

f(x) = x^2 - 9
g(x) = x^4 - 256
e(x) = x^3 - 216
pf(x) = 2*x
pg(x) = 4*(x^3)
pe(x) = 3*(x^2)

delta = 10.0^-6.0
epsilon = 10.0^-6.0
maxit = 64


(r1,v,it,err) = FindZeros.mbisekcji(f, 2.0, 4.5, delta, epsilon)
(r2,v,it,err) = FindZeros.mstycznych(f, pf, 7.0, delta, epsilon, maxit)
(r3,v,it,err) = FindZeros.msiecznych(f, 1.0, 4.0, delta, epsilon, maxit)
@testset "fx" begin
    @test isapprox(r1,3,rtol = epsilon)
    @test isapprox(r2,3,rtol = epsilon)
    @test isapprox(r3,3,rtol = epsilon)
end

(r1,v,it,err) = FindZeros.mbisekcji(g, 1.5, 6.0, delta, epsilon)
(r2,v,it,err) = FindZeros.mstycznych(g, pg, 1.0, delta, epsilon, maxit)
(r3,v,it,err) = FindZeros.msiecznych(g, 1.0, 6.5, delta, epsilon, maxit)
@testset "gx" begin
    @test isapprox(r1,4,rtol = epsilon)
    @test isapprox(r2,4,rtol = epsilon)
    @test isapprox(r3,4,rtol = epsilon)
end


(r1,v,it,err) = FindZeros.mbisekcji(e, 1.5, 12.0, delta, epsilon)
(r2,v,it,err) = FindZeros.mstycznych(e, pe, 1.0, delta, epsilon, maxit)
(r3,v,it,err) = FindZeros.msiecznych(e, 1.0, 14.5, delta, epsilon, maxit)
@testset "ex" begin
    @test isapprox(r1,6,rtol = epsilon)
    @test isapprox(r2,6,rtol = epsilon)
    @test isapprox(r3,6,rtol = epsilon)
end
