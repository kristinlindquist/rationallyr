library(jsonlite)
library(PowerTOST)

proxy <- function(object) {
    result <- lapply(
      split(data, 1:nrow(object$data)),
      function(r) unbox(docall(object$method, r))
    )
    return(unname(result))
}

docall <- function(method, row) {
  row[!grepl("method",unlist(row))]
  row[["power"]] <- do.call(method, row)
  return(row)
}
