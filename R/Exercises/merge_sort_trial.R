merge.sort <- function(in1, in2)
{
  out <- vector(mode="numeric", length=0)
  i = 1
  j = 1
  k = 1
  
  if ( length(in1) == 0 )
  {
    return (in2)
  }
  
  if ( length(in2) == 0 )
  {
    return (in1)
  }
  
  in1
  in2
  
  while ( length(in1) >= i || length(in2) >= j )
  {
    if ( in1[i] < in2[j] )
    {
      out[k] = in1[i]
      i = i+1
    }
    else if ( in1[i] == in2[j] )
    {
      out[k] = in1[i]
      k = k + 1
      out[k] = in2[j]
      j = j+1
    }
    else
    {
      out[k] = in2[j]
      j = j+1
    }
    k = k + 1
  }
  return(out)
}

a = c(1,2,3,4) 
b = c(1.5,3,5)
x = merge.sort(a,b)
x