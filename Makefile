# Makefile to build site and publish
SHELL=/bin/bash

SITE = ./_site
RM   = rm -rf

# CV build folder
CVDIRS	  = build-cv
CLEANCVS  = $(CVDIRS:%=clean-%)


all: clean cvdirs server publish

.PHONY: cvdirs $(CVDIRS)
.PHONY: cvdirs $(CLEANCVS)
.PHONY: all clean 
    

# Buils CVs

cvdirs: $(CVDIRS)

$(CVDIRS): force_look
	$(MAKE) -C $@
    # Move built files to appropriate places
    # Move html version
	cp build-cv/cv-html/_cv*html _includes/
    # Move pdf version
	cp build-cv/cv-pdf/Ruben_Hernandez-Murillo-cv.{tex,pdf} assets/docs/
    # Move resume version
	cp build-cv/cv-resume/Ruben_Hernandez-Murillo-Resume.{md,tex,pdf} assets/docs/
	cp build-cv/cv-resume/index.html resume/

force_look:
	true


# build site
site:  cvdirs
	jekyll build 

# serve to generate post articles to print
server:  site
	jekyll serve --detach

# generate  pdf files of psgts
postspdfs: server _site/blog/index.html _site/news/index.html
	# Obtain url of blog post modified
	# Print page of blog post to pdf file
	# wkhtmltopdf --print-media-type --zoom 0.8 http://0.0.0.0:4000/blog/post/2014/09/25/export-png-charts-from-excel/ file.pdf
	# move pdf file to correct location
	# mv file.pdf rubenhm.github.io/download/blog/2014-09-25-export-png-charts-from-excel/2014-09-25-export-png-charts-from-excel.pdf

publish: postpdfs
	# Stop serve if running
	# kill -9 'ps aux | grep jekyll'
	# Deploy website
	jekyll-deploy.sh


$(CLEANCVS): 
	$(MAKE) -C $(@:clean-%=%) clean

clean: $(CLEANCVS)
	$(RM) $(SITE)


