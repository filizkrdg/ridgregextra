ridgereg_k <- function(x,y,a,b) {
  
  if ((a>b) | (a<0) | (b>1)){
    print('Wrong input, please try again!')
    return(ridgereg.k)
    #TODO: Add checking for dimension of X. if it is less than 2, dont proceed with
    # the calculations.
    
  } else {
    
    for (j in 1:4) {
      k <- seq(a,b,length=11)
      v <- matrix(0,11,dim(x)[2])
      
      for (i in 1:11) {
        
        VIF <- ridge_reg(x,y,k[i])$VIF
        diagVIF <- as.matrix(diag(VIF))
        tdiagVIF <- t(diagVIF)
        
        if (min(tdiagVIF)>1) {
          
          v[i,] <- tdiagVIF[1,]
          
        } else {
          
          break
        }
      }
      
      
      b <- k[i]
      a<-k[i-1]
      k <- as.matrix(k)
      # print(cbind(k,v))
      
    }
    
    kk <- k[i-1]
    print(c(kk,v[i-1,]))
  }
  
  ridgereg <- ridge_reg(x,y,k[i-1])
  ridgereg$k=k[i-1]
  
  return(ridgereg)
}