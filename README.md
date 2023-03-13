# ridgregextra: An R package for ridge regression parameter estimation

`ridgregextra` focuses on finding the ridge parameter value k which makes the VIF values closest to 1 while keeping them above 1 as stressed "Applied Linear Statistical Models" (Kutner et al., 2004). The package includes the `ridgereg_k` function, presents a system that automatically determines the k value in a certain range defined by the user and provides detailed ridge regression results. `ridgereg_k` also provides ridge regression tables (VIF, MSE, R2, Beta, Stdbeta) using `vif_k` function for k ridge parameter values generated between certain lower and upper bound values. 

In addition, the `ridge_reg` function provides users the ridge regression results for a manually entered k value. Finally `ridgregextra` provides three sets of graphs consisting k versus VIF values,  regression coefficents and standard errors of them.

`ridgregextra` was presented for the first time in "Why R? Turkey 2022" conference.

## Installing `ridgregextra`

Please make sure that you installed `devtools` package.


```
devtools::install_github(filizkrdg/ridgregextra)
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


## References

- Kutner, M.H., Nachtsheim, C.J., Neter, J., Li, W., Applied Linear Statistical Models, pp.430-440, 2004.
- Karadağ, F. and Sazak, H.S., “R Algorithm for Ridge Parameter Estimation in Ridge Regression” Why R? Turkey 2022 Conference, online, Verbal, Summary Text, p.13, 2022. (https://www.nobelyayin.com/why-r-turkiye-2022-konferansi-18447.html)

## Contact

For any questions please contact:

- Filiz Karadag, filiz.karadag@ege.edu.tr
- Hakan Savas Sazak, hakan.savas.sazak@ege.edu.tr
- Olgun Aydin, olgun.aydin@pg.edu.pl

