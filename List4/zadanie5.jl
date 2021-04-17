#Joanna Szołomicka
#244937
include("interpolation.jl")

f(x) = exp(x)
g(x) = x^2 * sin(x)

interpolation.rysujNnfx(f, 0.0, 1.0, 5)
interpolation.rysujNnfx(f, 0.0, 1.0, 10)
interpolation.rysujNnfx(f, 0.0, 1.0, 15)

interpolation.rysujNnfx(g, -1.0, 1.0 , 5)
interpolation.rysujNnfx(g, -1.0, 1.0 , 10)
interpolation.rysujNnfx(g, -1.0, 1.0 , 15)
