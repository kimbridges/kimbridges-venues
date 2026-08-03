test_that("the SW desert trio classifies as reactive-rain arid desert", {
  # index values reproduced from WorldClim (Mojave/Chihuahuan/Sonoran)
  trio <- data.frame(
    name      = c("Las Vegas","El Paso","Tucson"),
    Tamp      = c(12.33, 10.87, 9.69),
    SI        = c(0.349, 0.583, 0.459),
    cool_frac = c(0.583, 0.257, 0.406),
    bimod     = c(0.00,  0.561, 1.170),
    totP      = c(115,   226,   318),
    m_mean    = c(-29.9, -16.6, -14.8),
    lat       = c(36.17, 31.76, 32.22),
    daylamp   = c(2.45,  2.06,  2.10))
  out <- classify_v2(trio)
  expect_true(all(out$regime == "reactive-rain (arid desert)"))
  expect_equal(out$phase[out$name == "El Paso"], "summer")   # Chihuahuan
  expect_equal(out$phase[out$name == "Tucson"],  "bimodal")  # Sonoran
})

test_that("compute_indices returns sane values", {
  P <- c(rep(5, 6), rep(50, 6)); T <- c(rep(0, 6), rep(20, 6))
  ix <- compute_indices(P, T)
  expect_equal(ix$totP, sum(P))
  expect_equal(ix$Tamp, 10)
  expect_gt(ix$SI, 0)
})

test_that("the daylength channel grows from equator to pole", {
  expect_lt(daylength_channel(0)$daylamp,  daylength_channel(45)$daylamp)
  expect_lt(daylength_channel(45)$daylamp, daylength_channel(65)$daylamp)
  expect_lt(daylength_channel(0)$daylamp,  0.2)   # ~flat at the equator
})

test_that("the regime palette is complete", {
  expect_equal(length(regime_palette()), 11L)
  expect_true(all(grepl("^#", regime_palette())))
})
