library(devtools)
install_github("llamallamagirl/PowerTOST")

proxy <- function(vars) {
    result <- list
    for (o in list(vars.data)) { result <- c(list(vars.method), result) }
    return(result)
}
