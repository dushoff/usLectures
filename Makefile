## This is usLectures (Biology 3SA)

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt"

## -include makestuff/perl.def
-include makestuff/python.def

######################################################################

## Lecture files

Sources += $(wildcard *.txt *.md *.R)

notes.txt:

## intro.draft.pdf: intro.txt intro.draft.tex
## intro.final.pdf: intro.txt
## intro.handouts.pdf: intro.txt
## intro.complete.pdf: intro.txt
## intro.handouts.docx: intro.handouts.tex

## Not done yet; something about following up the assignment and the question of what significance is about
## introPlus.draft.pdf: introPlus.txt
## introPlus.final.pdf: introPlus.txt
## introPlus.handouts.pdf: introPlus.txt
## introPlus.complete.pdf: introPlus.txt
## introPlus.handouts.docx: introPlus.handouts.tex

## https://claude.ai/chat/3279e1c1-5044-4cf1-95e7-f61923080713
## prompts.draft.pdf: prompts.txt

## R.draft.pdf: R.txt R.draft.tex R.md
## R.final.pdf: R.txt
## R.handouts.pdf: R.txt
## R.complete.pdf: R.txt
## R.handouts.docx: R.handouts.tex

## R.merged: R.txt R26.students.txt 
## cp R.merged R.merged.txt ##

## R.merged.draft.pdf: R.merged.txt R.draft.tex R.md
## R.merged.final.pdf: R.merged.txt
## R.merged.handouts.pdf: R.merged.txt
## R.merged.complete.pdf: R.merged.txt

######################################################################

## Prep an interactive slides file
%.students.txt: | %.txt
	cat $| | perl -00 -ne 'print unless /ANS/' | cat -s > $@

## studMerge.md # Included claude prompt and notes.
Ignore += $(wildcard *.merged)
%.merged: %.txt %.students.txt studMerge.py
	$(PITH)

test.merged: R.txt R.students.txt studMerge.py
	$(PITH)

autopipeR = defined
R.Rout: R.R

######################################################################

## Data manipulation
## Downloads/ is a mirror, for things I get from elsewhere
## data/ is a cache for things I want to share (use data/ to show them about putting things in directories)
Ignore += data/
mirrors += Downloads/

data/%.csv: %.csv | data
	$(copy)
data:
	$(mkdir)

## Not chaining well so far?
## https://figshare.com/articles/dataset/Portal_Project_Teaching_Database/1314459
## data/rodentData.Rout.csv:
## rodentData.Rout: rodentData.R | data

rodents.Rout: rodents.R data/rodentData.Rout.csv

## complete_old from ratdat is a smaller set of rodent data

######################################################################

## Riparian data from Dudley lab
## data/riparianData.Rout.csv: 
riparianData.Rout: riparianData.R riparianData.csv

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
