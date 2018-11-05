proxy <- function(method, data) {
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) unbox(docall(method, r))
    )
    return(unname(result))
}

parseFun <- function(r) {
  for (key in names(r)) {
    if (r[[key]] == 'fixed.effect') {
      r[key] = alist(fixed.effect)
    } else if (r[[key]] == 'random.effect') {
      r[key] = alist(random.effect)
    } else if (r[[key]] == 'weighted.crossover.cluster.level') {
      r[key] = alist(weighted.crossover.cluster.level)
    } else if (r[[key]] == 'fixed.effect.cluster.level') {
      r[key] = alist(fixed.effect.cluster.level)
    }
  }
  return(r)
}

docall <- function(method, row) {
  newRow <- parseFun(row)
  power <- do.call(method, newRow)
  if (typeof(power) == 'list' || typeof(power) == 'S4') {
    row[["power"]] <- power$power
  } else {
    row[["power"]] <- power
  }
  return(row)
}

powerlmmProxy <- function(...) {
  studyParams <- do.call("study_parameters", as.list(match.call()[-1]))
  return(do.call("get_power", list(studyParams)))
}
