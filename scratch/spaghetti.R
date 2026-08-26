# load libraries
library(tidyverse)

# read in data
prm <- read_csv(
  "data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv",
  na = c("", "NA")
)
bq1 <- read_csv(
  "data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv",
  na = c("", "NA")
)
bq2 <- read_csv(
  "data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv",
  na = c("", "NA")
)
bq3 <- read_csv(
  "data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv",
  na = c("", "NA")
)

# clean/standardize
# pull out only the necessary data -- filter for 1988-1994, then focus on potassium,
# nitrate-N (NO3), magnesium, calcium, ammonium (NH4)
prm_iso <- prm |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)

bq1_iso <- bq1 |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)

bq2_iso <- bq2 |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)

bq3_iso <- bq3 |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)
glimpse(prm_iso)


# process the data for the moving averages (9 wk avgs)

# Before you can fill in a moving average, you need somewhere to put it. Build a
#  tibble called qs_smoothed with one row per window: a window_start column stepping
# 9 days at a time from the first sample date to the last, and blank (NA) k_mgl and
# mg_mgl columns to fill in later.

prm_smoothed <- tibble(
  "window" = c(1:41),
)

prm_smoothed <- prm_smoothed |>
  mutate("start" = seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "9 weeks")) |>
  mutate("end" = seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "9 weeks")) |>
  mutate("mean_k" = integer(41)) |>
  mutate("mean_mg" = integer(41)) |>
  mutate("mean_nh4" = integer(41)) |>
  mutate("mean_no3" = integer(41)) |>
  mutate("mean_ca" = integer(41))

for (i in 1:nrow(prm_smoothed)) {
  # i is our iterator
  # 1:nrow(prm_iso) is our sequence
  # i will take on those values, one at a time
  # What's the start of the window? call it w1
  w1 <- prm_smoothed$start[i]

  # What's the end of the window? call that w2
  w2 <- w1 + 63
  # What K values are inside that window
  k_window <- prm_iso$K[
    prm_iso$Sample_Date >= w1 &
      prm_iso$Sample_Date < w2
  ]

  # what's the mean?
  mean_k_window <- mean(k_window, na.rm = TRUE)
  # how do you put it in the result?
  prm_smoothed$mean_k[i] <- mean_k_window

  # What mg values are inside that window
  mg_window <- prm_iso$Mg[
    prm_iso$Sample_Date >= w1 &
      prm_iso$Sample_Date < w2
  ]

  # what's the mean?
  mean_mg_window <- mean(mg_window, na.rm = TRUE)
  # how do you put it in the result?
  prm_smoothed$mean_mg[i] <- mean_mg_window

  # What ca values are inside that window
  ca_window <- prm_iso$Ca[
    prm_iso$Sample_Date >= w1 &
      prm_iso$Sample_Date < w2
  ]

  # what's the mean?
  mean_ca_window <- mean(ca_window, na.rm = TRUE)
  # how do you put it in the result?
  prm_smoothed$mean_ca[i] <- mean_ca_window

  # What nh4 values are inside that window
  nh4_window <- prm_iso$`NH4-N`[
    prm_iso$Sample_Date >= w1 &
      prm_iso$Sample_Date < w2
  ]

  # what's the mean?
  mean_nh4_window <- mean(nh4_window, na.rm = TRUE)
  # how do you put it in the result?
  prm_smoothed$mean_nh4[i] <- mean_nh4_window

  # What no3 values are inside that window
  no3_window <- prm_iso$`NO3-N`[
    prm_iso$Sample_Date >= w1 &
      prm_iso$Sample_Date < w2
  ]

  # what's the mean?
  mean_no3_window <- mean(no3_window, na.rm = TRUE)
  # how do you put it in the result?
  prm_smoothed$mean_no3[i] <- mean_no3_window
}


# plot moving average for prm

# join rivers

# pivot longer
prm_longer <- pivot_longer(
  prm_smoothed,
  cols = mean_k:mean_ca,
  names_to = "Ion",
  values_to = "Concentration"
)

# visualize using ggplot
ggplot(
  prm_longer,
  mapping = aes(
    x = start,
    y = Concentration,
    color = Ion
  )
) +
  geom_line() +
  facet_wrap(~Ion, scales = "free")
