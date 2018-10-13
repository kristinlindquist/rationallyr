library(devtools)
install_github("llamallamagirl/PowerTOST")
library(PowerTOST)
library(pwr)

proxy <- function(method, data) {
    result <- list
    for (o in list(data)) {
      result <- c(list(do.call(method, o), result))
    }
    return(result)
}
