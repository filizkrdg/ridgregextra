# ridgregextra: An R package for ridge regression parameter estimation

- The package includes ridge regression tables (VIF, MSE, R2, Beta, Stdbeta) provided by the vif_k function for k ridge parameter values generated between certain lower and upper bound values. In addition, the ridge_reg function provides users the ridge regression results for a manually entered k value. This package which also includes the ridgereg_k function, presents a system that automatically determines the k value in a certain range and gives the ridge regression results.

## Installing the package using Github Desktop (Recomended)

Only follow the steps below at the first step

- Please install Github Desktop (https://desktop.github.com/)
- Clone the repository
- Open the project in RStudio

Next time,
- Please open Github Desktop and click "Fetch".
- If the repo is updated, you will see information. In this case please click "Pull" button.
- Finally please run following command.

```
devtools::load_all()
```


## Example usage of the package.

You can use `isdals` package to have example data to test `ridgregextra` package. Please make sure that you installed the package.

- Prepare the dataset  

```
library(isdals)
data(bodyfat)
x=bodyfat[,-1]
y=bodyfat[,1]
```  

- Run ` ridgereg_k`  function to get coefficients by using alternative approach to traditional ridge regression techniques.

```
ridgereg_k(x,y,0,1)

```

You can use `mctest` package to have example data to test `ridgregextra` package. Please make sure that you installed the package.

- Prepare the dataset  

```
library("mctest")
x=Hald[,-1]
y=Hald[,1]
```  

- Run ridgereg_k function to get coefficients by using alternative approach to traditional ridge regression techniques.

```
ridgereg_k(x,y,0,1)
```
