# Macros
SRC     =$(wildcard *.md)
PDF     =$(SRC:.md=.pdf)
HTML    =$(SRC:.md=.html)
HTML2   =$(SRC:.md=.plain.html)
TEX     =$(SRC:.md=.tex)
LATEX_TEMPLATE =./my-template.latex.txt
HTML_TEMPLATE  =./my-template.html.txt
GRAVATAR_OPTION=--no-gravatar

all:   clean $(TEX) $(PDF) $(HTML) $(HTML2) 

pdf:   clean $(PDFS)
html:  clean $(HTML) 
html2: clean $(HTML2)
tex:   clean $(TEX)

%.plain.html: %.md $(HTML_TEMPLATE)
	python resume.py html $(GRAVATAR_OPTION) < $< | pandoc --template=$(HTML_TEMPLATE) -t html -c resume.css -o $@
	mv $@ index.html
	# copy to correct destination
	cp index.html /workdir/resume/

%.html: %.md
	python resume.py html $(GRAVATAR_OPTION) < $< | pandoc -s -t html -c resume.css -o $@
	# copy to correct destination
	cp $@ /workdir/assets/docs/

%.pdf:  %.md $(LATEX_TEMPLATE)
	python resume.py tex < $< | pandoc $(PANDOCARGS) --variable=fontsize:10pt --template=$(LATEX_TEMPLATE) --pdf-engine=xelatex -H header.txt -o $@
	# copy to correct destination
	cp $@ /workdir/assets/docs/

%.tex: %.md
	python resume.py tex < $< | pandoc $(PANDOCARGS) --variable=fontsize:10pt --template=$(LATEX_TEMPLATE) --pdf-engine=xelatex -H header.txt -o $@
	# copy to correct destination
	cp $@ /workdir/assets/docs/
	cp $(basename $@).md /workdir/assets/docs/


ifeq ($(OS),Windows_NT)
  # on Windows
  RM = cmd //C del
else
  # on Unix
  RM = rm -f
endif

clean:
	$(RM) *.html *.pdf *.tex


