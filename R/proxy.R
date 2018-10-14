library(devtools)
library(jsonlite)
install_github("llamallamagirl/PowerTOST")

proxy <- function(method, data) {
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) unbox(docall(method, r))
    )
    return(unname(result))
}

docall <- function(method, row) {
  row[["power"]] <- do.call(method, row)
  return(row)
}
