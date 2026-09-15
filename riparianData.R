library(shellpipes)
library(janitor)

csvSave(
	csvRead() |> clean_names()
)
