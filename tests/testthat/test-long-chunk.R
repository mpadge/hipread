library(hipread)

context("Read chunk long")

FILTERED_NROW <- 6
NCOL <- 8
FILTERED_HNUM <- c("001", "001", "001", "001", "003", "003")

test_that("Can read a basic example", {
  actual <- hipread:::readh_long_chunked(
    hipread_example("test-basic.dat"),
    readr::DataFrameCallback$new(function(x, pos) dplyr::filter(x, hhnum != "002")),
    4,
    c("rt", "hhnum", "hh_char", "hh_dbl", "hh_impdbl", "pernum", "per_dbl", "per_mix"),
    c("character", "character", "character", "double", "double", "integer", "double", "character"),
    list(start = 0, width = 1),
    list(
      H = list(
        start = c(0, 1, 4, 7, 10),
        width = c(1, 3, 3, 3, 2),
        var_pos = c(0, 1, 2, 3, 4),
        max_end = c(12)
      ),
      P = list(
        start = c(0, 1, 4, 5, 8),
        width = c(1, 3, 1, 3, 1),
        var_pos = c(0, 1, 5, 6, 7),
        max_end = 9
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

  expect_equal(nrow(actual), FILTERED_NROW)
  expect_equal(ncol(actual), NCOL)
  expect_equal(actual$hhnum, FILTERED_HNUM)
})

test_that("Can read a basic gzipped example", {
  actual <- hipread:::readh_long_chunked(
    hipread_example("test-basic.dat.gz"),
    readr::DataFrameCallback$new(function(x, pos) dplyr::filter(x, hhnum != "002")),
    4,
    c("rt", "hhnum", "hh_char", "hh_dbl", "hh_impdbl", "pernum", "per_dbl", "per_mix"),
    c("character", "character", "character", "double", "double", "integer", "double", "character"),
    list(start = 0, width = 1),
    list(
      H = list(
        start = c(0, 1, 4, 7, 10),
        width = c(1, 3, 3, 3, 2),
        var_pos = c(0, 1, 2, 3, 4),
        max_end = c(12)
      ),
      P = list(
        start = c(0, 1, 4, 5, 8),
        width = c(1, 3, 1, 3, 1),
        var_pos = c(0, 1, 5, 6, 7),
        max_end = 9
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
  expect_equal(nrow(actual), FILTERED_NROW)
  expect_equal(ncol(actual), NCOL)
  expect_equal(actual$hhnum, FILTERED_HNUM)
})