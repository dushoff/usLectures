library(readr)
library(dplyr)

dat <- read_csv("data/rodentData.Rout.csv")

## str(dat)
## summary(dat)

longfoot <- (
	dat |> filter(hindfoot_length > 50)
)

## summary(dat)
