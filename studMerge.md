
Think about how best to pipeline this -- feeding back to the main one, or making a new one manually, or what?

make %.merged

Edit %.merged.txt

----------------------------------------------------------------------

Write a script studMerge.py that works in the context of the make recipe.

The two files should be parsed first into “slides” using the hlines, and then into paragraphs in the standard manner. Anything from the first file, or both files, should just be echoed into the output. Anything from only the second file should be echoed with "ADDED: " prepended.

Slide “titles” found in the second file (first paragraph after hline) should match perfectly to the first file (title and order) or you should kick an error. It's OK if a slide is missing from the second file as long as all the slides that are there are matched in order.

<!-- claude-session: 3d1df7f1-68dc-4bb1-acc7-331b0e370de3 host: Tellurium project: -home-dushoff-terminal-dirs-usLectures date: 2026-09-19 -->

