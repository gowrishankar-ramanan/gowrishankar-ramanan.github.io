name = "Gowri Shankar Ramanan"

#Assignment1 - Function for merge sort given two sorted vectors in1 and in2
merge.sort <- function(in1,in2)
{
  if ( !is.vector(in1) )  { stop('in1 argument is not a vector') }
  if ( !is.vector(in2) )  { stop('in2 argument is not a vector') }
  if ( !is.numeric(in1) ) { stop('in1 argument is not a numeric vector') }
  if ( !is.numeric(in2) ) { stop('in2 argument is not a numeric vector') }
  if(is.unsorted(in1) || is.unsorted(in2))
  {
    stop('Input vectors are unsorted. They should be sorted per pre-requisites of this function')
  }
  
  out = numeric(length(in1) + length(in2))  #output vector to be returned
  i=1   #index for in1 vector
  j=1   #index for in2 vector
  
  for(k in 1:length(out)) #k is the index for output vector
  {
    #If value in in1 index has the lowest value, add in1 value to the output and increment in1 index
    if((i<=length(in1) && in1[i]<in2[j]) || j>length(in2)) 
    {
      out[k] = in1[i]
      i = i+1
    } 
    else #otherwise add in2 value to the output and increment in2 index
    {
      out[k] = in2[j]
      j = j+1          
    }
  }
  
  return(out)
}

#Assignment1 - Function for binning the data in 'x' with intervals specified by 'bins'
bin.data <- function(x,bins)
{
  if ( !is.vector(x) )  { stop('x argument is not a vector') }
  if ( !is.vector(bins) )  { stop('bins argument is not a vector') }
  if ( !is.numeric(x) ) { stop('x argument is not a numeric vector') }
  if ( !is.numeric(bins) ) { stop('bins argument is not a numeric vector') }
  
  out = numeric(length(bins)+1)  #output vector to be returned
  n = 1  #index for output vector
  
  if(length(bins) > 0)
  {
    #sortedbins = sort(bins)
    if(is.unsorted(bins))
    {
      stop('Bins are unsorted. Bins should be increasing as per pre-requisites of this function')
    }
    
    for(i in 1:(length(bins)+1)) #i is the index for bins
    {
      #For the first bin item, the boundary is less than or equal to the bin value
      if(i == 1)
      {
        out[n] = sum(x <= bins[i])
        n = n + 1
      }
      
      #For the last bin item, the boundary is greater than the bin value
      if(i == (length(bins)+1))
      {
        out[n] = sum(x > bins[i-1])
        n = n + 1
      }
      
      #For any other intermediate bin items, the boundary is [previous bin value] < x[i] <= [Current bin value]
      if(i != 1 && i != (length(bins)+1))
      {
        out[n] = sum(x > bins[i-1] & x <= bins[i])
        n = n + 1
      }
    }
  }
  return(out)
}
