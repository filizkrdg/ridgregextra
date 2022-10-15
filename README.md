# Ridge_Reg


## Installing package directly from Github

- Please make sure that devtools package is installed.
- Since this repo is private, you need to create personal token to install the package directly from Github.
- To get personal access token, please follow the setups shown here. visit this url: https://github.com/settings/tokens
- After creating the token, use following command to install the package directly from Github.

```
devtools::install_github("filizkrdg/Ridge_Reg",
                          ref="main",
                          auth_token = "your_access_token"
                          )
library(Ridge_Reg)                          
                        
```


## Installing the package using Github Desktop (Recomended)

- Please install Github Desktop (https://desktop.github.com/)
- Clone the repository
- Open the project in RStudio
- Run the following command

```
devtools::load_all()
```
- Now, its ready to use.

## Example usage of the package.

- TBA