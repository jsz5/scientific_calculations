#Joanna Szołomicka
#244937

module FindZeros

export mbisekcji, mstycznych, msiecznych

#=
  @param f    funkcja
  @param a,b  końce przedziału początkowego
  @param delta, epsilon dokladność obliczeń
=#
function swap(x::Float64, y::Float64)
  return(y,x)
end
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
  if b < a
   (a,b)=swap(a,b)
  end
  fa=f(a)
  fb=f(b)

  if sign(fa) == sign(fb)
    return "err", "err", "err", 1;
  end
  d=b-a
  it=0
  while d>epsilon #dopóki iteracja w przedziale jest możliwa
    it+=1
    d/=2
    r=a+d #środek przedziału
    fr=f(r) #wartość w środku przedziału
    if(abs(d)<delta || abs(fr)<epsilon) #błąd jest dostatecznie mały lub fr jest dostatecznie bliskie 0
        return r, fr, it, 0
    end
    if(sign(fr)!=sign(fa))
      b=r
      fb=fr
    else
      a=r
      fa=fr
  
    end
  end
end



#=
  @param f  funkcja
  @param pf   pochodna
  @param x0 przyblizenie poczatkowe
  @param delta, epsilon dokladnosc obliczen
  @param maxit maksymalna ilosc iteracji
=#
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
  v = f(x0)              
  if (abs(pf(x0)) < epsilon)     
    return "err", "err", "err", 2
end
  if(abs(v) < epsilon)    
      return x0, v, 0, 0
  end

 

  for it = 1 : maxit
      x1 = x0 - (v/pf(x0))   
      v = f(x1)             

      if(abs(x1 - x0) < delta || abs(v) < epsilon)   
          return x1, v, it, 0
      end
      x0 = x1               
  end

  return "err", "err", "err", 1  
end


#=
  @param f    funkcja
  @param x1, xo  przyblizenia poczatkowe
  @param delta, epsilon dokladnosc obliczen
  @param maxit maksymalna ilosc iteracji
=#
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
  fx0 = f(x0)        
  fx1 = f(x1)         

  for it = 1 : maxit
      if (abs(fx0) > abs(fx1))   
          (x0,x1)=swap(x0,x1)            
          (fx0,fx1)=swap(fx0,fx1)
      end

      s = (x1 - x0)/(fx1 - fx0)
      x1 = x0
      fx1 = fx0
      x0 = x0 - (fx0 * s)        
      fx0 = f(x0)                

      if (abs(x1 - x0) < delta || abs(fx0) < epsilon)     
          return x0, fx0, it, 0
      end
  end

  return "err", "err", "err", 1  
end

end
