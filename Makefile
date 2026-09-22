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

Sources += $(wildcard *.txt *.md *.R)

notes.txt:

## No .merged paradigm yet! Additions in original. Maybe that should be the paradigm? Just edit the tags and keep going

## intro.draft.pdf: intro.txt intro.draft.tex
## intro.final.pdf: intro.txt
## intro.handouts.pdf: intro.txt
## intro.complete.pdf: intro.txt
## intro.handouts.docx: intro.handouts.tex

## https://claude.ai/chat/3279e1c1-5044-4cf1-95e7-f61923080713
## prompts.draft.pdf: prompts.txt

######################################################################

## R.draft.pdf: R.txt R.draft.tex R.md
## R.final.pdf: R.txt
## R.handouts.pdf: R.txt
## R.complete.pdf: R.txt
## R.handouts.docx: R.handouts.tex

## R.merged: R.txt R.students.txt
## cp R.merged R.merged.txt ##

## R.merged.draft.pdf: R.merged.txt R.merged.draft.tex
## R.merged.final.pdf: R.merged.txt
## R.merged.handouts.pdf: R.merged.txt
## R.merged.complete.pdf: R.merged.txt

######################################################################

## data.draft.pdf: data.txt data.draft.tex data.md
## data.final.pdf: data.txt
## data.handouts.pdf: data.txt
## data.complete.pdf: data.txt
## data.handouts.docx: data.handouts.tex

## data.merged: data.txt data.students.txt
## cp data.merged data.merged.txt ##

## data.merged.draft.pdf: data.merged.txt data.merged.draft.tex
## data.merged.final.pdf: data.merged.txt
## data.merged.handouts.pdf: data.merged.txt
## data.merged.complete.pdf: data.merged.txt

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

test.merged: R.txt R.students.txt studMerge.py
	$(PITH)

autopipeR = defined
R.Rout: R.R

######################################################################

pardirs += lecturePix

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

## avenue quiz dev 2026 Sep 05 (Sat)

Sources += $(wildcard *.quiz)
Ignore += $(wildcard *.quiz.csv)

## Template: ../../undergrad/avenueQuiz.csv

## saquiz is a big, bloated mess, based on covid-era mcquiz
## Neither one deals with things like images yet

%.quiz.csv: %.quiz saquiz.pl
	$(PUSH)

## baseline.quiz.csv: baseline.quiz saquiz.pl
## saquiz.md
## future.quiz.csv: future.quiz

######################################################################

## Assignments assignments.md

## install.asn.md

## data.asn.md

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

## ln -s ../makestuff . ## Do this first if you want a linked makestuff
Makefile: makestuff/01.stamp lecturePix/01.stamp
makestuff/%.stamp: | makestuff
	- $(RM) makestuff/*.stamp
	cd makestuff && $(MAKE) pull
	touch $@
lecturePix/%.stamp: | lecturePix
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
-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
