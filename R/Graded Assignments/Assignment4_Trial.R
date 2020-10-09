name = "Gowri Shankar Ramanan"

#Assignment4 - function for detecting mis-classification
detect.misclass <- function(class.v,p)
{
  if ( !is.vector(class.v) )  { stop('argument class.v should be a numeric vector') }
  if ( !is.matrix(p) )  { stop('argument p should be a numeric matrix') }
  if ( !is.numeric(class.v) ) { stop('argument class.v should be a numeric vector') }
  if ( !is.numeric(p) ) { stop('argument p should be a numeric matrix') }
  if (length(class.v) == 0 || length(p) == 0) { stop('input arguments cannot be empty') }
  n = nrow(p) #n stores the number of rows in the p matrix
  if (length(class.v) != n) { stop('The length of class.v argument should be equal to number of rows in input matrix p') }
  #if(x < 0) { stop('argument x should not have negative integers') }
  #if(y < 0) { stop('argument y should not have negative integers') }

  #dist <- matrix(0, nrow = nrow(p), ncol = nrow(p))
  
  new.class = class.v
  k = round((0.7*n), digits = 0)
  #if(k%%2 == 0)
  #{
  #  k = k+1
  #}
  print(k)
  # for(i in 1:nrow(p))
  # {
  #   print(p[i,])
  #   temp <- matrix(rep(p[i,],n), nrow = n, byrow = TRUE)
  #   print(temp)
  #   dist[i,] = rowSums((p-temp)^2)
  #   print(rowSums((p-temp)^2))
  # }
  for(i in 1:n)
  {
    #print(p[i,])
    temp <- matrix(rep(p[i,],n), nrow = n, byrow = TRUE)
    #print(temp)
    #dist[i,] = rowSums((p-temp)^2)
    dist_vector = rowSums((p-temp)^2)
    #print("Distance Vector:")
    #print(dist_vector)
    #print(dist)
    #dist_vector_sorted = sort(dist_vector)[1:k]
    dist_vector_sorted = sort(dist_vector)[1:k]
    #print(dist_vector_sorted)
    knindices = numeric()
    knclass = numeric()
    for (j in 1:k)
    {
      #print(i)
      #print("Point:")
      #print(p[which(dist_vector == dist_vector_sorted[j]),])
      #print("Classification:")
      #print(class.v[which(dist_vector == dist_vector_sorted[j])])
      knindices = c(knindices, which(dist_vector == dist_vector_sorted[j])[1])
      knclass = c(knclass, class.v[which(dist_vector == dist_vector_sorted[j])[1]])
    }
    #print("KN Indices:")
    #print(knindices)
    #print("KN Classifications:")
    #print(knclass)
    if(length(which(knclass == 1)) > length(which(knclass == 2)))
    {
      new.class[i] = 1
      #wrong_class = 2
      #wrong_class_indices = knindices[which(knclass == 2)]
    }
    else if(length(which(knclass == 1)) < length(which(knclass == 2)))
    {
      new.class[i] = 2
      #wrong_class = 1
      #wrong_class_indices = knindices[which(knclass == 1)]
    }
    #print("Wrong Classification:")
    #print(wrong_class)
    #print(wrong_class_indices)
    #print(p[wrong_class_indices,])
    #knclasstable <- table(knclass)
    #print(knclasstable)
    #print(which(dist_vector == dist_vector_sorted))
  }
  
  #print(class.v)
  #print(new.class)
  misclassification_report = new.class != class.v
  #print(misclassification_report)
  if(length(which(misclassification_report == TRUE)) >= 1)
  {
    err.found = TRUE
    err.loc = which(misclassification_report == TRUE)
  }
  else
  {
    err.found = FALSE
    err.loc = 0
  }

  #print(err.found)
  #print(err.loc)
  result = list(err.found, err.loc, new.class)
  #print(result)
  return(result)
}


#x = c(2,1,4,5,8,3,6,2,4,5,7,5)
#y = c(5,3,8,1,6,6,1,8,3,5,4,9)
x = c(6,9)
y = c(4,4)
p = cbind(x,y)
print(p)
#class.v = c(1,2,2,1,1,2,1,2,1,2,2,1)
class.v = c(1,2)
detect.misclass(class.v, p)