# This Makefile builds the different CV versions
#
# The options are: 
# 1. CV-html
# 2. CV-pdf from latex
# 3. CV-resume, which itself has four versions: 
#    1. Resume.md
#    2. Resume.tex
#    3. Resume.pdf
#    4. Resume.html

include Makefile.inc

SUBDIRS	= cv-html cv-pdf cv-resume
CLEANDIRS = $(SUBDIRS:%=clean-%)

subdirs: $(SUBDIRS)

$(SUBDIRS): force_look
	$(MAKE) -C $@


force_look :
	true

clean: $(CLEANDIRS)
$(CLEANDIRS): 
	$(MAKE) -C $(@:clean-%=%) clean

.PHONY: subdirs $(SUBDIRS)
.PHONY: subdirs $(CLEANDIRS)
.PHONY: all  clean 	