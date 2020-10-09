
library(compiler)



sort.b <- function(x)
{ # sort.b
  
   if ( !is.vector(x)  ) { stop("x must be a vector.\n") };
#   if ( !is.valid.numeric(x) ) { stop("x must be numeric and contain no NaN or NA or Inf values.\n")  };
   n = length(x)
   if ( n == 1 ) { return(x) }

   for ( i in n:2 )
      {  # loop i works on vector of size n, then n-1, then n-2, ... down  to 2
         for ( j in 1:(i-1))
            { # loop j pushes max element of x[1:i] to x[i]
               if ( x[j] > x[j+1] )
                  { # switch
                     t      = x[j]
                     x[j]   = x[j+1]
                     x[j+1] = t
                  } # switch
            } # loop j pushes max element of x[1:i] to x[i] 
      }  #  loop i works on vector of size n, then n-1, then n-2, ... down  to 2

   return(x)
} # sort.b	

sb <- cmpfun(sort.b)

x = rnorm(1000)

system.time(sort.b(x))
system.time(sb(x))

##############################################
#     function trapzd.area
#
#     inputs:
#              f,a,b where f is the function to be
#                    numerically integrated over the limits
#                    [a,b]
#              f needs to accept a vetor of inputs and return a
#              vector of the same size as the input vector
#              n is the starting number of intervals (panels)
#              after the first evaluation with n panels we double
#              the number of panels and compare with the previous
#              area. We continue until 
#              abs(old integral - new integral)/old integral <= tol
#              where tol is a positive number


trapzd.area <- function(f,a,b,n = 1000,tol = 1.0e-3)
{ # begin trapzd.area

   if ( !is.function(f) ) { stop("f must be a function") }
   if ( length(a) != 1 | length(b) != 1 ) { stop("a and b must have length 1") }
   if ( !is.numeric(a) | !is.numeric(b) | ( a >= b ) )
       { stop("a and be must be numeric and a < b") }
   if ( !is.numeric(n) || length(n) != 1 || n < 1  )
       { stop('n must be a positive integer') }
   if ( !is.numeric(tol) || length(tol) != 1 || tol < 0  )
       { stop('tol must be a positive number') }


   h = (b - a)/n
   p.s     = 0:n
   pts     = a + h*p.s
   f.pts   = f(pts)
   if ( length(f.pts) != length(pts) ) { stop("function needs to accept 
                                         a vector input and return a vector")}
   s.old   = 0.5*h*( f.pts[1] + f.pts[n+1] + 2*sum(f.pts[2:n]) )
     ####  generate n new points from a + (h/2) by h
   pts     = a + (h/2) + h*p.s[1:n]
   f.pts   = f(pts)
     #### correct longer formula is 0.5*s.old + 0.5*(h/2)*2*sum(f.pts)
   s.new   = 0.5*s.old + (h/2)*sum(f.pts)
   while ( abs((s.new - s.old)/s.old) > tol)
      {
          s.old = s.new
          n     = 2*n      # double the number of points
          if (n >2.0e6) {print("n > 2 million. returning."); break}
          h     = h/2
          p.s   = 0:(n-1)
          pts   = a + h/2 +h*p.s # evaluate the NEW points only
          f.pts = f(pts) 
          s.new = 0.5*s.old + (h/2)*sum(f.pts)
      } 

   return( s.new )

} # end trapzd.area

################ example function to integrate

f <- function(x) { return(sin(1/x))}
ta <- cmpfun(trapzd.area)

system.time(trapzd.area(f,0.01,5,tol=1.0e-8))

system.time(ta(f,0.01,5,tol=1.0e-8))

