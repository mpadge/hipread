library(hipread)

context("Read long")

NROW <- 9
NCOL <- 8
HNUM <- c("001", "001", "001", "001", "002", "002", "002", "003", "003")
PERMIX <- c(NA, "x", "1", "1", NA, "d", "1", NA, "d")
HIMPDEC <- c(1, NA, NA, NA, 4.5, NA, NA, 2.4, NA)

test_that("Can read a basic example", {
  actual <- readh_long(
    hipread_example("test-basic.dat"),
    c("rt", "hhnum", "hh_char", "hh_dbl", "hh_impdbl", "pernum", "per_dbl", "per_mix"),
    c("character", "character", "character", "double", "double", "integer", "double", "character"),
    1,
    1,
    list(
      H = list(
        start = c(1, 2, 5, 8, 11),
        width = c(1, 3, 3, 3, 2),
        var_pos = c(1, 2, 3, 4, 5)
      ),
      P = list(
        start = c(1, 2, 5, 6, 9),
        width = c(1, 3, 1, 3, 1),
        var_pos = c(1, 2, 6, 7, 8)
      )
    ),
    list(
      list(trim_ws = TRUE),
      list(trim_ws = FALSE),
      list(trim_ws = TRUE),
      list(imp_dec = 0L),
      list(imp_dec = 1L),
      list(),
      list(imp_dec = 0L),
      list(trim_ws = TRUE)
    )
  )

  expect_equal(nrow(actual), NROW)
  expect_equal(ncol(actual), NCOL)
  expect_equal(actual$hhnum, HNUM)
  expect_equal(actual$per_mix, PERMIX)
  expect_equal(actual$hh_impdbl, HIMPDEC)
})

test_that("Can read a basic gzipped example", {
  actual <- readh_long(
    hipread_example("test-basic.dat.gz"),
    c("rt", "hhnum", "hh_char", "hh_dbl", "hh_impdbl", "pernum", "per_dbl", "per_mix"),
    c("character", "character", "character", "double", "double", "integer", "double", "character"),
    1,
    1,
    list(
      H = list(
        start = c(1, 2, 5, 8, 11),
        width = c(1, 3, 3, 3, 2),
        var_pos = c(1, 2, 3, 4, 5)
      ),
      P = list(
        start = c(1, 2, 5, 6, 9),
        width = c(1, 3, 1, 3, 1),
        var_pos = c(1, 2, 6, 7, 8)
      )
    ),
    list(
      list(trim_ws = TRUE),
      list(trim_ws = FALSE),
      list(trim_ws = TRUE),
      list(imp_dec = 0L),
      list(imp_dec = 1L),
      list(),
      list(imp_dec = 0L),
      list(trim_ws = TRUE)
    )
  )
  expect_equal(nrow(actual), NROW)
  expect_equal(ncol(actual), NCOL)
  expect_equal(actual$hhnum, HNUM)
  expect_equal(actual$per_mix, PERMIX)
  expect_equal(actual$hh_impdbl, HIMPDEC)
})

NROW <- 9
NCOL <- 3
VAR1 <- c("H", "P", "P", "P", "H", "P", "P", "H", "P")
test_that("Can read a rectangular example", {
  var_info <- list(
    list(
      start = c(1, 2, 4),
      width = c(1, 2, 1),
      var_pos = c(1, 2, 3)
    )
  )
  # names(var_info) <- "H"
  actual <- readh_long(
    hipread_example("test-basic.dat"),
    c("var1", "var2", "var3"),
    c("character", "character", "character"),
    1,
    0,
    var_info,
    list(
      list(trim_ws = TRUE),
      list(trim_ws = TRUE),
      list(trim_ws = TRUE)
    )
  )

  expect_equal(nrow(actual), NROW)
  expect_equal(ncol(actual), NCOL)
  expect_equal(actual$var1, VAR1)
})
