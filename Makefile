## This is usLectures (Biology 3SA)

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt"

## -include makestuff/perl.def

######################################################################

## Lecture files

Sources += $(wildcard *.txt)

## intro.draft.pdf: intro.txt intro.draft.tex
## intro.final.pdf: intro.txt
## intro.handouts.pdf: intro.txt
## intro.complete.pdf: intro.txt
## intro.handouts.docx: intro.handouts.tex

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

Sources += $(wildcard *.quiz.csv)

## template.quiz.csv

######################################################################

## lecturePix linking

webLect/%: | webLect
	cd ../lecturePix/ && $(MAKE) webpix/$*

## Is there any need for a recipe here, probably not 2026 Sep 05 (Sat)
imgLect/%: | imgLect ;

Ignore += webLect imgLect
webLect:
	$(LNF) ../lecturePix/webpix/ $@

imgLect:
	$(LNF) ../lecturePix/my_images/ $@

######################################################################

## lecturePix

lecturePix/%:

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

## ln -s ../makestuff . ## Do this first if you want a linked makestuff
Makefile: makestuff/00.stamp
makestuff/%.stamp: | makestuff
	- $(RM) makestuff/*.stamp
	cd makestuff && $(MAKE) pull
	touch $@
makestuff:
	git clone --depth 1 $(msrepo)/makestuff

-include makestuff/os.mk

-include makestuff/newtalk.mk
-include makestuff/texj.mk
## -include makestuff/webpix.mk
## -include makestuff/hotcold.mk

-include makestuff/git.mk
-include makestuff/visual.mk
