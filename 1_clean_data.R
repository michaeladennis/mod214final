# load libraries
library(tidyverse)
source("R/moving-average.R")

# changed prm to prmm for tutorial purposes
# read in data
prm <- read_csv(
  "data/RioMameyesPuenteRoto.csv",
  na = c("", "NA")
)
bq1 <- read_csv(
  "data/QuebradaCuenca1-Bisley.csv",
  na = c("", "NA")
)
bq2 <- read_csv(
  "data/QuebradaCuenca2-Bisley.csv",
  na = c("", "NA")
)
bq3 <- read_csv(
  "data/QuebradaCuenca3-Bisley.csv",
  na = c("", "NA")
)

# keep only the necessary cols
prm <- prm |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)

bq1_ <- bq1 |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)

bq2 <- bq2 |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)

bq3 <- bq3 |>
  select(Sample_ID, Sample_Date, K, `NH4-N`, `NO3-N`, Mg, Ca)


# process the data for the moving averages (9 wk avgs)
prm_moving_avg <- moving_average(prm)
glimpse(prm_moving_avg)
bq1_moving_avg <- moving_average(bq1)
glimpse(bq1_moving_avg)
bq2_moving_avg <- moving_average(bq2)
glimpse(bq2_moving_avg)
bq3_moving_avg <- moving_average(bq3)
glimpse(bq3_moving_avg)


# pivot longer
prm_longer <- pivot_longer(
  prm_moving_avg,
  cols = k_mgl:ca_mgl,
  names_to = "Ion",
  values_to = "Concentration"
)
bq1_longer <- pivot_longer(
  bq1_moving_avg,
  cols = k_mgl:ca_mgl,
  names_to = "Ion",
  values_to = "Concentration"
)

bq2_longer <- pivot_longer(
  bq2_moving_avg,
  cols = k_mgl:ca_mgl,
  names_to = "Ion",
  values_to = "Concentration"
)

bq3_longer <- pivot_longer(
  bq3_moving_avg,
  cols = k_mgl:ca_mgl,
  names_to = "Ion",
  values_to = "Concentration"
)

# add a descriptive column for stream name before binding
prm_longer <- mutate(prm_longer, Stream = "PRM")
glimpse(prm_longer)
bq1_longer <- mutate(bq1_longer, Stream = "BQ1")
glimpse(bq1_longer)
bq2_longer <- mutate(bq2_longer, Stream = "BQ2")
glimpse(bq2_longer)
bq3_longer <- mutate(bq3_longer, Stream = "BQ3")
glimpse(bq3_longer)


# Join stream data frames
all_streams <- rbind(prm_longer, bq1_longer, bq2_longer, bq3_longer)

write_csv(all_streams, "output/all_streams.csv")
