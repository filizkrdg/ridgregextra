
#' Ridge regression results with an automatically selected k value
#'
#' @name ridgereg_k
#'
#' @description Ridge regression with a selected k value
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
#' @import isdals
#' @import mctest
#' @import plotly
#' @importFrom plotly layout
#' @importFrom stats pf sd
#'
#' @examples
#' library("mctest")
#' x <- Hald[,-1]
#' y <- Hald[,1]
#' ridgereg_k(x,y,a=0,b=1)
#'
#' library(isdals)
#' data(bodyfat)
#' x <- bodyfat[,-1]
#' y <- bodyfat[,1]
#' ridgereg_k(x,y,a=0,b=1)

ridgereg_k <- function(x,y,a,b) {
  
  if ((a>b) | (a<0) | (b>1)){
    message('Wrong input, please try again!')
    return(ridgereg_k) }
    
  if ((is.vector(x)) ) {
    message('Dimension of explanatory variables is not suitable')
    return(ridgereg_k) }
        
   if (dim(x)[2]<=1) {
     message('Dimension of explanatory variables is not suitable')
     return(ridgereg_k)
        
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
      
    }
    
    kk <- k[i-1]
  }
  
  ridgereg <- ridge_reg(x,y,k[i-1])
  ridgereg$k=k[i-1]
  last_k=ridgereg$k
  
  k_vif=vif_k(x,y,0,last_k)$k_vif
  k_beta=vif_k(x,y,0,last_k)$k_beta
  k_stdbeta =vif_k(x,y,0,last_k)$k_stdbeta

  vif_plot <- plot_ly(k_vif, x= ~k)
  ridgetrace_plot = plot_ly(k_beta, x= ~k)
  stdbeta_plot = plot_ly(k_stdbeta, x= ~k)
  
  for(i in 2:dim(k_vif)[2])
  {
    ktrace_name <- paste("Vif.x",i-1,sep="")
    dfk <- data.frame(vif=k_vif[,i], k=k_vif$k)
    vif_plot <-vif_plot %>% add_trace(data = dfk, y = ~vif, x = ~k,name = ktrace_name,mode='lines+markers')
    
    betatrace_name = paste("beta",i-1,sep="")
    dfk_beta = data.frame(Beta=k_beta[,i], k=k_beta$k)
    ridgetrace_plot =  ridgetrace_plot %>% add_trace(data = dfk_beta, y = ~Beta, x = ~k,name = betatrace_name,mode='lines+markers')
    
    stdbetatrace_name = paste("stdbeta.x",i-1,sep="")
    dfk_stdbeta = data.frame(StdBeta=k_stdbeta[,i], k=k_stdbeta$k)
    stdbeta_plot = stdbeta_plot %>% add_trace(data = dfk_stdbeta, y = ~StdBeta, x = ~k,name = stdbetatrace_name,mode='lines+markers')
  }
  fig <- subplot(vif_plot, ridgetrace_plot, stdbeta_plot, titleX = TRUE, titleY = TRUE, nrows = 3) %>% 
    layout(title = "vif & Ridge trace & stdbeta",
           plot_bgcolor='#e5ecf6', 
           xaxis = list( 
             zerolinecolor = '#ffff', 
             zerolinewidth = 2, 
             gridcolor = 'ffff'), 
           yaxis = list( 
             zerolinecolor = '#ffff', 
             zerolinewidth = 2, 
             gridcolor = 'ffff'))
  
  final_list <- list(ridgereg,fig)
  names(final_list) <- c("ridge_reg_results","graph")
  
  return(final_list)
}
