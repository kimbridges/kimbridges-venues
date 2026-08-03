test_that("read_lists parses ragged rows and strips whitespace", {
  d <- read_lists("S1, a, b, c\nS2, b")
  expect_equal(d$Site, c("S1", "S2"))
  expect_true(all(c("item1", "item2", "item3") %in% names(d)))
  expect_equal(d$item1, c("a", "b"))   # leading space after comma stripped
  expect_equal(d$item3[2], "")          # ragged row padded
})

test_that("to_long drops the empty ragged cells", {
  lng <- to_long(read_lists("S1, a, b\nS2, b"))
  expect_equal(names(lng), c("Site", "name", "Item"))
  expect_false(any(lng$Item == ""))
  expect_equal(nrow(lng), 3)            # a,b + b
})

test_that("data_to_2way is binary with items as rows", {
  tw <- data_to_2way(read_lists("S1, a, b\nS2, b, c"))
  expect_true("Item" %in% names(tw))
  expect_setequal(tw$Item, c("a", "b", "c"))
  vals <- unlist(tw[, -1])
  expect_true(all(vals %in% c(0, 1)))
})
