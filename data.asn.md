1. Open rstudio and start a new project in a reasonable place with a reasonable name. For example, make a folder called Bio3SA (if you don't already have one) and call this project Riparian (because it uses Riparian data from the Dudley lab)

	a. Did you notice that rstudio closes your files and restarts R when you open a new project?

	a. Is this a good idea?

1. Use the files panel in rstudio to make a subdirectory called "data" (watch the lowercase). Go to Avenue/Content/Data sets, download the csv file riparian.Rout, and _put it in your new subdirectory_.

1. Open a new R script file in rstudio and copy this text:

	```
	library(readr)
	library(dplyr)

	dat <- read_csv("data/riparian.Rout.csv")

	```

1. Save the script with a sensible name and use the Run menu or a shortcut key to run it from beginning to end.

	a. What name did you use?

	a. What was the effect of the last command? How did it show up in your Environment panel?

1. Explore your new data frame (dat), using the 
