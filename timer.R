library(tictoc)
library(knitr)
library(here)

printTicTocLog <-
  function() {
    tic.log() %>%
      unlist %>%
      tibble(logvals = .) %>%
      separate(logvals,
               sep = ":",
               into = c("Function type", "log")) %>%
      mutate(log = str_trim(log)) %>%
      separate(log,
               sep = " ",
               into = c("Seconds"),
               extra = "drop")
  }

tic.clearlog()

tic("Current Script")
source("scripts/solution_1.r")
toc(log = TRUE)

tic("Parallel computing 1")
source("scripts/solution_2.r")
toc(log = TRUE)

tic("Paralel computing 2")
source("scripts/solution_3.r")
toc(log = TRUE)


printTicTocLog() %>%
  knitr::kable()

#Parallel computing 2 fastest, parallel comuputing 1 2nd, and the current script 3rd
#This is likely because it parallelized both 
# the dataframe row computations and the individual simulations within the MTweedieTests function. 
#This dual-level parallelism made better use of the available cores, 
#especially when the number of simulations M was large.

