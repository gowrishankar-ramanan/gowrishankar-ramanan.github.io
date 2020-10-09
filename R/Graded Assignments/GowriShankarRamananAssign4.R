name = "Gowri Shankar Ramanan"

#Assignment4 - function for detecting mis-classification
#Input parameter 'p' represents an input numeric matrix containing the series of x,y point co-ordinates
#Input parameter 'class.v' represents the list of numeric classifications for each point co-ordinate in the p matrix
#The length of class.v vector should thus be equal to the number of (x,y) co-ordinates in the p matrix
detect.misclass <- function(class.v,p)
{
  if ( !is.vector(class.v) )  { stop('argument class.v should be a numeric vector') }
  if ( !is.matrix(p) )  { stop('argument p should be a numeric matrix') }
  if ( !is.numeric(class.v) ) { stop('argument class.v should be a numeric vector') }
  if ( !is.numeric(p) ) { stop('argument p should be a numeric matrix') }
  if (length(class.v) == 0 || length(p) == 0) { stop('input arguments cannot be empty') }
  n = nrow(p) #n stores the number of rows in the p matrix
  if (length(class.v) != n) { stop('The length of class.v argument should be equal to number of rows in input matrix p') }
  #if(class.v < 0) { stop('argument x should not have negative integers') }
  #if(p < 0) { stop('argument y should not have negative integers') }
  
  #new.class.v stores the new classifications for all observations for easy compare
  #temp.new.class stores the new classifications for just those which are misclassified
  new.class.v = class.v
  temp.new.class = numeric()
  
  #Use the k nearest neighbors algorithm to find if each point is a fit or misclassified
  #Initial value of k is assumed to about 70% of the total number of rows in p matrix
  k = round((0.7*n), digits = 0)
  
  #Create a loop to iterate through each point (x,y) co-ordinates in the p matrix
  #This loop is used to calculate the k-nearest neighbors for each 'i'th row in p matrix with length of n rows
  for(i in 1:n)
  {
    #The temp matrix has the same number of rows as p
    #However temp matrix replicates the same point on each 'i'th row of the matrix
    temp <- matrix(rep(p[i,],n), nrow = n, byrow = TRUE)

    #The euclidean distance of the current point from each of the other points is calculated below
    dist_vector = rowSums((p - temp)^2)
    #print(dist_vector)

    #Sort the distance vector in ascending order from shortest to largest
    #sorted vector will just have k number of item for k nearest neighbors
    dist_vector_sorted = sort(dist_vector)[1:k]
    #print(dist_vector_sorted)
    
    #knclass stores the current classifications for each k nearest neighbor
    knclass = numeric()
    
    #This loop is to construct the jth observed classifications (knclass) for each k nearest neighbors
    #Initial value of j is 1 for the first nearest neighbor
    j = 1
    while (j <= k)
    {
      #get the index/location of the jth nearest euclidean distance
      #remember that there can be multiple points lying in the same exact distance
      index = which(dist_vector == dist_vector_sorted[j])
      
      #if length of number of elements falling in the next nearest location is more than one
      #and the number of elements in the index exceeds the k numbers
      if(length(index) > (k-j)+1)
      {
        #Then get only the indices upto k. we can ignore the rest as it exceeds k numbers
        index = index[1:((k-j)+1)]
      }
      
      #get the classification from class.v associated with that index of kth neighbor
      knclass = c(knclass, class.v[index])
      
      #increment the j index to the next nearest neighbor index which is yet to be found
      j = j + length(index)
    }

    #If most of the k neighbors are classified as "1",
    if(length(which(knclass == 1)) > length(which(knclass == 2)))
    {
      #Then the current point co-ordinate can be safely classified as "1"
      new.class.v[i] = 1
    } #Else If most of the k neighbors are classified as "2",
    else if(length(which(knclass == 1)) < length(which(knclass == 2)))
    {
      #Then the current point co-ordinate can be safely classified as "2"
      new.class.v[i] = 2
    }

    #If the k is even, and there are equal number class 1s and 2s (equally probable case)
    #Then the new classification stays the same as the old classification for the current point
  }
  
  #misclassification_report is a vector which stores whether each class in class.v is misclassified or not
  misclassification_report = new.class.v != class.v
  
  #If there is atleast one misclassfication in misclassification_report
  if(length(which(misclassification_report == TRUE)) >= 1)
  {
    #Then set the err.found to "TRUE" and store the index of misclassification in err.loc
    #err.found is a logical value that indicates whether a misclassification is identified or not
    #err.loc is a vector containing the indices of the misclassified observations in original class.v
    #temp.new.class is a vector that contains the new corrected classification for the misclassified observation
    err.found = TRUE
    err.loc = which(misclassification_report == TRUE)
    temp.new.class = new.class.v[which(misclassification_report == TRUE)]
  }
  else
  {
    #Otherwise there is no misclassification identified
    #So, set the err.found to "FALSE" and err.loc to NULL and temp.new.class is set to NULL as well
    err.found = FALSE
    err.loc = NULL
    temp.new.class = NULL
  }

  #Construct the result list with the following, which is to be returned by the function
  #1. err.found is a logical value that indicates whether a misclassification is identified or not
  #2. err.loc is a vector containing the indices of the misclassified observations
  #3. new.class is a vector that contains the corrected classification for misclassified observations
  final_list = list(err.found = err.found, err.loc = err.loc, new.class = temp.new.class)
  
  return(final_list)
}


#x = c(2,1,4,5,8,3,6,2,4,5,7,5)
#y = c(5,3,8,1,6,6,4,8,3,5,4,9)
#x = c(6,9)
#y = c(4,4)
#p = cbind(x,y)
#print(p)
#class.v = c(1,2,2,1,1,2,1,2,1,2,2,1)
#class.v = c(1,2)
result = detect.misclass(class.vec, p)
print(result)
class.newversion                 = class.vec   # temporary
class.newversion[result$err.loc] = result$new.class  # make corrections
class.newversion