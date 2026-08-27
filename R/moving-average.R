library(tidyverse)
# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(stream) {
  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "9 weeks"),
    k_mgl = NA,
    mg_mgl = NA,
    nh4_ugl = NA,
    no3_ugl = NA,
    ca_mgl = NA
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- w1 + 63

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- stream$Sample_Date >= w1 & stream$Sample_Date < w2

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- stream$K[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too
    # mg window
    mg_window <- stream$Mg[in_window]

    # ca window
    ca_window <- stream$Ca[in_window]

    # nh4 window
    nh4_window <- stream$`NH4-N`[in_window]

    # no3 window
    no3_window <- stream$`NO3-N`[in_window]

    # Calculate the mean of each ion concentration and fill in the result
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$ca_mgl[i] <- mean(ca_window, na.rm = TRUE)
    result$nh4_ugl[i] <- mean(nh4_window, na.rm = TRUE)
    result$no3_ugl[i] <- mean(no3_window, na.rm = TRUE)
  }

  # Return the result
  return(result)
}
