#Joanna Szołomicka

#population formula
function population(pi,r, type)
    return type(pi+r*pi*(1-pi))        
end
#without changes
function populationArray(type)
    pop=zeros(type,41)
    pop[1]=type(0.01)
    for i=2:41
        pop[i]=population(pop[i-1],type(3),type)
    end
    return pop
    
end

#changed in 10 iteration
function modPopulationArray(type)
    pop=zeros(type,41)
    pop[1]=type(0.01)
    for i=2:11
        pop[i]=population(pop[i-1],type(3),type)    
    end
    a = pop[11] * 1000
    pop[11] = trunc(a)/1000
    for i=12:41
        pop[i]=population(pop[i-1],3,type)    
    end
    return pop
    
end


function printArray(array)
    for i=2:40
        println(i-1, " ", array[i])
    end
end


a1=populationArray(Float32)
a2=modPopulationArray(Float32)
for i=2:41
    println(i-1,"&",a1[i],"&",a2[i],"\\","\\")
end
println()
a1=populationArray(Float32)
a2=populationArray(Float64)
for i=2:41
    println(i-1,"&",a1[i],"&",a2[i],"\\","\\")
end
