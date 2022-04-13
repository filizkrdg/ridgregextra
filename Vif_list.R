# VIF list for an interval (a-b)

vif.k<- function(x,y,a,b) {
  
  if ((a>b) | (a<0) | (b>1)){
    print('yanlis giris, tekrar calistiriniz.')
    
    return(vif.k)
    
  } else {
    
    k1 <- seq(a,b,length=11)
    k <- as.matrix(k1)
    
    v <- matrix(0,11,dim(x)[2])
    
    for (i in 1:11) {
      
      VIF <- Ridge.reg(x,y,k[i])$VIF
      diagVIF <- as.matrix(diag(VIF))
      tdiagVIF <- t(diagVIF)
      
      v[i,] <- tdiagVIF[1,]
      
    }
    print(cbind(k,v))
  }
}
