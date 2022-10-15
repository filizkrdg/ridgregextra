vif_k<- function(x,y,a,b) {
  
  if ((a>b) | (a<0) | (b>1)){
    print('Wrong input, please try again!')
    
    return(vif.k)
    
  } else {
    
    k1 <- seq(a,b,length=11)
    k <- as.matrix(k1)
    
    v <- matrix(0,11,dim(x)[2])
    
    all_results <- NULL
    for (i in 1:11) 
      {
      
      VIF <- ridge_reg(x,y,k[i])$VIF
      diagVIF <- as.matrix(diag(VIF))
      tdiagVIF <- t(diagVIF)
      v[i,] <- tdiagVIF[1,]
    }
    
    k_v <- as.data.frame(cbind(k,v))
    colnames(k_v) <- c("k",paste("VIF.", colnames(x),sep=""))
  
    bar_plot <- plot_ly(type = 'bar')

    for(i in 2:dim(k_v)[2])
    {
      dfk <- data.frame(y=k_v[,i], k=k_v$k)
      bar_plot <- bar_plot %>% add_trace(data = dfk, y = ~y,x = ~k,name = colnames(k_v)[i])
    }
  }
  bar_plot <- bar_plot %>% layout(yaxis = list(title = 'k'), barmode = 'group')
  print(bar_plot)
  return(k_v)
}