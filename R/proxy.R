library(devtools)
install_github("llamallamagirl/PowerTOST")
install_github("renkun-ken/rlist")
library(rlist)

proxy <- function(method, data) {
    result <- list
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) docall(method, r)
    )
    return(result)
}

docall <- function(method, row) {
  return c(list(data), do.call(method, row))
}
