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
	cp build-cv/cv-resume/Ruben_Hernandez-Murillo-Resume.{md,tex,pdf,html} assets/docs/
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
postpdfs: server _site/blog/index.html _site/news/index.html
    # regenerate pdf of most recent blog and news post
	./mkpdf.sh
	# Find the pid of the jekyll server
	ps aux | grep jekyll > pid.txt
	sed -i.bak -n 's/ruben[[:space:]]\+\([0-9]\+\).*detach/\1/p' pid.txt
    # kill the detached jekyll process
	kill -9 `cat pid.txt`
    # clean up
	-rm pid.txt*

publish: postpdfs
	# Stop serve if running
	# kill -9 'ps aux | grep jekyll'
	# Deploy website
	jekyll-deploy.sh


$(CLEANCVS): 
	$(MAKE) -C $(@:clean-%=%) clean

clean: $(CLEANCVS)
	$(RM) $(SITE)


