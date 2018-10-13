library(devtools)
install_github("llamallamagirl/PowerTOST")
library(pwr)
library(PowerTOST)

.proxy <- function(vars, powerMethod) {
    result <- list
    for (o in list(vars)) { result <- c(list(powerMethod), result) }
    return(result)
}
