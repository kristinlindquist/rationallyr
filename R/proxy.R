library(jsonlite)
library(PowerTOST)


proxy <- function(method, data) {
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) unbox(docall(method, r))
    )
    return(unname(result))
}

docall <- function(method, row) {
  row[!grepl("method",unlist(row))]
  row[["power"]] <- do.call(method, row)
  return(row)
}
