#Joanna Szołomicka
#244937

module interpolation
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx

using Plots
plotly()

# Funkcja obliczająca ilorazy różnicowe
# x - wektor z węzłami, f - wektor z wartościami funkcji w węzłach
# fx - wektor obliczonych ilorazów różnicowych
function ilorazyRoznicowe(x :: Vector{Float64}, f :: Vector{Float64})
    n = length(f)             
    fx = Vector{Float64}(undef,n)  
    for i = 1 : n             
        fx[i] = f[i]
    end
    for i = 2 : n             
		for j = n : -1 : i
			fx[j] = (fx[j] - fx[j - 1]) / (x[j] - x[j - i + 1])
		end
	end
    return fx
end


# Funkcja obliczająca wartość wielomianu interpolacyjnego w postaci Newtona za pomocą uogólnionego algorytmu Hornera
# x - wektor z węzłami, f - wektor z wartościami funkcji w węzłach
# t - punkt w którym należy obliczyć wartość wielomianu
# nt - wartość wielomiau w punkcie t
function warNewton(x :: Vector{Float64}, fx :: Vector{Float64}, t :: Float64)
    n = length(fx)      
    nt = fx[n]
	for i = n-1 : -1 : 1
		nt = fx[i]+(t-x[i])*nt
	end
    return nt
end


# Funkcja obliczająca współczynniki wielomianu interpolacyjnego w postaci normalnej
# x - wektor z węzłami, f - wektor z wartościami funkcji w węzłach
# a - wektor współczynników w postaci normalnej
function naturalna(x :: Vector{Float64}, fx :: Vector{Float64})
    n = length(fx)                 
    a = Vector{Float64}(undef,n)   
    a[n] = fx[n]                   
    for k = n-1 : -1 : 1           
        a[k] = fx[k]-a[k+1]*x[k]   
        for i = k+1 : n-1          
            a[i] = a[i]-a[i+1]*x[k]
        end
    end
    return a
end


# Funkcja interpoluje zadaną funkcję w danym przedziale za pomocą wielomianu w postaci Newtona oraz rysuje wielomian interpolacyjny i interpolowaną funkcję.
# f -zadana funkcja; a, b - końce przedziału; n - stopień wielomianu
function rysujNnfx(f, a :: Float64, b :: Float64, n :: Int)
    multPlot = 20                       
    maxK=n+1 
    kh = 0.0                                    
    h = (b-a)/n       
    x = Vector{Float64}(undef,n + 1)       
    y = Vector{Float64}(undef,n+1)        
    fx = Vector{Float64}(undef,n+1)       
    img_y = Vector{Float64}(undef,multPlot*maxK)       
    img_x = Vector{Float64}(undef,multPlot*maxK)       
    img_interp = Vector{Float64}(undef,multPlot*maxK)                           
    for i = 1: maxK
        x[i] = a + kh
        y[i] = f(x[i])
        kh += h
    end
    fx = ilorazyRoznicowe(x, y);
    kh = 0.0
    maxK *= multPlot
    h = (b - a)/(maxK-1)
    for i = 1: maxK
        img_x[i] = a + kh
        img_interp[i] = warNewton(x, fx, img_x[i])
        img_y[i] = f(img_x[i])
        kh += h
    end
    labels = Array{String}(undef,1, 3)
    labels[1] = "f(x)"
    labels[2] = "w(x)"
    plt = plot(img_x, [img_y, img_interp], label = labels, title = "n=$n",linewidth=2.0)
    display(plt)
end
end