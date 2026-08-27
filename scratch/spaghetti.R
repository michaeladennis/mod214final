# load libraries
library(tidyverse)
source("R/moving-average.R")

# changed prm to prmm for tutorial purposes
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
prm_moving_avg <- moving_average(prm)
glimpse(prm_moving_avg)
bq1_moving_avg <- moving_average(bq1)
glimpse(prm_moving_bq1)
bq2_moving_avg <- moving_average(bq2)
glimpse(prm_moving_bq2)
bq3_moving_avg <- moving_average(bq3)
glimpse(prm_moving_bq3)


# plot moving average for prm

# join rivers

# pivot longer
prm_longer <- pivot_longer(
  prm_moving_avg,
  cols = k_mgl:ca_mgl,
  names_to = "Ion",
  values_to = "Concentration"
)

# visualize using ggplot
ggplot(
  prm_longer,
  mapping = aes(
    x = window_start,
    y = Concentration,
    color = Ion
  )
) +
  geom_line() +
  facet_wrap(~Ion, scales = "free")
