library(jsonlite)
library(PowerTOST)
library(powerlmm)

proxy <- function(method, data) {
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) unbox(docall(method, r))
    )
    return(unname(result))
}

docall <- function(method, row) {
  power <- do.call(method, row)
  if (typeof(power) == 'list' || typeof(power) == 'S4') {
    row[["power"]] <- power$power
  } else {
    row[["power"]] <- power
  }
  return(row)
}

powerlmmProxy <- function(method, data) {
  p <- proxy("study_parameters", data.params)
  return(proxy("get_power", c(data.data, p = p)))
}
