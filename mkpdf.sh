#!/bin/bash

# Obtains url of most recent blog/news post
# Prints pages to pdf file with wkhtmltopdf
# wkhtmltopdf --print-media-type --zoom 0.8 http://0.0.0.0:4000/blog/post/2014/09/25/export-png-charts-from-excel/ file.pdf

# blog posts:
# obtain urls and pass to file
sed -n 's:<a class="post-link" href="/\([^"]*/\)"\(.*$\):\1:1pw post-0.txt' _site/blog/index.html
# read first occurrence and write to file
sed -n 's/ \+\(.*$\)/\1/p;q;' post-0.txt >post-1.txt
# delete trailing /
sed -n 's:\(^.*\)/:\1:p' post-1.txt >post-2.txt
# create pdf file name
sed -n 's:blog/\(.*$\):\1:gp' post-2.txt >post-3.txt
# replace / to -
sed -n 's:/:-:gp' post-3.txt >post-4.txt
# make folder
mkdir -p downloads/blog/`cat post-4.txt`
# print web file to pdf
wkhtmltopdf --print-media-type --zoom 0.8 http://localhost:4000/`cat post-1.txt` downloads/blog/`cat post-4.txt`/`cat post-4.txt`.pdf
# clean up
rm post*.txt 


# news posts:
# obtain urls and pass to file
sed -n 's:<a class="post-link" href="/\([^"]*/\)"\(.*$\):\1:1pw post-0.txt' _site/news/index.html
# read first occurrence and write to file
sed -n 's/ \+\(.*$\)/\1/p;q;' post-0.txt >post-1.txt
# delete trailing /
sed -n 's:\(^.*\)/:\1:p' post-1.txt >post-2.txt
# create pdf file name
sed -n 's:news/\(.*$\):\1:gp' post-2.txt >post-3.txt
# replace / to -
sed -n 's:/:-:gp' post-3.txt >post-4.txt
# make folder
mkdir -p downloads/news/`cat post-4.txt`
# print web file to pdf
wkhtmltopdf --print-media-type --zoom 0.8 http://localhost:4000/`cat post-1.txt` downloads/news/`cat post-4.txt`/`cat post-4.txt`.pdf
# clean up
rm post*.txt 