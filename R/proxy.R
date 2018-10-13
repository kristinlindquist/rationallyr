library(devtools)
install_github("llamallamagirl/PowerTOST")

proxy <- function(method, data) {
    result <- list
    for (o in list(data)) { result <- c(list(get(method)), result) }
    return(result)
}
