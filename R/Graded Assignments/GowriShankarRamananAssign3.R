name = "Gowri Shankar Ramanan"

#Assignment3 - function for long multiplication
long.mult<- function(x,y)
{
  if ( !is.vector(x) )  { stop('argument x is not a vector') }
  if ( !is.vector(y) )  { stop('argument y is not a vector') }
  if ( !is.numeric(x) ) { stop('argument x is not a numeric vector') }
  if ( !is.numeric(y) ) { stop('argument y is not a numeric vector') }
  if (length(x) == 0 || length(y) == 0) { stop('input arguments cannot be empty vectors') }
  #if(x < 0) { stop('argument x should not have negative integers') }
  #if(y < 0) { stop('argument y should not have negative integers') }

  mat <- matrix(0, nrow = length(y), ncol = length(x)+length(y))
  
  x.r = rev(x) #Reverse the vectors
  y.r = rev(y)
  i=1   #index for x vector
  j=1   #index for y vector
  
  for(j in 1:length(y.r))
  {
    carry_over = 0
    k = j-1
    for(i in 1:length(x.r))
    {
      product = x.r[i] * y.r[j]

      #Tokenize product into vectors of 3 digits
      prod_vector = num.split(product, 3)
      
      if(length(prod_vector) == 1)
      {
        least_sig = prod_vector[1]
        most_sig = 0
      }
      if(length(prod_vector) == 2)
      {
        least_sig = prod_vector[2]
        most_sig = prod_vector[1]
      }

      if(i==1)
      {
        mat[j,i+k] = least_sig
        carry_over = most_sig
      }
      else if(i == length(x))
      {
        mat[j,i+k] = least_sig + carry_over
        carry_over = 0
        mat[j,i+k+1] = most_sig
      }
      else
      {
        mat[j,i+k] = least_sig + carry_over
        carry_over = most_sig
      }
      
    }
    
  }
  #print(mat)
  end_result = colSums (mat, na.rm = FALSE, dims = 1)
  #print(end_result)
  
  most_sig = 0
  for (i in 1:length(end_result))
  {
    end_result[i] = end_result[i] + most_sig
    prod_vector = num.split(end_result[i], 3)
    if(length(prod_vector) == 1)
    {
      least_sig = prod_vector[1]
      most_sig = 0
    }
    if(length(prod_vector) == 2)
    {
      least_sig = prod_vector[2]
      most_sig = prod_vector[1]
      end_result[i] = least_sig
    }
    
  }

  return(sprintf("%03d",rev(end_result)))

}

#function to split a number by specified intervals
num.split<- function(num, interval)
{
  #print(num)
  if(log10(num) == ceiling(log10(num)))
  {
    dig <- ceiling(log10(num)) + 1
  }
  else
  {
    dig <- ceiling(log10(num))
  }
  #print(dig)
  
  vec1 <- (10^interval)^(2:1)
  #if((dig%/%interval) == (dig/interval))
  #{
  #  vec1 <- (10^interval)^((dig%/%interval):1)
  #}
  #else
  #{
  #  vec1 <- (10^interval)^(((dig%/%interval)+1):1)
  #}
  #print(vec1)
  
  vec2 <- vec1/(10^interval)
  #print(vec2)
  #print((num%%vec1)%/%vec2)
  return((num%%vec1)%/%vec2)
}

#long.mult(c(123,456,789), c(987,654,321))
#long.mult(c(123,456), c(987,654))
#long.mult(c(1,3), c(10,6))
#long.mult(c(999,999), c(999,999))