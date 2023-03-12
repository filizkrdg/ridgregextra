# ridgregextra: An R package for ridge regression parameter estimation

- This package includes a procedure finding the ridge parameter value k which makes the VIF values closest to 1 while keeping them above 1 as in Kutner et al. (2004). The package which also includes the ridgereg_k function, presents a system that automatically determines the k value in a certain range and gives the ridge regression results. It gives ridge regression tables (VIF, MSE, R2, Beta, Stdbeta) provided by the vif_k function for k ridge parameter values generated between certain lower and upper bound values. In addition, the ridge_reg function provides users the ridge regression results for a manually entered k value. Finally it shows three sets of graphs consisting k versus VIF values,  regression coefficents and standard errors of them.
- This package was presented for the first time in "Why R? Turkey 2022" conference.

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


## Citation

- Kutner, M.H., Nachtsheim, C.J., Neter, J., Li, W., 2004, Applied Linear Statistical Models.
- F. Karadağ and H.S. Sazak, “R Algorithm for Ridge Parameter Estimation in Ridge Regression” Why R? Turkey 2022 Conference, online, Verbal, Summary Text, pp.13, 2022. (https://www.nobelyayin.com/why-r-turkiye-2022-konferansi-18447.html)

