# dry_spells.R -- five implementations of "dry spell", run on one daily rain record (S3, ch.2: definitions become operations).
# Kim + Claude, 2026-11-27. Each function is a theory of the word; all return the same table: method, start, end, days.
# Input: data.frame(date, mm) with consecutive dates. A dry day is mm < wet_mm (default 1 mm; traces are not rain).
ds_runs <- function(flag, min_len = 1) {           # runs of TRUE -> start/end indices
  flag <- as.vector(flag); flag[is.na(flag)] <- FALSE; r <- rle(flag); e <- cumsum(r$lengths); s <- e - r$lengths + 1
  k <- r$values & r$lengths >= min_len; data.frame(s = s[k], e = e[k]) }
ds_out <- function(x, ix, method) data.frame(method = rep(method, nrow(ix)), start = x$date[ix$s], end = x$date[ix$e], days = ix$e - ix$s + 1)
# 1. Strict run: a uniform condition; any wet day ends it.
ds_strict <- function(x, L = 15, wet_mm = 1) ds_out(x, ds_runs(x$mm < wet_mm, L), "strict run")
# 2. Gap tolerance: survives up to k wet days in a row, if dry on both sides.
ds_gap <- function(x, L = 15, k = 2, wet_mm = 1) {
  dry <- x$mm < wet_mm; dry[is.na(dry)] <- FALSE; w <- ds_runs(!dry); n <- length(dry)
  fill <- w$e - w$s + 1 <= k & w$s > 1 & w$e < n; for (i in which(fill)) dry[w$s[i]:w$e[i]] <- TRUE
  ds_out(x, ds_runs(dry, L), sprintf("gap tolerance (%d d)", k)) }
# 3. Hysteresis: hard to start (L dry days), easy to keep (only a rain >= exit_mm ends it).
ds_hyst <- function(x, L = 15, exit_mm = 5, wet_mm = 1) {
  n <- nrow(x); on <- FALSE; cnt <- 0; s <- e <- integer(); m <- x$mm; m[is.na(m)] <- 0
  for (i in seq_len(n)) {
    if (!on) { cnt <- if (m[i] < wet_mm) cnt + 1 else 0; if (cnt == L) { on <- TRUE; s <- c(s, i - L + 1) } }
    else if (m[i] >= exit_mm) { on <- FALSE; e <- c(e, i - 1); cnt <- 0 } }
  if (on) e <- c(e, n); ds_out(x, data.frame(s = s, e = e), sprintf("hysteresis (exit %g mm)", exit_mm)) }
# 4. Window mean: a regime -- the centered W-day total stays below a ceiling.
ds_window <- function(x, L = 15, W = 31, ceiling_mm = 10) {
  m <- x$mm; m[is.na(m)] <- 0; tot <- as.numeric(stats::filter(m, rep(1, W), sides = 2))
  ds_out(x, ds_runs(!is.na(tot) & tot < ceiling_mm, L), sprintf("window (%d-d total < %g mm)", W, ceiling_mm)) }
# 5. State model: a hidden dry regime the daily weather only partly reveals (2-state HMM on wet/dry, fitted by EM).
ds_hmm_fit <- function(o, iter = 200, tol = 1e-8) {
  n <- length(o); p <- c(0.05, 0.4); A <- matrix(c(0.97, 0.03, 0.05, 0.95), 2, byrow = TRUE); pi0 <- c(0.5, 0.5); ll0 <- -Inf
  for (it in 1:iter) {
    B <- cbind(ifelse(o, p[1], 1 - p[1]), ifelse(o, p[2], 1 - p[2])); B[is.na(o), ] <- 1
    al <- matrix(0, n, 2); cs <- numeric(n); al[1, ] <- pi0 * B[1, ]; cs[1] <- sum(al[1, ]); al[1, ] <- al[1, ] / cs[1]
    for (t in 2:n) { a <- (al[t - 1, ] %*% A) * B[t, ]; cs[t] <- sum(a); al[t, ] <- a / cs[t] }
    be <- matrix(1, n, 2); for (t in (n - 1):1) be[t, ] <- (A %*% (B[t + 1, ] * be[t + 1, ])) / cs[t + 1]
    g <- al * be; g <- g / rowSums(g)
    xi <- matrix(0, 2, 2); for (t in 1:(n - 1)) xi <- xi + (al[t, ] %o% (B[t + 1, ] * be[t + 1, ])) * A / cs[t + 1]
    A <- xi / rowSums(xi); pi0 <- g[1, ]; ok <- !is.na(o); p <- colSums(g[ok, ] * o[ok]) / colSums(g[ok, ])
    ll <- sum(log(cs)); if (abs(ll - ll0) < tol * abs(ll)) break; ll0 <- ll }
  list(p = p, A = A, pi0 = pi0, ll = ll, B = B) }
ds_viterbi <- function(f) { B <- f$B; n <- nrow(B); lA <- log(f$A); d <- matrix(0, n, 2); bp <- matrix(0L, n, 2); d[1, ] <- log(f$pi0) + log(B[1, ])
  for (t in 2:n) for (j in 1:2) { v <- d[t - 1, ] + lA[, j]; bp[t, j] <- which.max(v); d[t, j] <- max(v) + log(B[t, j]) }
  s <- integer(n); s[n] <- which.max(d[n, ]); for (t in (n - 1):1) s[t] <- bp[t + 1, s[t + 1]]; s }
ds_hmm <- function(x, L = 15, wet_mm = 1) {
  o <- x$mm >= wet_mm; f <- ds_hmm_fit(o); st <- ds_viterbi(f); dry <- which.min(f$p)
  out <- ds_out(x, ds_runs(st == dry, L), "state model (HMM)"); attr(out, "fit") <- f; out }
ds_all <- function(x, L = 15) rbind(ds_strict(x, L), ds_gap(x, L), ds_hyst(x, L), ds_window(x, L), ds_hmm(x, L))
ds_daymask <- function(x, sp) { meth <- unique(sp$method); M <- matrix(FALSE, nrow(x), length(meth), dimnames = list(NULL, meth))
  for (i in seq_len(nrow(sp))) M[x$date >= sp$start[i] & x$date <= sp$end[i], sp$method[i]] <- TRUE; M }
# Example (2026-11-27): HNL (GHCN-D USW00022521), 1974-01-10 onward (one observing site: the Observatory Annex).
