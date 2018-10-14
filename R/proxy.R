library(devtools)
install_github("llamallamagirl/PowerTOST")

proxy <- function(data) {
    result <- list
    for (o in list(data)) {
      result <- c(list(do.call(o$method, o), result))
    }
    return(result)
}
