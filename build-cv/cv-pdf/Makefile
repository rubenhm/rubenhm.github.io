
# This make file updates CV-PDF whenever the bib file is updated.
# The main tex file uses the xetexCV.csl class from ...
# which displays bib items in categories. 
# This make file generates lists of bib items categories by publication type
# that are extracted from the bib file
# and writes them to .bibtxt files that are \input in the main .tex file.
# The latex class xetexCV provides a command \years{} to organize the bib items
# by year, using the year as bullet marker. 
# The \years{} command is written to the .bbl. 
# The make file uses sed to manipulate various files.
#
# The following discussion helped organize the order of the targets
# http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project


include ../Makefile.inc

SRC = $(wildcard *.tex)
PDF = $(SRC:.tex=.pdf)
BBL = $(SRC:.tex=.bbl)
AUX = $(SRC:.tex=.aux)
BIBTXT = Journal ES WP RegEco Review


all: clean $(PDF) $(BIBTXT)

.PHONY: all clean

aux:  $(TEX)
bbl:  $(BBL)	
pdf:  $(PDF)
bibtxt: $(BIBTXT)


$(BIBTXT): $(BIBFILE)
	#http://tex.stackexchange.com/questions/87604/extracting-bibtex-entries-with-regular-expressions
	bibtool '--select{pubtype "$@"} ' $(BIBFILE)  -o $@.bibtxt
	# Extract list of keys matching pubtype
	sed  's/@[a-zA-Z]*{[[:space:]]*\(.*\)/\1/gpw tmpbib.txt' <$@.bibtxt 
	# Remove newlines
	sed ':a;N;$$!ba;s/\n//g' <tmpbib.txt >$@.bibtxt
	-rm tmpbib.txt
	# Append select code
	sed -i.bak 's/\(^.*\),/\\SBentries{\1}/g' $@.bibtxt
	-rm $@.bibtxt.bak

%.aux: %.tex $(BIBTXT)
	# Generate an aux file from a first xelatex pass
	lualatex $(basename $<)

%.bbl: %.aux $(BIBTXT)
	# Generate the .bbl file from the .aux file 
	bibtex $(basename $<)
	# Modify the .bbl file to write the \years{} command to each entry
	sed  -i.bak -f fixbbl.sed $@ 


%.pdf: %.tex %.bbl %.aux $(BIBTXT)   
	# Run a couple more xelatex passes and clean up ancillary files
	lualatex $(basename $<)
	lualatex $(basename $<)
	-rm -f *.log *.out *.fls *.fdb* *.bak *.bbl *.aux *.blg
	# copy pdf to correct destination
	cp $@ /home/ruben/repos/website/rubenhm.org/assets/docs/
	# copy tex to correct destination
	cp $(basename $@).tex /home/ruben/repos/website/rubenhm.org/assets/docs/


clean:
	-rm -f *.aux *.bbl *.blg *.log *.pdf *.out *.bibtxt *.bak

