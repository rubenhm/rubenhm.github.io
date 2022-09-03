# usage: 
# make FILE=example
# make clean

FILE=
MDFILE=$(FILE)_pres
TEXFILE=presentation_$(FILE)
INPUTS=


all:  pdf; make clean


.PHONY: all clean

pdf:
    # Use pandoc to convert the main markdown source to latex
	pandoc $(MDFILE).md --slide-level 2 -t beamer -o $(MDFILE).tex
    # Use sed to replace a string in the latex file that sets spaces in itemize environment
	sed -i "s/\\itemsep1pt\\parskip0pt\\parsep0pt/\\itemsep1.6pt\\parskip1.6pt\\parsep0pt/g" $(MDFILE).tex
    # Apply xelatex twice to obtain the pdf
	xelatex $(TEXFILE).tex
	xelatex $(TEXFILE).tex	

# Remove unnecessary files
clean: 
	-rm -f $(TEXFILE).log $(TEXFILE).aux  $(TEXFILE).toc  $(TEXFILE).snm $(TEXFILE).nav $(TEXFILE).out $(TEXFILE).fdb_latemk $(TEXFILE).synctex.gz $(TEXFILE).fls
	-rm -f sed*.*
