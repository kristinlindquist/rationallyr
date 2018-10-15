library(jsonlite)
library(PowerTOST)

proxy <- function(array) {
    result <- lapply(
      split(array, 1:nrow(array)),
      function(r) unbox(docall(r$method, r))
    )
    return(unname(result))
}

docall <- function(method, row) {
  row[!grepl("method",unlist(row))]
  row[["power"]] <- do.call(method, row)
  return(row)
}
