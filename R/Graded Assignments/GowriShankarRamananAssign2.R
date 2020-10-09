name = "Gowri Shankar Ramanan"

#Assignment2 - function for nth root
nth.root <- function(a,n,tol)
{
  if ( !is.vector(a) )  { stop('argument a is not a vector') }
  if ( !is.vector(n) )  { stop('argument n is not a vector') }
  if ( !is.vector(tol) )  { stop('argument tol is not a vector') }
  if ( !is.numeric(a) ) { stop('argument a is not a numeric vector') }
  if ( !is.numeric(n) ) { stop('argument n is not a numeric vector') }
  if ( !is.numeric(tol) ) { stop('argument tol is not a numeric vector') }
  if ( length(a) < 1 || length(n) < 1 || length(tol) < 1 ) 
  { 
    stop('All arguments should be a numeric vector of length 1') 
  }
  if (tol[1] < 1e-15) { stop('argument tol cannot be less than 1e-15') }
  if(a < 0) { stop('argument a should not be negative, as there is no real negative nth root') }
  if(n < 0) { stop('argument n should not be negative, as there is no real negative nth root') }
  x = a
  delta = x
  while (abs(delta) >= tol)
  {
    #x = (1/n) * ((n-1) * x + (a/x^(n-1)))
    delta = (1/n) * ((a/x^(n-1)) - x)
    #print(delta)
    x = x + delta
    #print(x)
  }
  return(x)
}
