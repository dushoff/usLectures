
For this assignment, you may use AI, or get help from classmates or the teaching team. You do not need to report if you used such assistance. 

_But:_

* Write your scripts one line at a time, and make sure you understand every line. 
* Use simple code
* Use AI for code, or for understanding, but explain in your own words.

Provide a brief answer to _each_ of the _lettered_ items.

1. We have uploaded the Palmer penguins data set to Avenue. You can [read a bit about it](https://allisonhorst.github.io/palmerpenguins/).

	a. Does anything interest you about this data set (OK to just say no, but think about it a bit first)

1. Download the data and put it somewhere you can read it without an absolute path. This means your file specification should look like "data/penguinData.Rout.csv" and not "/home/dushoff/3SA3/ggplot/data/penguinData.Rout.csv". Read the file into a data frame called penguins.

	a. What code did you use for this?

1. Run the following code:

	```
	print(penguins
		|> summarize(
			bill_depth_mm = mean(bill_depth_mm, na.rm=TRUE)
			, bill_length_mm = mean(bill_length_mm, na.rm=TRUE)
			, .by = species
		)
	)
	```

	a. Describe the table produced

	a. What is the role of "na.rm=TRUE" (get this from the help for the function mean(), but use your own words)?

	a. What do you see if you leave it out?

1. Examine the variables (using View or summary, or by clicking), and make a ggplot that uses one quantitative and one categorical variable

	a. What code did you use to make a nice plot?

	a. Do you see anything interesting about the plot?

1. Make a ggplot that uses two quantitative and one categorical variable

	a. What code did you use to make a nice plot?

	a. Do you see anything interesting about the plot?

