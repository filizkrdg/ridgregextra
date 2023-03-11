
#' Ridge regression results with a manually selected k value
#'
#' @name ridge_reg
#'
#' @description Ridge regression with a manually selected k value
#'
#' @param x Explanatory variables (Dataframe, matrix)
#' @param y Dependent variables (Dataframe, vector)
#' @param k Ridge parameter
#' 
#' 

#'
#' @return A list of lists
#' @export
#'
#' @examples
#' library("mctest")
#'	x <- Hald[,-1]
#'	y <- Hald[,1]
#'	k <- 0.1
#' ridge_reg(x,y,k)
#'
#' library(isdals)
#' data(bodyfat)
#' x <- bodyfat[,-1]
#' y <- bodyfat[,1]
#' k <- 0.1
#' ridge_reg(x,y,k)


ridge_reg <- function(x,y,k) {
  
  #Standard Ridge Regression
  if (is.vector(x)){
    n=length(x)
    p=1
    x=t(x)
    x=t(x)
    
  } else {
    n=dim(x)[1]
    p=dim(x)[2]
    
    if(p==1) {
      
      x=x[,1]
      x=t(x)
      x=t(x)
      
    } else {
      
      colind=2
      xx=cbind(x[,1],x[,2])
      while(colind<p) {
        colind=colind+1
        xx=cbind(xx,x[,colind])
      } 
      x=xx }
  }
  
  if (is.vector(y)){
    y=t(y)
    y=t(y)
  } else {
    cy=dim(y)[2]
    if(cy==1) {
      
      y=y[,1]
      y=t(y)
      y=t(y)
      
    } else {
      
      colind=2
      yy=cbind(y[,1],y[,2])
      while(colind<cy) {
        colind=colind+1
        yy=cbind(yy,y[,colind])
      } 
      y=yy }
  }
  x=as.matrix(x)
  y=as.matrix(y)
  
  yr <- scale(y)/sqrt(n-1)
  xr <- scale(x)/sqrt(n-1)
  X <- xr
  XpX <- t(X)%*%X
  XpXplusk <- XpX+k*diag(p)
  
  Xpy <- t(X)%*%yr
  p1 <- qr(XpX)$rank-1
  
  invXpXplusk <- solve(XpXplusk)
  beta <- invXpXplusk%*%Xpy
  
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
  
  varbeta=invXpXplusk*MSE
  stdbeta <- sqrt(diag(varbeta))
  VIF=invXpXplusk%*%XpX%*%invXpXplusk
  
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
