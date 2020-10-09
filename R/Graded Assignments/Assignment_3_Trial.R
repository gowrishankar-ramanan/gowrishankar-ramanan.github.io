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
  #z = numeric(length(x) + length(y))  #output vector to be returned
  z = numeric()  #output vector to be returned
  #print(length(z))
  mat <- matrix(0, nrow = length(y), ncol = length(x)+length(y))
  #mat.result <- matrix(0, nrow = length(y), ncol = length(x)+length(y))
  same_carry_over = rep(0,length(x))
  diff_carry_over = rep(0,length(y))
  
  x.r = rev(x) #Reverse the vectors
  y.r = rev(y)
  i=1   #index for x vector
  j=1   #index for y vector
  
  for(j in 1:length(y.r))
  {
    #sco_applied = FALSE
    carry_over = 0
    k = j-1
    #carry_over_applied = FALSE
    for(i in 1:length(x.r))
    {
      product = x.r[i] * y.r[j]
      #print(product)
      #Tokenize product into vectors of 3 digits
      prod_vector = num.split(product, 3)
      #print(prod_vector)
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
      #print(j)
      #print(i)
      #print(carry_over)
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
      
      # if (i == j && i != length(x.r) && j != length(y.r))
      # {
      #   #print(least_sig)
      #   z <- c(z, least_sig)
      #   #print(most_sig)
      #   #same_carry_over[i] = same_carry_over[i] + most_sig
      #   #same_carry_over[1] = same_carry_over[1] + most_sig
      #   same_carry_over[j] = same_carry_over[j] + most_sig
      # }
      # 
      # if (i != j)
      # {
      #   #print(least_sig)
      #   #same_carry_over[i] = same_carry_over[i] + least_sig
      #   #same_carry_over[1] = same_carry_over[1] + least_sig
      #   if(!sco_applied)
      #   {
      #     same_carry_over[j] = same_carry_over[j] + least_sig
      #     z <- c(z, same_carry_over[j])
      #     sco_applied = TRUE
      #   }
      #   
      #   #print(most_sig)
      #   #diff_carry_over[j] = diff_carry_over[j] + most_sig
      #   diff_carry_over[1] = diff_carry_over[1] + most_sig
      # }
      # 
      # if (i == j && i == (length(x.r)) && j == (length(y.r)))
      # {
      #   #print(least_sig)
      #   #print(most_sig)
      #   #z <- c(z, same_carry_over[i])
      #   print("SCO:")
      #   print(same_carry_over[1])
      #   prod_vector_sco = num.split(same_carry_over[1], 3)
      #   print(prod_vector_sco)
      #   if(length(prod_vector_sco) == 1)
      #   {
      #     least_sig_sco = prod_vector_sco[1]
      #     most_sig_sco = 0
      #   }
      #   if(length(prod_vector_sco) == 2)
      #   {
      #     least_sig_sco = prod_vector_sco[2]
      #     most_sig_sco = prod_vector_sco[1]
      #   }
      #   z <- c(z, least_sig_sco)
      #   #diff_carry_over[j] = diff_carry_over[j] + least_sig
      #   diff_carry_over[1] = diff_carry_over[1] + least_sig + most_sig_sco
      #   #z <- c(z, diff_carry_over[1])
      #   print("DCO:")
      #   print(diff_carry_over[1])
      #   prod_vector_dco = num.split(diff_carry_over[1], 3)
      #   print(prod_vector_dco)
      #   if(length(prod_vector_dco) == 1)
      #   {
      #     least_sig_dco = prod_vector_dco[1]
      #     most_sig_dco = 0
      #   }
      #   if(length(prod_vector_dco) == 2)
      #   {
      #     least_sig_dco = prod_vector_dco[2]
      #     most_sig_dco = prod_vector_dco[1]
      #   }
      #   z <- c(z, least_sig_dco)
      #   z <- c(z, most_sig + most_sig_dco)
      # }
    }
    #z <- c(z, diff_carry_over[j])
    #z <- c(z, diff_carry_over[1])
  }
  print(mat)
  end_result = colSums (mat, na.rm = FALSE, dims = 1)
  print(end_result)
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
  
  
  print(sprintf("%03d",rev(end_result)))
  #print(rev(colSums (mat, na.rm = FALSE, dims = 1)))
  #print(length(z))
  #z.r = rev(z)
  #z.formatted <- sprintf("%03d",z.r)
  #print(formatC(z.r, width = 3, format = "d", flag = 0))
  #print(z.formatted)
}

#function to split a number by specified intervals
num.split<- function(num, interval)
{
  if(log10(num) == ceiling(log10(num)))
  {
    dig <- ceiling(log10(num)) + 1
  }
  else
  {
    dig <- ceiling(log10(num))
  }
  #print(dig)
  
  if((dig%/%interval) == (dig/interval))
  {
    vec1 <- (10^interval)^((dig%/%interval):1)
  }
  else
  {
    vec1 <- (10^interval)^(((dig%/%interval)+1):1)
  }
  #print(vec1)
  
  vec2 <- vec1/(10^interval)
  #print(vec2)
  #print((num%%vec1)%/%vec2)
  return((num%%vec1)%/%vec2)
}

long.mult(c(123,456,789), c(987,654,321))
#long.mult(c(999,999), c(999,999))