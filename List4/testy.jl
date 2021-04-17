#Joanna Szołomicka
#244937
using Test
include("interpolation.jl")

@testset "ilorazyRoznicowe" begin
    @test isapprox(interpolation.ilorazyRoznicowe([3.0, 1.0, 5.0, 6.0], [1.0, -3.0, 2.0, 4.0]), [1.0,2.0,-0.375,0.175])
end

@testset "warNewton" begin
    @test isapprox(interpolation.warNewton([0.0, 1.0, 3.0, 4.0], [1.0, 2.0, -0.8333333, 0.166667], 1.0), 3.0)
end

x2 = [-1.0, 0.0, 1.0, 2.0, 3.0]
f2 = [2.0, 1.0, 2.0, -7.0, 10.0]
@testset "naturalna" begin
    @test isapprox(interpolation.naturalna(x2, interpolation.ilorazyRoznicowe(x2, f2)), [1.0, 6.0, -1.0, -6.0, 2.0])
end