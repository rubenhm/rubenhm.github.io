# Include common definitions
include ../Makefile.inc

# File groups
HTMLS= $(patsubst %.md, %.html, $(wildcard _cv*.md))


# Rules

all: clean  _cv_select_pubs_long.md _cv_select_pubs_long.html $(HTMLS)


.PHONY: all clean

_cv_select_pubs_long.md:  $(BIBFILE)
	# Extract subset of bibtex file matching pattern
    # here we look for a field that indicates if pub should be "selected"
	# http://tex.stackexchange.com/questions/87604/extracting-bibtex-entries-with-regular-expressions
	bibtool '--select{selectpub "Yes"}' $(BIBFILE) -o selbib.txt
	# Extract list of keys matching pattern and write to a file
	sed  's/@[a-zA-Z]*{[[:space:]]*\(.*\)/\1/gpw tmpbib.txt' <selbib.txt 
	# Remove newlines and write to new file
	sed ':a;N;$$!ba;s/\n//g' <tmpbib.txt >selbib.txt
	-rm tmpbib.txt
	# Append  code to turn into markdown with nocite in yaml preamble
	sed -i.bak 's/^\(.*\),/@\1/g' selbib.txt
	sed -i.bak 's/,/, @/g' selbib.txt
	sed  's/\(^.*\)/---\nnocite: |\n    \1\n.../g' <selbib.txt >selbib.md	
	-rm selbib.txt*
	# generate markdown file with expanded list of citations 
	pandoc -t markdown-citations --bibliography=$(BIBFILE) --csl=$(CSLFILE) --filter pandoc-citeproc selbib.md -o $@
	-rm selbib.md
	# fix indentations with sed to prepare for conversion to html
	sed -i.bak -f fixindent.sed $@
	-rm -f *.bak


_cv_select_pubs_long.html: _cv_select_pubs_long.md
	pandoc -f markdown+definition_lists-markdown_in_html_blocks $< -o $@ 
	# copy to correct destination
	cp $@ /home/ruben/repos/website/rubenhm.org/_includes/

%.html: %.md
	pandoc -f markdown+markdown_in_html_blocks --section-divs $< -o $@
	# copy to correct destination
	cp $@ /home/ruben/repos/website/rubenhm.org/_includes/

clean:
	-rm -f _cv*pubs*.md*  _cv*pubs*.html* _cv*.html 

rebuild: clean all
