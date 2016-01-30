% This example document class is based on the Typesetting your
% academic CV in LaTeX by Dario Taraborelli.  The original article
% is avaiable at http://nitens.org/taraborelli/cvtex
%
% Additional modifications made by Robert Oakes.  Copyright 2009.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xetexCV}[2009/11/15 - Modern looking resume which
uses the xetex typesetting system.]

% Load the Base Class
\LoadClassWithOptions{article}

% Begin Requirements
\RequirePackage{ifthen}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}

\RequirePackage{graphicx}
\RequirePackage[colorlinks]{hyperref}
\hypersetup{linkcolor=blue,citecolor=blue,filecolor=black,urlcolor=blue} 

% Fonts
\defaultfontfeatures{Mapping=tex-text}
\setsansfont [Ligatures={Common}, BoldFont={FontinSans-Bold}, ItalicFont={FontinSans-BoldItalic}]{Fontin Sans Bold}
\setromanfont[BoldFont={Gentium Basic Bold}]{Gentium}

% Custom Document Formatting
\newcommand\decorativeline[1][1pt]{%
	\par\noindent%
	\rule[0.5ex]{\linewidth}{#1}\par}

\pagestyle{empty}
\hyphenpenalty=5000
\tolerance=1000


% Command to include icon images for contact items
%\newcommand{\ContactEntry}[2]{
%	\includegraphics[height=15pt]{#1}#2
%}

% CV and Contact Information
\def\@cvname{\relax}
\newcommand{\cvname}[1]{\gdef\@cvname{#1}}

\def\@cvimage{\relax}
\newcommand{\cvimage}[1]{\gdef\@cvimage{#1}}

\def\@institution{\relax}
\newcommand{\institution}[1]{\gdef\@institution{#1}}

\def\@contactaddress{\relax}
\newcommand{\contactaddress}[1]{\gdef\@contactaddress{#1}}

\def\@phonenumber{\relax}
\newcommand{\phonenumber}[1]{\gdef\@phonenumber{#1}}

\def\@cellphonenumber{\relax}
\newcommand{\cellphonenumber}[1]{\gdef\@cellphonenumber{#1}}


\def\@faxnumber{\relax}
\newcommand{\faxnumber}[1]{\gdef\@faxnumber{#1}}

\def\@email{\relax}
\newcommand{\email}[1]{\gdef\@email{#1}}

\newcommand\@website{\relax}
\newcommand{\website}[1]{\gdef\@website{#1}}

\def\@emailb{\relax}
\newcommand{\emailb}[1]{\gdef\@emailb{#1}}

\newcommand\@websiteb{\relax}
\newcommand{\websiteb}[1]{\gdef\@websiteb{#1}}

% Set the Paper Size and Margins
\RequirePackage{geometry} 
\geometry{letterpaper, textwidth=5.5in, textheight=8.5in, marginparsep=1.0pt, marginparwidth=2.0in, margin=0.9in}
\setlength\parindent{0in}

% Special Commands for Fancy Characters and Years
\newcommand{\amper}{{\fontspec[Scale=.95]{Hoefler Text}\selectfont\itshape\&}}
\newcommand{\years}[1]{\marginpar{\hspace{5.13cm}\parbox[c][]{3.0cm}{\emph{#1}}}}

% Headings and Heading Fonts
\RequirePackage[normalem]{ulem}
\renewcommand\section{\@startsection{section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex \vspace{1mm}}%
	{0.5mm}%
	{\sffamily\large\bfseries}}

\renewcommand\subsection{\@startsection{subsection}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{3.0mm}%
	{\sffamily\mdseries}}

\newcommand{\cvsection}[1]{\leftskip 0cm
	\section*{#1}\decorativeline\marginpar{\vspace{0.3ex}}
	\leftskip 116pt}

\newcommand{\cvsubsection}[1]{\leftskip 0cm \vspace{-0.2cm}
	\subsection*{#1}\vspace{1.0mm} \leftskip 116pt}

\reversemarginpar

\newcommand\makecvtitle{
	\ifthenelse{\equal{\@cvimage}{\relax}}
	{ % Create Without Image
	\ifthenelse{\equal{\@cvname}{\relax}}{}
	{\textsf{\LARGE\bfseries \@cvname}\decorativeline\vspace{0.3cm}}
	\leftskip 116pt
	% Contact Information and Other Details
	\ifthenelse{\equal{\@institution}{\relax}}{}
		{\bfseries{\@institution}\\}
	\ifthenelse{\equal{\@contactaddress}{\relax}}{}
		{\mdseries \@contactaddress\\[0.2cm]}
	\ifthenelse{\equal{\@phonenumber}{\relax}}{}
		{Phone: \texttt{\@phonenumber}~(w)~
                \ifthenelse{\equal{\@cellphonenumber}{\relax}}{}$\bullet$~\texttt{\@cellphonenumber}~(c)\\}
	\ifthenelse{\equal{\@faxnumber}{\relax}}{}
		{Fax: \texttt{\@faxnumber}\\[0.2cm]}
	\ifthenelse{\equal{\@email}{\relax}}{}
		{Email: \href{mailto:\@email}{\@email}~
                \ifthenelse{\equal{\@emailb}{\relax}}{}{$\bullet$~\href{mailto:\@emailb}{\@emailb}}\\}
	\ifthenelse{\equal{\@website}{\relax}}{}
		{Website: \href{http://\@website}{\@website}~
                \ifthenelse{\equal{\@websiteb}{\relax}}{}{$\bullet$~\href{http://\@websiteb}{\@websiteb}}}
        }
	{% Create With Image
	\ifthenelse{\equal{\@cvname}{\relax}}{}
	{\textsf{\LARGE\bfseries \@cvname}\decorativeline\vspace{0.3cm}}
	\begin{minipage}{6in}
		\begin{minipage}{114pt}
			\resizebox*{100pt}{!}{\includegraphics{\@cvimage}}
		\end{minipage}
		\begin{minipage}{4in}%
            %\vspace*{5ex}
		    \ifthenelse{\equal{\@institution}{\relax}}{}{			
		    $\begin{array}{ll}{\includegraphics[height=10pt]{email20.png}
		    }\end{array}$\@institution\\}
			\mdseries\@contactaddress\\[0.2cm]
			\ifthenelse{\equal{\@faxnumber}{\relax}}{}{Fax: \texttt{\@faxnumber}\\[0.2cm]}
			\ifthenelse{\equal{\@email}{\relax}}{}{$\begin{array}{l}{\includegraphics[height=10pt]{opened4.png}}\end{array}$\href{mailto:\@email}{\@email}~
                        \ifthenelse{\equal{\@emailb}{\relax}}{}{$\bullet$~\href{mailto:\@emailb}{\@emailb}}\\}
			\ifthenelse{\equal{\@website}{\relax}}{}{$\begin{array}{l}{\includegraphics[height=10pt]{world86.png}}\end{array}$\href{http://\@website}{\@website}~
                        \ifthenelse{\equal{\@websiteb}{\relax}}{}{$\bullet$~\href{http://\@websiteb}{\@websiteb}}\\}
			\ifthenelse{\equal{\@phonenumber}{\relax}}{}{$\begin{array}{l}{\includegraphics[height=10pt]{phone72.png}}\end{array}$\texttt{\@phonenumber}\\}
			\ifthenelse{\equal{\@cellphonenumber}{\relax}}{}{$\begin{array}{l}{\includegraphics[height=10pt]{phone72.png}}\end{array}$Cell: \texttt{\@cellphonenumber}\\}
		\end{minipage}
	\end{minipage}
	}}
