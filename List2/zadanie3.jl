#Joanna Szołomicka
include("matcond.jl")
include("hilb.jl")


function getX(A, n)
	x = ones(Float64, n)	
	b = A * x 				
	gaussX = A \ b				
	inverseX = inv(A) * b			
	println( n,"times ",n," ",rank(A)," ",norm(gaussX - x) / norm(x), " ", norm(inverseX - x) / norm(x), " ", cond(A))
end

#hilbert matrix
function generateHilbert()
	for i = 1:20
		getX( hilb(i), i)
	end
end
#random matrix
function generateMatcond()
	for n in [5, 10, 20], c = [Float64(1.0), Float64(10.0), Float64(10.0^3), Float64(10.0^7), Float64(10.0^12), Float64(10.0^16)]
		getX(matcond(n, c), n)
	end
end


println("Macierz Hilberta")
generateHilbert()

println("Macierz losowa")
generateMatcond()
