library(devtools)
install_github("llamallamagirl/PowerTOST")
install_github("renkun-ken/rlist")
library(rlist)

proxy <- function(method, data) {
    result <- list
    result <- list(lapply(
      split(data, 1:nrow(data)),
      function(r) docall(method, r)
    ), result)
    return(result)
}

docall <- function(method, row) {
  power <- do.call(method, row)
  return(c(row, c(power=power)))
}
