#Joanna Szołomicka
#244937

include("blocksys.jl")
include("matrixgen.jl")
using Plots
plotly()


matrixes = [100, 500, 1000, 2000, 5000, 10000, 20000, 25000, 30000, 50000, 100000]
m=length(matrixes)
sM=4
cond = Float64(1.0)
timeGauss = Vector{Float64}(undef,m)
timeGaussChoose = Vector{Float64}(undef,m)
timesLu = Vector{Float64}(undef,m)
timesLuChoose = Vector{Float64}(undef,m)
timesLuDecompose= Vector{Float64}(undef,m)
timesLuChooseDecompose= Vector{Float64}(undef,m)

memoryGauss = Vector{Float64}(undef,m)
memoryGaussChoose = Vector{Float64}(undef,m)
memoryLu = Vector{Float64}(undef,m)
memoryLuChoose = Vector{Float64}(undef,m)

for i = 1:m
    matrixgen.blockmat(matrixes[i], sM, cond, "testA.txt")

    #Gauss
    (A,n,l) = blocksys.matrixFromFile("testA.txt")
    b = blocksys.generateVector(A,n,l)
    results = @timed blocksys.gaussianElimination(A,n,l,b)        
    timeGauss[i] = results[2] 
    memoryGauss[i] = results[3]
 

    #GaussChoose
    (A,n,l) = blocksys.matrixFromFile("testA.txt")
    b = blocksys.generateVector(A,n,l)
    results = @timed blocksys.gaussianEliminationChoose(A,n,l,b)        
    timeGaussChoose[i] = results[2] 
    memoryGaussChoose[i] = results[3]
  
    #LU
    (A,n,l) = blocksys.matrixFromFile("testA.txt")
    b = blocksys.generateVector(A,n,l)
    # results = @timed blocksys.LUDecomposeAndSolve(A,n,l,b)          
    results2 = @timed blocksys.LUDecompose(A,n,l)          
    # timesLu[i] = results[2] 
    timesLuDecompose[i] = results2[2] 
    # memoryLu[i] = results[3]

    #LUChoose
    (A,n,l) = blocksys.matrixFromFile("testA.txt")
    b = blocksys.generateVector(A,n,l)
    # results = @timed blocksys.LUDecomposeAndSolveChoose(A,n,l,b)        
    results2 = @timed blocksys.LUDecomposeChoose(A,n,l)    
    timesLuChooseDecompose[i]=results2[2]    
    # timesLuChoose[i] = results[2] 
    # memoryLuChoose[i] = results[3]
   
end

#plots
# labels = Array{String}(undef,1, 5)
# labels[1] = "Gauss"
# labels[2] = "Gauss z wyborem"
# labels[3] = "LU"
# labels[4] = "LU z wyborem"
# plt = plot(matrixes, [timeGauss, timeGaussChoose,timesLu,timesLuChoose], label = labels, title = "Czas działania",linewidth=2.0)
# display(plt)

labelsLU = Array{String}(undef,1, 3)
labelsLU[1] = "LU"
labelsLU[2] = "LU z wyborem"
plt = plot(matrixes, [timesLuDecompose,timesLuChooseDecompose], label = labelsLU, title = "Czas działania rozkładu LU",linewidth=2.0)
display(plt)

# plt = plot(matrixes, [memoryGauss, memoryGaussChoose,memoryLu,memoryLuChoose], label = labels, title = "Zużycie pamięci",linewidth=2.0)
# display(plt)


#relative error
matrixes = [16, 100, 500, 2000, 25000]
for i = 1:length(matrixes)
    matrixgen.blockmat(matrixes[i], sM, cond, "testA.txt")
    index=matrixes[i]

   #Gauss
   (A,n,l) = blocksys.matrixFromFile("testA.txt")
   b = blocksys.generateVector(A,n,l)
   x=blocksys.gaussianElimination(A,n,l,b)        
   blocksys.toFile("gauss$index",x,matrixes[i],true)
 
   #GaussChoose
   (A,n,l) = blocksys.matrixFromFile("testA.txt")
   b = blocksys.generateVector(A,n,l)
   x=blocksys.gaussianEliminationChoose(A,n,l,b)        
   blocksys.toFile("gaussianEliminationChoose$index",x,matrixes[i],true)

   #LU
   (A,n,l) = blocksys.matrixFromFile("testA.txt")
   b = blocksys.generateVector(A,n,l)
   x=blocksys.LUDecomposeAndSolve(A,n,l,b)        
   blocksys.toFile("LUDecomposeAndSolve$index",x,matrixes[i],true)

   #LUChoose
   (A,n,l) = blocksys.matrixFromFile("testA.txt")
   b = blocksys.generateVector(A,n,l)     
   x=blocksys.LUDecomposeAndSolveChoose(A,n,l,b)        
   blocksys.toFile("LUDecomposeAndSolveChoose$index",x,matrixes[i],true)

end


