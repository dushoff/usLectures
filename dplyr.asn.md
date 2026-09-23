
For this assignment, you may use AI, or get help from classmates or the teaching team. You do not need to report if you used such assistance. 

_But:_

* Write your scripts one line at a time, and make sure you understand every line. 
* Use simple code with simple dplyr verbs and no operations that we haven't covered: [], $, ...

Provide a brief answer to _each_ of the _lettered_ items.

1. Make a new R project, and copy-paste [the oldRodents starting script](https://github.com/dushoff/usCode/blob/main/oldRodents.R) there.

	a. What did you call your project?

1. Make a data/ subdirectory (might be case-sensitive), and download the file oldRodents.csv from Avenue to the data/ subdirectory. You should be able to run the script now and examine the data.

	a. Describe one thing you did to examine the data

1. The file has 2591 observations of rodents that were _observed to_ weigh _more than_ 100g.

	a. Write a piece of code for your current script to confirm this.

1. The file has 4283 observations of rodents that either _do_ or _might_ weigh more than 100g.

	a. Write a piece of code for your current script to confirm this.

1. Make a table that shows the mean weight, among measured weights, for each genus of rodent. You should: use filter() to exclude NA values for weights; use summarise() with .by to make your table.

	a. Paste the code you wrote

	a. Which genus is the heaviest on average?
