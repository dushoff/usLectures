## This is usLectures (Biology 3SA)

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt"

## -include makestuff/perl.def
-include makestuff/python.def

######################################################################

## Announcements are in the us subdirectory of the space directory

## Lecture files

Sources += $(wildcard *.txt *.md)

notes.txt:

## No .merged paradigm yet! Additions in original. Maybe that should be the paradigm? Just edit the tags and keep going

## Nothing here seems testable
## intro.draft.pdf: intro.txt intro.draft.tex
## intro.final.pdf: intro.txt
## intro.handouts.pdf: intro.txt
## intro.complete.pdf: intro.txt
## intro.handouts.docx: intro.handouts.tex

## https://claude.ai/chat/3279e1c1-5044-4cf1-95e7-f61923080713
## prompts.draft.pdf: prompts.txt

lecprompt: prompts.draft.pdf
	sleep 2700; $(MAKE) $<.go

######################################################################

## R.draft.pdf: R.txt R.draft.tex R.md
## R.final.pdf: R.txt
## R.handouts.pdf: R.txt
## R.complete.pdf: R.txt
## R.handouts.docx: R.handouts.tex

######################################################################

## data.draft.pdf: data.txt data.draft.tex data.md
## data.final.pdf: data.txt data.students.txt
## data.handouts.pdf: data.txt
## data.complete.pdf: data.txt
## data.handouts.docx: data.handouts.tex

#### No intermediate files
#### Check, commit, and merge back into main text!
#### Use OLDANS to mark Answers we've gone past (then change back)

## data.merged: data.txt data.students.txt
## diff data.merged data.txt

## cp data.merged data.txt ##

######################################################################

## philosophy.draft.pdf: philosophy.txt philosophy.draft.tex 
## philosophy.draft.pdf: philosophy.txt philosophy.md
## philosophy.draft.pdf: philosophy.txt philosophy.students.txt
## philosophy.final.pdf: philosophy.txt philosophy.students.txt
## philosophy.handouts.pdf: philosophy.txt
## philosophy.complete.pdf: philosophy.txt
## philosophy.handouts.docx: philosophy.handouts.tex

## philosophy.merged: philosophy.txt philosophy.students.txt

## cp philosophy.merged philosophy.txt ##

######################################################################

## linear.draft.pdf: linear.txt linear.md
## linear.draft.pdf: linear.txt linear.students.txt
## linear.draft.pdf: linear.txt linear.draft.tex 
## linear.final.pdf: linear.txt linear.students.txt
## linear.handouts.pdf: linear.txt
## linear.complete.pdf: linear.txt
## linear.handouts.docx: linear.handouts.tex

## linear.merged: linear.txt linear.students.txt

## cp linear.merged linear.txt ##

######################################################################

## generalized.draft.pdf: generalized.txt generalized.md
## generalized.draft.pdf: generalized.txt generalized.students.txt
## generalized.draft.pdf: generalized.txt generalized.draft.tex 
## generalized.final.pdf: generalized.txt generalized.students.txt
## generalized.handouts.pdf: generalized.txt
## generalized.complete.pdf: generalized.txt
## generalized.handouts.docx: generalized.handouts.tex

## generalized.merged: generalized.txt generalized.students.txt

## cp generalized.merged generalized.txt ##

######################################################################

## practice.draft.pdf: practice.txt practice.md
## practice.draft.pdf: practice.txt practice.students.txt
## practice.draft.pdf: practice.txt practice.draft.tex 
## practice.final.pdf: practice.txt practice.students.txt
## practice.handouts.pdf: practice.txt
## practice.complete.pdf: practice.txt
## practice.handouts.docx: practice.handouts.tex

## practice.merged: practice.txt practice.students.txt

## cp practice.merged practice.txt ##

######################################################################

## Prep an interactive slides file
%.students.txt: | %.txt
	cat $| | perl -00 -ne 'print unless /ANS/' | cat -s > $@

## studMerge.md # Included claude prompt and notes.
## Once the students file is merged, it shouldn't be needed anymore!
Ignore += $(wildcard *.merged)
%.merged: %.txt %.students.txt studMerge.py
	$(PITH)
	git rm $(word 2, $^) || $(RM) $(word 2, $^)

######################################################################

pardirs += lecturePix jdStats

hotdirs += jdStats

Ignore += $(pardirs)

######################################################################

## Lecture formatting
## Script is talkdir/lect.pl
## Current rules are in talkdir/txt.format _and_
Sources += local.txt.format

## Copyright notice
Sources += copy.tex

## Directory-specific latex commands
## Sources += localcomm.tex

######################################################################

## Template: ../../undergrad/avenueQuiz.csv

## avenue quiz dev 2026 Sep 05 (Sat)
## Deleting older saquiz now. 2026 Oct 02 (Fri)

######################################################################

## New quiz framework

## baseline.aq.csv: baseline.quiz ## Ported, not used yet
## test.aq.csv: test.quiz avenueQuiz.py avenueQuiz.md
## R.aq.csv: R.quiz avenueQuiz.py avenueQuiz.md

## For frequentism, more philosophy to come, maybe
## freq.aq.csv: freq.quiz avenueQuiz.md

Sources += $(wildcard *.quiz)
Ignore += *.aq.csv
%.aq.csv: %.quiz avenueQuiz.py
	$(PITH)

######################################################################

## Assignments assignments.md

## install.asn.md

## data.asn.md

## dplyr.asn.md

## plotting.asn.md

######################################################################

######################################################################

## lecturePix linking
## A bit of a sshow; done late at night I guess.

webLect/%: | webLect
	cd lecturePix/ && $(MAKE) webpix/$*

## Is there any need for a recipe here, probably not 2026 Sep 05 (Sat)
imgLect/%: | imgLect ;

Ignore += webLect imgLect
webLect: | lecturePix
	$(LNF) $|/webpix/ $@

imgLect: | lecturePix
	$(LNF) $|/my_images/ $@

######################################################################

## webpix

intro.html: intro.step

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Ignore += *.stamp
Makefile: makestuff01.stamp lecturePix01.stamp
makestuff%.stamp: | makestuff
	- $(RM) makestuff/*.stamp
	cd makestuff && $(MAKE) pull
	touch $@
lecturePix%.stamp: | lecturePix
	- $(RM) lecturePix/*.stamp
	cd lecturePix && $(MAKE) pullup
	touch $@
makestuff:
	git clone --depth 1 $(msrepo)/makestuff

-include makestuff/os.mk

-include makestuff/newtalk.mk
-include makestuff/texj.mk
-include makestuff/webpix.mk
-include makestuff/mirror.mk
## -include makestuff/pipeR.mk
-include makestuff/hotcold.mk

-include makestuff/git.mk
-include makestuff/visual.mk
