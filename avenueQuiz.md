
I want a script to convert .quiz-formatted files to brightspace quiz files, like baseline.quiz.csv or import.quiz.csv

Use test.quiz as an input template.

Each paragraph should either be parseable as a multiple-choice option, or start with INTRO, MC, or SA. I guess the meanings are clear. I want to use code in question statements and MC options, so respect CR and TAB there.

Generate Title using word 2 through 4 of the question statement, linked with underscores (similar to, but longer than, the example).

Do you have concerns with making everything html/pre? Would it be better to do it only for multi-line paragraphs? Should we consider treating everything as markdown and converting it all to straight html?
