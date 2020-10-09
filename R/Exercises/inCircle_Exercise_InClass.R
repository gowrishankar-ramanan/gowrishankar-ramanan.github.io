in.circle <- function(pts,cntr,r)
{
  ####  Graph a circle
  
  #theta = seq(0,2*pi,length = 2000)
  #theta = seq(cntr[1],cntr[2],length = r)
  #x     = cos(theta)
  #y     = sin(theta)
  #The distance between ???xc,yc??????xc,yc??? and ???xp,yp??????xp,yp??? is given by the Pythagorean theorem as
  #d=(xp???xc)2+(yp???yc)2?????????????????????????????????????????????????????????.
  #d=(xp???xc)2+(yp???yc)2.
  #The point ???xp,yp??????xp,yp??? is inside the circle if d<rd<r, on the circle if d=rd=r, and outside the circle if d>rd>r. You can save yourself a little work by comparing d2d2 with r2r2 instead: the point is inside the circle if d2<r2d2<r2, on the circle if d2=r2d2=r2, and outside the circle if d2>r2d2>r2. Thus, you want to compare the number (xp???xc)2+(yp???yc)2(xp???xc)2+(yp???yc)2 with r2r2.
  #plot(1:5,seq(1,10,length=5),type="n",xlab="",ylab="",main="Test draw.circle")
  #draw.circle(cntr[1],cntr[2],r,nv=100,border=NULL,col=NA,lty=1,density=NULL, angle=45,lwd=1)
  for (x in 1:nrow(pts))
  {
    x = pts[x,1]
    y = pts[x,2]
    print(x)
    print(y)
    d = ((x - cntr[1])^2 + (y - cntr[2])^2)^0.5
    print(d)
    if(d < r) {print("Inside Circle")}
    if(d == r) {print("On Circle")}
    if(d > r) {print ("Outside Circle")}

    #coords = pts[which(pts==i, arr.ind=TRUE)]
    #print(coords)
    #print(coords[1])
    #print(coords[2])
    #d = ((coords[1] - cntr[1])^2 + (coords[2] - cntr[2])^2)^0.5
    #print(which(pts==1, arr.ind=TRUE))
    #print(coords[1])
    #print(cntr[1])
    #print(coords[2])
    #print(cntr[2])
    #print(d)
    #if(d < r) {print("Inside Circle")}
    #if(d == r) {print("On Circle")}
    #if(d > r) {print ("Outside Circle")}
  }
  
  #dev.new()
  #plot(x,y)
  #for (x,y in pts)
  #plot()
  
}

x = 1:10
y = 101:110
#z = 201:210

pts = cbind(x,y)
pts
#pts = c(1,2)
cntr = c(1,151)
r = 50
in.circle(pts,cntr,r)