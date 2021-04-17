#Joanna Szołomicka

using SymPy
using Plots

@vars x real=true
f(x)= exp.(x) * log.(1.0 + exp.(-x))
#returns limit
function getLimit()
    return limit(f(x), x,oo)
    
end
#generates plot
function generatePlot(i,j)
    plotly()
    plt = plot(f(x), i, j,legend=false)
    display(plt)
end

generatePlot(30,50)
println("Limit ",getLimit())
