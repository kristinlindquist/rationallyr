proxy <- function(method, data) {
    result <- lapply(
      split(data, 1:nrow(data)),
      function(r) unbox(docall(method, r))
    )
    return(unname(result))
}

parseFun <- function(r) {
  for (key in names(r)) {
    if (is.na(r[[key]])) {
      next
    } else if (r[[key]] == 'fixed.effect') {
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

maybeUnbox <- function(x) {
  if(!is.null(x) && (is.atomic(x) || is.data.frame(x))  && length(dim(x)) < 2) {
    return(unbox(x))
  } else if (!is.null(x) && length(x) == 1 && length(x[[1]]) < 2) {
    return(x[[1]])
  }
  return(x)
}

docall <- function(method, row) {
  newRow <- parseFun(row)
  power <- do.call(method, newRow)
  if (typeof(power) == 'list' || typeof(power) == 'S4') {
    for (key in names(power)) {
      row[[key]] = maybeUnbox(power[key])
    }
  } else {
    row[["power"]] <- power
  }
  return(row)
}

powerlmmProxy <- function(...) {
  studyParams <- do.call("study_parameters", as.list(match.call()[-1]))
  return(do.call("get_power", list(studyParams)))
}

retro_gelman <- function(dTrue, dObserved, n, n2=0, alpha=0.05, df=Inf, n.sims=10000) {
  sed <- sqrt((n+n2)/(n*n2)+(dObserved^2)/(2*(n+n2)));
  gelman(dTrue, sed, alpha=alpha, df=df, n.sims=n.sims);
}

prospective_gelman <- function(d, n, n2=0, alpha=0.05, df=Inf, n.sims=10000) {
  if (n2 == 0) {
    n2 = n / 2;
    n = n2;
  }
  sed <- sqrt((n+n2)/(n*n2)+(d^2)/(2*(n+n2)));
  gelman(d, sed, alpha=alpha, df=df, n.sims=n.sims);
}

gelman <- function(A, s, alpha=0.05, df=Inf, n.sims=10000){
  z <- qt(1-alpha/2, df)
  p.hi <- 1 - pt(z-A/s, df)
  p.lo <- pt(-z-A/s, df)
  power <- p.hi + p.lo
  typeS <- p.lo/power
  estimate <- A + s*rt(n.sims,df)
  significant <- abs(estimate) > s*z
  exaggeration <- mean(abs(estimate)[significant])/A
  return(list(power=power, typeS=typeS, exaggeration=exaggeration))
}
