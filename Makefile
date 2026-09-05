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

## Formatting
## Script is talkdir/lect.pl
## Current rules are in talkdir/txt.format _and_
Sources += local.txt.format

## Copyright notice
Sources += copy.tex

## Directory-specific latex commands
## Sources += localcomm.tex

######################################################################

## Cribbing

webLect/%: | webLect
	/bin/cp ../3Lectures/webpix/$* $@

imgLect/%: | imgLect
	/bin/cp ../3Lectures/webpix/$* $@

Ignore += webLect imgLect
webLect imgLect:
	$(mkdir)

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
