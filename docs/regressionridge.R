# Written by Filiz Karadag, Ege University, Dept. of Statistics,
# Izmir,Turkey.

# Ridge regression
Ridge.reg <- function(x,y,c) {
  
  dimx <- dim(x)
  n <- dimx[1]
  p <- dimx[2]
  
  yr <- scale(y)/sqrt(n-1)
  xr <- scale(x)/sqrt(n-1)
  X <- xr
  XpX <- t(X)%*%X
  XpXplusc <- XpX+c*diag(p)
  
  Xpy <- t(X)%*%yr
  p1 <- qr(XpX)$rank-1
  
  invXpXplusc <- solve(XpXplusc)
  beta <- invXpXplusc%*%Xpy
  
  tsdx <- apply(x,2,sd)
  betaor <- sd(y)*beta/as.matrix(tsdx)
  beta0 <- c(mean(y),apply(x,2,mean))%*%rbind(1,-betaor)
  betaor <- rbind(beta0,betaor)
  yhator <- cbind(matrix(1,n),x)%*%betaor
  
  yhat <- X%*%beta
  e <- yr-yhat
  SSE <- t(e)%*%e
  SSE=as.numeric(SSE)
  MSE <- SSE/(n-(p+1))
  
  s1 <- 0
  
  for(i in 1:n) {
    s1 <- s1+yr[i]
  }
  
  ymeanr <- s1/n
  
  SST <- t(yr)%*%yr-n*ymeanr^2
  SST <- as.numeric(SST)
  MST <- SST/(n-1)
  
  SSR <- 1-SSE
  SSR <- as.numeric(SSR)
  MSR <- SSR/p
  R2 <- SSR/SST
  R2adj <- 1-MSE/MST
  
  F <- MSR/MSE
  sig <- 1-pf(F,p,n-(p+1))
  
  varbeta=invXpXplusc*MSE
  stdbeta <- sqrt(diag(varbeta))
  VIF=invXpXplusc%*%XpX%*%invXpXplusc
  
  aF <- c(F,NA,NA)
  asig <- c(sig,NA,NA)
  s.v <- c("Regression","Error","Total")
  S.S <- c(SSR,SSE,SST)
  d.f <- c(p,n-(p+1),n-1)
  M.S <- c(MSR,MSE,MST)
  anovatable <- data.frame(s.v,S.S,d.f,M.S,aF,asig)
  
  
  z <- list(beta=beta,e=e,yhat=yhat,MSE=MSE,F=F,sig=sig,varbeta=varbeta,stdbeta=stdbeta,
            R2=R2,R2adj=R2adj,anovatable=anovatable,VIF=VIF,betaor=betaor,yhator=yhator)
  
  return(z)
}




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





# Ridge regression with a selected constant k

ridgereg.k <- function(x,y,a,b) {
  
  if ((a>b) | (a<0) | (b>1)){
    print('yanlis giris, tekrar calistiriniz.')
    return(ridgereg.k)
    
  } else {
    
    for (j in 1:4) {
      k <- seq(a,b,length=11)
      v <- matrix(0,11,dim(x)[2])
      
      for (i in 1:11) {
        
        VIF <- Ridge.reg(x,y,k[i])$VIF
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
  
  ridgereg <- Ridge.reg(x,y,k[i-1])
  ridgereg$k=k[i-1]
  
  return(ridgereg)
}



