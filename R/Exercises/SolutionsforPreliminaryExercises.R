########################################################################
#
#        Preliminary R Exercises
#
#########################################################################

# 1     Find locations where vector value is greater than 10

#      input:     numeric vector v
#      output:    numeric vector loc.gt.10, which contains locations in
#                                           v where the value exceeds 10
#      Note: If no entry in v exceeds 10 then loc.gt.10 is a vector with
#            0 length.

{ # syntax
n         = length(v)
loc.gt.10 = numeric(n)
count     = 0              # counts number of values in v exceeding 10
                           # increment before storing location
if ( n > 0 )
  {                # vector length exceeds 0
    for ( i in 1:n )
      {                #   for i loop
        if ( v[i] > 10 )
          {              # save location
            count            = count + 1
            loc.gt.10[count] = i
          }              # save location
      }                #   for i loop
  }                # vector length exceeds 0

if ( count > 0 )
  {
    loc.gt.10 = loc.gt.10[1:count]
  }

} # syntax

###################  vectorized  ##########################

loc.gt.10 = which(v > 10)


# 2           Find if a vector is symmetric

#      input     v,             a numeric vector
#      output    is.symmtric    a logical value

#      if v has length 0 is.symmetric = NULL

{ # syntax
n = length(v)
m = n %/% 2
if ( m == 0 ) { m = 1 }  # take care of n = 1 case

is.symmetric = NULL
if ( n > 0 )
  {                #  length of vector exceeds 0

         # for loop checks first against last, then
         # second agains next-to-last, etc.
    is.symmetric = TRUE
    for ( i in 1:m )
      {               # for i loop
        if ( v[i] != v[n+1-i] )
          {
            is.symmetric = FALSE
            break
          }
      }               # for i loop  
  }                #  length of vector exceeds 0
} # syntax


#########   vectorized   ####################

#   here we ignore case of length 0 vector

is.symmetric = max(abs(v - v[length(v):1])) == 0



# 3        Find if a numeric value is integer-valued

#        input v      vector of length 1

v == trunc(v)

# or

v == floor(v)

# 4      Determine fractional part of number.


( frac.part = abs(v) - floor(abs(v)) ) 

# 5     Does #4 work for a vector? yes.

# 6     Give the location of the maximum value of x

#       input x,     a vector
#       output max.loc    x[max.loc] will contain the max value of x
#       if length(x) is 0, max.loc is NULL

n = length(x)
max.loc = NULL
max.val = -Inf

i = 1
while( i <= n )
  {              # while loop
     if ( x[i] > max.val )
       {            # update max
         max.loc = i
         max.val = x[i]
       }            # update max
     i = i + 1
  }              # while loop

# 7    Given a ve4ctor x, determine if it is in acending sorted order

#      input:   x       a vector

#      output:   is.sorted   a logical value


n = length(x)

is.sorted = NULL                     # need for lnegth(x) is 0 case

if ( n == 1 ) { is.sorted = TRUE }   #take care of corner case
if ( n > 1 )
  {                 # vector is not empty
    is.sorted = TRUE
    for ( i in 2:length(x) )
      {                # look for out of order pair
        if ( x[i] < x[i-1] )
          {
            is.sorted = FALSE
            break
          }
      }                # look for out of order pair 
  }                 # vector is not empty

###    vector version

n = length(x)
is.sorted = NULL                     # need for lnegth(x) is 0 case
if ( n == 1 ) { is.sorted = TRUE }   #take care of corner case

is.sorted = !any(diff(x) < 0)

#    or

is.sorted = all(diff(x) >= 0)

#   or

is.sorted = min(diff(x)) >= 0

# 8    calculate n!

n.factorial = 1

i = 1

while( i <= n )
  {
    n.factorial = i*n.factorial
    i           = i + 1
  }

#    vectorize

factorial(n)

# 9     Cumulative sum of x



####    bad way

n = length(x)

cumulative.sum = numeric(n)
if ( n > 0 )
  {
    for ( i in 1:n )
      {                 # calculate cumulative.sum[i]
        cumulative.sum[i] = 0
        for ( j in 1:i )
          {                        # for j loop
            cumulative.sum[i] = cumulative.sum[i] + x[j]
          }                        # for j loop
      }                  # calculate cumulative.sum[i]
  }

#####    better


n = length(x)

cumulative.sum = numeric(n)
if ( n == 1)  { cumulative.sum = x }
if ( n > 1 )
  {
    cumulative.sum[1] = x[1]
    for ( i in 2:n )
      {                 # calculate cumulative.sum[i]
        cumulative.sum[i] = cumulative.sum[i-1] + x[i]
      }                  # calculate cumulative.sum[i]
  }

#  vectorize

cumulative.sum = cumsum(x)

# 10      finite geomtric series  #############################

#     fiven a,r,n

#   assume n > 0

geom.sum = 0
r.vec    = r^(0:(n-1))  # 1,r,r^2, ... , r^(n-1)

###   forward addition
for ( i in 1:n)
  {
     geom.sum = geom.sum + r.vec[i]
  }
geom.sum = a*geom.sum

###   backward addition
geom.sum = 0
for ( i in n:1)
  {
     geom.sum = geom.sum + r.vec[i]
  }
geom.sum = a*geom.sum


#  vectorize

geom.sum.1 = a*sum( r^(0:(n-1)) )


geom.sum.2 = a*sum( r^((n-1):0) )


#  if you know your math

{ # syntax
if ( r == 1 )
  {
    geom.sum = a*n
  }
else
  {
    geom.sum = a*(1-r^n)/(1-r)
  }
} # syntax


# 11     pairwise max

#      given x,y
#      output z where z[i] = max(x[i],y[i])

#      we assume x,y have equal length

n = length(x)

z = x
for ( i in 1:n )
  {
     if ( y[i] > z[i] )
       {
          z[i] = y[i]
       }
  }

# vectorize

z = x*(x>y) + y*(x<=y)

# or

z = pmax(x,y)

# 12     given p,q,r determine which of q and r is closest to p.

#   calculate squared distance for p to q and p to r
d.pq = sum((p-q)^2)
d.pr = sum((p-r)^2)

{ # syntax
if ( d.pq < d.pr )
  {
    cat('q is closer to p.\n')
  }
else
  {
    if ( d.pq == d.pr )
      {
        cat('q and r are equally close to p.\n')
      }
    else
      {
        cat('r is closer to p.\n')
      }
  }
} # syntax

#  Calculate area of triangle formed by p,q,r

tol = 1.0e-10                # for testing collinearity
a   = sqrt(sum( (r-p)^2 ))
b   = sqrt(sum( (q-p)^2 ))
c   = sqrt(sum( (q-r)^2 ))

d  = sort(c(a,b,c))
if ( (d[1] + d[2] - d[3]) < d[3]*tol )
  {
    cat('Warning: p,q, and r are numerically collinear.\n')
  }

# Use Heron's Formula

s = (a+b+c)/2

area = sqrt( s*(s-a)*(s-b)*(s-c) )


#   Use linear algebra

#   translate


u = q - p
v = r - p

norm.v = sqrt(sum(v*v))
v.normalized = v/norm.v

u.parallel.v     = sum(u*v.normalized)
u.perp.v         = u - u.parallel.v*v.normalized
norm.u.perp.v    = sqrt(sum(u.perp.v*u.perp.v))

area2            = 0.5*norm.v*norm.u.perp.v

#