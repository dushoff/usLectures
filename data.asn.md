For this assignment, you may use AI, or get help from classmates or the teaching team. Report if you used such assistance.

Provide a brief answer to _each_ of the _lettered_ items, e.g.,

	1a: No, I was sleeping.

1. Open rstudio and start a new project in a reasonable place with a reasonable name. For example, make a folder called Bio3SA (if you don't already have one) and call this project Riparian (because it uses Riparian data from the Dudley lab)

	a. Did you notice that rstudio closes your files and restarts R when you open a new project?

	a. Is this a good idea?

1. Open a new R script file in rstudio and copy this text:

	```
	library(readr)

	dat <- read_csv("data/riparian.Rout.csv")

	```

1. Save the script with a sensible name. Make sure it winds up in the right directory for your project.

	a. What name did you use?

1. Use the files panel in rstudio to make a subdirectory called "data" (watch the lowercase). Go to Avenue/Content/Data sets, download the csv file riparian.Rout, and _put it in your new subdirectory_.

1. Go back to your script, restart R, and use the Run menu or a shortcut key to run it from beginning to end. Make sure you can get it to work without errors

	a. Did you see any warning messages?

	a. What was the effect of the last command? How did it show up in your Environment panel?

1. Explore your new data frame (dat), using the commands `View(dat)`, `summary(dat)`, `str(dat)`.

	a. What is one thing that you noticed?

	a. One of the variables is treated differently by summary() than the others. Which one, and why do you think that is?

1. Try installing git [following the instructions here](https://git-scm.com/install/). If it works, try linking your R project to git using Tools/Version_control.

	a. Report how far you got and any obstacles you encountered.
