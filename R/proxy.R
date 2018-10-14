library(devtools)
install_github("llamallamagirl/PowerTOST")
install_github("renkun-ken/rlist")
library(rlist)

proxy <- function(method, data) {
    result <- list
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) do.call(method, r)
    )
    return(result)
}
