---
layout: post
title: "How to collaborate with Scientific Workplace users"
description: "Collaborate with SWP users"
category: latex
tags: [latex editors texlive sublime_text]
---

When writting papers in latex, I usually use _WinEdt_ and MikTeX (more recently,
I started using _SublimeText_ with TexLive, but most of my co-authors only use
_ScientificWorkplace_ with the standard latex engine.

In preparing papers, I like to have the following folder structure:

```
bibfiles/
project-files/
    |
    |-plots/
    |-tables/
```

But this does not work for SWP because in order to compile the main document, it copies the  tex file to a temporary file under a temporary folder, and therefore, SWP cannot find any folders or graphics included with
`\input` or `\includegraphics` that are in the above subfolders. SWP also cannot find any `bib` files, unless the `bibfiles` folder is appropiately selected in the general settings, or the `bib` file is copied to the standard folder.

The solution, which does not require to manually edit any settings file under SWP (which does not work), involves three steps:

1. To fix the issue with finding graphics files (e.g, `png` or `pdf` files, because I use `pdflatex`), include the following commands in the preamble. Notice the two sets of braces and the trailing `/`. The path can be absolute or relative (see 2).

    ```latex
    \usepackage{graphicx}
    \graphicspath{ {/path/to/graphics/folder/} }
    ```

2. To be able to work with relative paths and subfolders we have to prevent SWP from copying the main tex file to a temporary folder when compiling. This is achived by setting the main tex files as a `master document`. Include the following code somewhere after `\begin{document}`:

    ```latex
    %TCIMACRO{\QSubDoc{Include subdoc}{\input{tables/subdoc.tex}}}%
    %BeginExpansion
    \input{tables/subdoc.tex}
    %EndExpansion
    ```

    The file `subdoc.tex` located in the `tables/` folder has to include the following code (and it can be empty otherwise; it can also be located in the main folder, but the paths above have to reflect this):

    ```latex
    %TCIDATA{LaTeXparent=0,0,main.tex}
    ```
    
    where `main.tex` is the name of the master file. For additional files in the `plots` and `tables` subfolders, the TCI macro is not needed, and the usual `\input` or `\includegraphics` commands will work and the tex or graphics files will be found.

3. Finally, as mentioned before, to find the correct `bib` files, the options are to change the standard path in SWP's general settings or to copy the `bib` files to the standard path.



