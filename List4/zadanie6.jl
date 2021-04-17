#Joanna Szołomicka
#244937
include("interpolation.jl")

f(x) = abs(x)
g(x) = 1.0 / (1.0 + x^2)

interpolation.rysujNnfx(f, -1.0, 1.0, 5)
interpolation.rysujNnfx(f,  -1.0, 1.0, 10)
interpolation.rysujNnfx(f, -1.0, 1.0, 15)

interpolation.rysujNnfx(g,  -5.0, 5.0, 5)
interpolation.rysujNnfx(g,  -5.0, 5.0, 10)
interpolation.rysujNnfx(g,  -5.0, 5.0, 15)
