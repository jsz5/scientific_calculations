#Joanna Szołomicka
x=Float64[2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y=Float64[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
function sumA(type)
    sum=zero(type)
    for i = 1:5
        sum=sum+x[i]*y[i]
    end
    return sum
end
function sumB(type)
    sum=zero(type)
    i=5
    while i>=1
        sum=sum+x[i]*y[i]
        i-=1
    end
    return sum
end

function multiple(type)
    sum=Array{type}(undef,5) 
    for i=1:5
        sum[i]=x[i]*y[i]
    end
    return sum
end

function sortC(sum, type)
    sorted=sort(sum, rev=true)
    positive=zero(type)
    negative=zero(type)
    i=1
    while  i<=5 && sorted[i]>=zero(type)
        positive+=sorted[i]
        i+=1
    end
    j=5
    while j>=1 && sorted[j]<zero(type)
        negative+=sorted[j]
        j-=1
    end
    println(positive+negative)
end


function sortD(sum, type)
    sorted=sort(sum)
    positive=zero(type)
    negative=zero(type)
    i=1
    while i<=5 && sorted[i]<zero(type)
        i+=1
    end
    index=i
    i=i-1
    while i>=1 && sorted[i]<zero(type)
        negative+=sorted[i]
        i=i-1
    end
    i=index
    while i<=5 && sorted[i]>=zero(type)
        positive+=sorted[i]
        i+=1
    end
    println(positive+negative)
end




# println(sumA(Float32))
# println(sumB(Float32))
# multipleArray=multiple(Float32)
# sortC(multipleArray,Float32)
# sortD(multipleArray, Float32)


println(sumA(Float64))
println(sumB(Float64))
multipleArray=multiple(Float64)
sortC(multipleArray,Float64)
sortD(multipleArray, Float64)


