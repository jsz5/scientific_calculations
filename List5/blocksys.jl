#Joanna Szołomicka
#244937

module blocksys
export matrixFromFile, vectorFromFile, generateVector, toFile, gaussianElimination, gaussianEliminationChoose, LUDecompose, LUSolve, LUDecomposeChoose, LUSolveChoose, LUDecomposeAndSolve, LUDecomposeAndSolveChoose
using SparseArrays
using LinearAlgebra
##Wczytuje macierz z pliku
## @param filename - nazwa pliku
## @return (macierz, rozmiar macierzy n, rozmiar podmacierzy l)

function matrixFromFile(filename::String)
    open(filename) do file
        line=split(readline(file));
        (n,l)=(parse(Int64,line[1]),parse(Int64,line[2]));
        row=Int64[]
        column=Int64[];
        value=Float64[];
        for fileline in eachline(file)
            line=split(fileline);
            push!(row,parse(Int64,line[1]));
            push!(column,parse(Int64,line[2]));
            push!(value,parse(Float64,line[3]));
        end
        return (sparse(column,row,value),n,l);
    end
end

##Wczytuje wektor prawych stron z pliku
## @param filename - nazwa pliku
## @return wektor b
function vectorFromFile(filename::String)
	open(filename) do file
		n = parse(Int64, readline(file))
		b = Float64[];
        for fileline in eachline(file)
            push!(b,parse(Float64,fileline));
        end
		return b
	end
end


## Generuje wektor prawych stron na podstawie wektora x== (1, . . . ,1)^T, dla b=Ax
function generateVector(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	b = zeros(Float64, n)
	v = convert(Int64, n/l)
	for i in 1:v
		min_idx = convert(Int64, max(l-2 + (i-2)*l, 1))
		max_idx = i * l
		for j in 1:l
			row = (i-1)*l + j
			for k in min_idx:max_idx
				b[row] += A[k, row]
			end
			if  i < v
				b[row] += A[row+l, row]
			end
		end
	end
	b
end


## Zapisuje wynik do pliku
## @param relativeError - jeżeli true zapisany zostaje błąd względny wyniku
function toFile(file::String, x::Array{Float64}, n::Int64, relativeError::Bool)
	open(file, "w") do f
		if relativeError
			exact_solution = ones(n)
			println(f, norm(exact_solution - x) / norm(x))
		end
		for i in 1:n
			println(f, x[i])
		end
	end
end


##Rozwiązanie układu równań metodą Gaussa
## @return x - rozwiązanie układu
function gaussianElimination(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	for k in 1 : n-1
		max_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		max_col = convert(Int64, min(k + l, n))
		for i in k+1:max_row
			if abs(A[k,k]) < eps(Float64)
				error("Współczynnik na przekątnej macierzy jest równy 0.")
			end
			z = A[k, i] / A[k, k]
			A[k, i] = 0
			for j in k + 1:max_col
				A[j, i] = A[j, i] - z * A[j, k]
			end
			b[i] = b[i] - z * b[k]
		end
	end

	x = Array{Float64}(undef,n)
	for i in n:-1:1
		sum = 0.0
		max_col = min(n, i + l)
		for j in i+1:max_col
			sum += A[j, i] * x[j]
		end
		x[i] = (b[i] - sum) / A[i, i]
	end
	return x
end

##Rozwiązanie układu równań metodą Gaussa z wyborem
## @return x - rozwiązanie układu
function gaussianEliminationChoose(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	p = collect(1:n)

	for k in 1:n - 1
		last_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		last_col = convert(Int64, min(2*l + l * floor((k+1) / l), n))
		for i in k + 1 : last_row
			max_row = k
			max = abs(A[k,p[k]])
			for x in i : last_row
				if (abs(A[k,p[x]]) > max)
					max_row = x;
					max = abs(A[k,p[x]])
				end
			end
			if (abs(max) < eps(Float64))
				error("Macierz osobliwa.")
			end
			p[k], p[max_row] = p[max_row], p[k]
			z = A[k,p[i]] / A[k,p[k]]
			A[k,p[i]] = 0
			for j in k + 1 : last_col
				A[j,p[i]] = A[j,p[i]] - z * A[j,p[k]]
			end
			b[p[i]] = b[p[i]] - z * b[p[k]]
		end
	end

	x = Array{Float64}(undef,n)
	for i in n : -1 : 1
		prev_total = 0.0
		last_col = convert(Int64, min(2*l + l*floor((p[i]+1)/l), n))
		for j in i + 1 : last_col
			prev_total += A[j,p[i]] * x[j]
		end
		x[i] = (b[p[i]] - prev_total) / A[i, p[i]]
	end
	return x
	x
end

##Rozkład LU macierzy
function LUDecompose(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	for k in 1:n-1
		max_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		max_col = convert(Int64, min(k + l, n))
		for i in k + 1:max_row
			if abs(A[k,k]) < eps(Float64)
				error("Współczynnik na przekątnej macierzy jest równy 0.")
			end
			z = A[k, i] / A[k, k]
			A[k, i] = z
			for j in k + 1:max_col
				A[j, i] = A[j, i] - z * A[j, k]
			end
		end
	end
end

##Rozwiązanie układu równań po rozkładzie LU
## @return x - rozwiązanie układu
function LUSolve(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	z = Array{Float64}(undef,n)
	for i in 1:n
		sum = zero(Float64)
		min_col = convert(Int64, max(l * floor((i-1) / l) - 1, 1))
		for j in min_col:i-1
			sum += A[j, i] * z[j]
		end
		z[i] = b[i] - sum
	end
	x = Array{Float64}(undef,n)
	for i in n:-1:1
		sum = zero(Float64)
		max_col = min(n, i + l)
		for j in i + 1:max_col
			sum += A[j, i] * x[j]
		end
		x[i] = (z[i] - sum) / A[i, i]
	end
	return x
end

##Rozkład LU macierzy z wyborem
function LUDecomposeChoose(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	p = collect(1:n)

	for k in 1:n - 1
		max_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		max_col = convert(Int64, min(2 * l + l * floor((k+1) / l), n))
		for i in k + 1 : max_row
			max_idx = k
			max = abs(A[k,p[k]])
			for x in i : max_row
				if (abs(A[k,p[x]]) > max)
					max_idx = x;
					max = abs(A[k,p[x]])
				end
			end
			if (abs(max) < eps(Float64))
				error("Macierz osobliwa.")
			end
			p[k], p[max_idx] = p[max_idx], p[k]
			z = A[k,p[i]] / A[k,p[k]]
			A[k,p[i]] = z
			for j in k+1:max_col
				A[j,p[i]] = A[j,p[i]] - z * A[j,p[k]]
			end
		end
	end
	return p
end

##Rozwiązanie układu równań po rozkładzie LU z wyborem
## @return x - rozwiązanie układu 
function LUSolveChoose(A::SparseMatrixCSC{Float64, Int64}, n::Int64,
							l::Int64, b::Vector{Float64}, p::Vector{Int64})
	z = Array{Float64}(undef, n)
	for i in 1 : n
		sum = zero(Float64)
		min_col = convert(Int64, max(l * floor((i-1) / l) - 1, 1))
		for j in min_col : i-1
			sum += A[j, p[i]] * z[j]
		end
		z[i] = b[p[i]] - sum
	end

	x = Array{Float64}(undef, n)
	for i in n : -1 : 1
		sum = zero(Float64)
		max_col = convert(Int64, min(2*l + l*floor((i+1)/l), n))
		for j in i + 1 : max_col
			sum += A[j, p[i]] * x[j]
		end
		x[i] = (z[i] - sum) / A[i, p[i]]
	end
	return x
end


##Rozkład LU i rozwiązanie układu równań po rozkładzie LU
## @return x - rozwiązanie układu
function LUDecomposeAndSolve(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	LUDecompose(A,n,l)
	return LUSolve(A, n,l,b)
end


##Rozkład LU z wyborem i rozwiązanie układu równań po rozkładzie LU z wyborem 
## @return x - rozwiązanie układu
function LUDecomposeAndSolveChoose(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	p = LUDecomposeChoose(A,n,l)
	return LUSolveChoose(A, n,l,b, p)
end


end
