proxy <- function(method, data) {
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) unbox(docall(method, parseFun(r)))
    )
    return(unname(result))
}

parseFun <- function(r) {
  for (key in names(r)) {
    if (grepl("function", key)) r[key] = parse(text = r[key])
  }
  return(r)
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

powerlmmProxy <- function(params, data, ...) {
  studyParams <- do.call("study_parameters", params)
  return(do.call("get_power", list(studyParams, data)))
}
