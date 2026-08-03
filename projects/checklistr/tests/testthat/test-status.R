test_that("add_status attaches status from a source", {
  cl  <- data.frame(accepted_name = c("Aus bus", "Xus yus"))
  out <- add_status(cl, data.frame(accepted_name = "Aus bus", status = "E"), quiet = TRUE)
  expect_equal(out$status, c("E", NA))
  expect_false("status_agree" %in% names(out))
})

test_that("add_status flags disagreements between two sources", {
  cl   <- data.frame(accepted_name = c("Aus bus", "Bus cus", "Cus dus"))
  prim <- data.frame(accepted_name = cl$accepted_name, status = c("E", "I", "Nat"))
  ver  <- data.frame(accepted_name = cl$accepted_name, status = c("endemic", "introduced", "introduced"))
  out  <- add_status(cl, prim, verify_against = ver, quiet = TRUE)
  expect_equal(out$status_check, c("endemic", "introduced", "introduced"))
  # E vs endemic -> both native -> agree; I vs introduced -> disagree; Nat vs introduced -> agree
  expect_equal(out$status_agree, c(TRUE, FALSE, TRUE))
})
