
#' Ridge regression tables in the range of given lower and upper bounds of k values
#'
#' @name vif_k
#'
#' @description Ridge regression tables in the range of given lower and upper bounds of k values
#'
#' @param x Explanatory variables (Dataframe, matrix)
#' @param y Dependent variables (Dataframe, vector)
#' @param a Lower bound of k
#' @param b Upper bound of k
#' 

#'
#' @return A list of lists
#' @export
#'
#' @examples
#' library("mctest")
#' x <- Hald[,-1]
#' y <- Hald[,1]
#' vif_k(x,y,a=0,b=1)
#'
#' library(isdals)
#' data(bodyfat)
#' x <- bodyfat[,-1]
#' y <- bodyfat[,1]
#' vif_k(x,y,a=0,b=1)

vif_k<- function(x,y,a,b) {
  
  if ((a>b) | (a<0) | (b>1)){
    message('Wrong input, please try again!')
    
    return(vif_k)
    
  } else {
    
    k1 <- seq(a,b,length=11)
    k <- as.matrix(k1)
    v <- matrix(0,11,dim(x)[2])
    R2=matrix(0,11,1)
    betaa=matrix(0,11,(dim(x)[2]))
    stdbetaa=matrix(0,11,(dim(x)[2]))
    mse=matrix(0,11,1)
    
   # all_results <- NULL
    for (i in 1:11) 
      {
      
      VIF <- ridge_reg(x,y,k[i])$VIF
      diagVIF <- as.matrix(diag(VIF))
      tdiagVIF <- t(diagVIF)
      v[i,] <- tdiagVIF[1,]
      
      R2[i]<- ridge_reg(x,y,k[i])$R2
      beta <- ridge_reg(x,y,k[i])$beta
      stdbeta = ridge_reg(x,y,k[i])$stdbeta
      stdbeta = as.matrix(stdbeta)
      tbeta=t(beta)
      tstdbeta=t(stdbeta)
      
      betaa[i,]=tbeta[1,]
      stdbetaa[i,] = tstdbeta[1,]
   
      mse[i] <- ridge_reg(x,y,k[i])$MSE
      
    }
    colnames(v)=paste("vif.x",1:dim(x)[2],sep="")
    colnames(betaa)=paste("beta",1:dim(x)[2],sep="")
    colnames(stdbetaa)=paste("stdbeta",1:dim(x)[2],sep="")
    k=data.frame(k)
    v=data.frame(v)
    R2=data.frame(R2)
    mse=data.frame(mse)
    betaa=data.frame(betaa)
    stdbetaa=data.frame(stdbetaa)
    
    viftable = as.data.frame.array(cbind(k,v,mse,R2))
    betatable=as.data.frame.array(cbind(k,betaa))
    stdbetatable=as.data.frame.array(cbind(k,stdbetaa))
    
    mse = viftable[,(dim(x)[2]+2)]
    
    k_vif = as.data.frame.array(viftable[,1:(dim(x)[2]+1)])
    k_beta = betatable
    k_stdbeta = stdbetatable
    k_mse=as.data.frame((cbind(k,mse)))
    
  }

  z <- list(viftable = viftable,
            k_vif=k_vif,k_mse=k_mse, k_beta= k_beta,k_stdbeta=k_stdbeta)
  return(z)
}
   
