#Joanna Szołomicka
using Plots
cA = Float64[-2.0,-2.0, -2.0, -1.0, -1.0, -1.0, -1.0,]          
x0 = Float64[1.0, 2.0, 1.99999999999999, 1.0, -1.0, 0.75, 0.25] 
#formula
function xn(xi,c, type)
    return type(xi*xi+c)        
end
#generates plot
function graphGenerate(A,file)
    plt=plot(x = 1:40, A,legend=false)
    png(plt,file)

end

function xArray(type)
    for j=1:7
        x=zeros(type,41)
        x[1]=type(x0[j])
            println("x0 ",x0[j], " c ",cA[j])
            println()
        for i=2:41
            x[i]=xn(x[i-1],cA[j],type)
            # println("&",x[i],"\\","\\")
        end   
        graphGenerate(x,string(x0[j],cA[j],".png"))
        # ,"\\","\\"
    end 
end
xArray(Float64)