\ProvidesClass{lmc}
% BY MARCOS PIRES KASSAB (02/2025)
%This class is meant to be used for qualification 
%exams, thesis, dissertations, research project,
% etc, following the "Diretrizes para Apresentação 
%de Dissertações e Teses da USP", which is based 
%on ABNT standards.


\synctex=1

% ============ Read key-val options ==============
\DeclareKeys[lmc]
{
    language.store = \lmc@language, % Captures language  option for babel
    debug.if = lmc@debug, % true = show frame and lineno (SEE IF WANT TO DISABLE COMMENTARIES)
}
\SetKeys[lmc]{language=english,
              debug=false,
              }

% ============= Load lmc wrapper class with custom arguments and the usual book class with the standard options =======================
\DeclareUnknownKeyHandler{%
    \PassOptionsToClass{\CurrentOption}{book}%
}
\ProcessKeyOptions[lmc]
% Load the base book class
\LoadClass{book}
% ===========================================

% =========== Load basic packages ============
% Font and language
\RequirePackage{subfiles}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{amsmath, amssymb, amsfonts, amsthm}
\RequirePackage[\lmc@language]{babel}
\RequirePackage{times}
\RequirePackage[font=small]{caption}
\RequirePackage{etoolbox}

% Page formating
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{emptypage}

% Text & title formating
\RequirePackage{lipsum}
\usepackage[dvipsnames]{xcolor}
\RequirePackage{pdfpages}
\RequirePackage{indentfirst}
\RequirePackage[skip=6pt, parfill]{parskip}
\RequirePackage{setspace}
\RequirePackage{titling}
\RequirePackage{titletoc}
\RequirePackage[outermarks, explicit]{titlesec}
\newenvironment{abstract}{}{} %Required before loading abstract package
\RequirePackage{abstract}
\RequirePackage{epigraph}
\setlength{\epigraphrule}{0pt}
\setlength{\epigraphwidth}{0.5\textwidth}

% Extra utilities
% Handles floats
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{tabularx}


% ========= CUSTOM DEFINITIONS ===================
% Apply 'debug' settings after options processing
\iflmc@debug
    \RequirePackage{showframe} % Show margin frames
    \RequirePackage{lineno}     % Enable line numbering
    \linenumbers
\fi

% ================== Adjust margins ===============

\newgeometry{
    offset = 0pt,		        %	Offset between layout and page border
    top = 3cm,			        %	Top margin
    bottom = 2cm,		        %	Bottom margin
    inner = 3cm,		        %	Inner margin (left if using oneside)
    outer = 2cm,		        %	Outer margin (right if using oneside)
    marginparwidth = 2.0cm, % width of paragraphs that are in the margin 
    marginparsep = 0.0cm,   % separation of margin paragraph from main text
    headheight = 15pt,	    %	Height of the header
    headsep = 22pt,		      %	Separation from text
    }

% Add some packages for notes, after geometry is set up
\RequirePackage{soul}  % Ensure soul is loaded before todonotes
\def\soulutfeight{}  % Prevents soulutf8 from being loaded
\usepackage[colorinlistoftodos,
            prependcaption,
            textsize=tiny,
            ]{todonotes}
\setuptodonotes{
    inlinewidth=\dimexpr\textwidth-30pt\relax
}            
\usepackage{pdfcomment} %loads hyperref internally

% Handle multi-file compatible w/ hyperref
\RequirePackage{xr-hyper}

\RequirePackage[nameinlink]{cleveref} % must be loaded after hyperrref

\hypersetup{
  linktoc=all,
  linkcolor=blue,       % Internal links
  citecolor=blue,       % Citations
  filecolor=blue,       % External files
  urlcolor=blue,        % URLs
  menucolor=blue,       % Menu items
  runcolor=blue,        % Run links
  anchorcolor=blue,     % Anchors
  hypertexnames=false,
  colorlinks= true
}

% =========== Adjust spacings for plain text ===========
% Raggs right and prevent hyphenation
%\raggedright
\raggedbottom
\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000

\onehalfspacing
\setlength{\parindent}{1.25cm}
%\setlength{\parskip}{6pt plus 1pt minus 1pt}
\titlespacing{\chapter}{0pt}{-24pt plus 2pt minus 2pt}{1.5pt}
\titlespacing{\section}{0pt}{1.5pt plus 0.5pt minus 0.5pt}{1.5pt}
\titlespacing{\subsection}{0pt}{1.5pt plus 0.5pt minus 0.5pt}{1.5pt}
\titlespacing{\subsubsection}{0pt}{1.5pt plus 0.5pt minus 0.5pt}{1.5pt}

\captionsetup{belowskip=0pt}

% =========== Adjust format for section titles ===========
%\titleformat{\chapter}[block]
%            {\bfseries}
%            {\thechapter. \normalsize{\MakeUppercase{#1}}\hspace*{2em}}
%            {0pt}
%            {\raggedright}
\titleformat{\chapter}[hang]
            {\normalfont\normalsize\bfseries} %format
            {\thechapter. } %label
            {0pt} %sep
            {\raggedright\MakeUppercase{#1}} %before code
\titleformat{\section}[block]
            {\bfseries}{\thesection. \normalsize{#1}}
            {0pt}
            {}
\titleformat{\subsection}[block]
            {}
            {\thesubsection. \normalsize{#1}}
            {0pt}
            {}
\titleformat{\subsubsection}
            [block]{}
            {\thesubsubsection. \textit{\normalsize{#1}}}
            {0pt}
            {}
\titleformat{name=\chapter,numberless}
            {\centering\bfseries}
            {}
            {0pt}
            {\addcontentsline{toc}{chapter}{\texorpdfstring{\uppercase{#1}}{#1}}\MakeUppercase{#1}}

% =========== SETUP TABLE OF CONTENTS ==========================
\setcounter{tocdepth}{4} % Ensure subsubsection goes to TOC
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}
\setcounter{secnumdepth}{4} % Ensure numbering goes to subsubsection

\contentsmargin[10ex]{4ex}
%\contentsmargin{-5pt}
% Define TOC entry format
\titlecontents{chapter} % Applies to \chapter entries
  [0pt]   % Left indentation
  {\bfseries}   % Format for the chapter title in TOC
  {\contentspush{\thecontentslabel. }\MakeUppercase}   % Before the number
  %{\thecontentslabel.\MakeUppercase}   % Before the number
  {}   % After the number
  {\titlerule*[3.3pt]{.}\contentspage} % Fills with dots before page number

% Define TOC entry format
\titlecontents{section} % Applies to \chapter entries
  [1.25cm]   % Left indentation
  {\bfseries }   % Above-code
  {\contentspush{\thecontentslabel. }}   %Numbered-entry format
  {}   % Numberless-entry format
  {\titlerule*[3.3pt]{.}\contentspage} % Filler page format

% Define TOC entry format
%\titlecontents{subsection} % Applies to \chapter entries
%  [1.25cm]   % Left indentation
%  {}   % Format for the chapter title in TOC
%  {\thecontentslabel. }   % Before the number
%  {}   % After the number
%  {\dotfill\hspace{0pt}\contentspage} % Fills with dots before page number
%  %[\hspace{-5pt}]

\titlecontents{subsection} % Applies to \chapter entries
  [1.25cm]   % Left indentation
  {}
  {\contentspush{\thecontentslabel. }}
  {}
  {\titlerule*[3.3pt]{.}\contentspage}
 
%Define TOC entry format
\titlecontents{subsubsection} % Applies to \chapter entries
  [1.25cm]   % Left indentation
  {}
  {\thecontentslabel. }
  {}
  {\titlerule*[3.3pt]{.}\contentspage}


% Define LOF entry format
\titlecontents{figure} % Applies to \chapter entries
  [0.00cm]   % Left indentation
  {}
  {\contentspush{Figure \thecontentslabel. } }
  {}
  {\titlerule*[3.3pt]{.}\contentspage}

% Define LOT entry format
\titlecontents{table} % Applies to \chapter entries
  [0.00cm]   % Left indentation
  {}
  {\contentspush{Table \thecontentslabel. }}
  {}
  {\titlerule*[3.3pt]{.}\contentspage}

% Change name of "Table of Contents" to "Summary"
\addto\captionsenglish{
  \renewcommand{\contentsname}
    {Summary}
}  

% Change name of "Conteúdo" to "Sumário" (PT/PT)
\addto\captionsportuguese{
  \renewcommand{\contentsname}
    {Sumário}
} 

% Change name of "Conteúdo" to "Sumário" (PT/BR)
\addto\captionsbrazil{
  \renewcommand{\contentsname}
    {Sumário}
}  

% ======== HEADING/FOOTER SETUP ================
% Pre-textual pagestyle
\fancypagestyle{pretext}{
    \fancyhf{}
    }
\makeatletter
\iflmc@debug
\@ifclasswith{book}{oneside}{
    \fancypagestyle{pretext}{
    \fancyhf{}
    \fancyhead[R]{\small PRETEXT PAGE, language is \lmc@language}
    }
    }{}
\@ifclasswith{book}{twoside}{
    \fancypagestyle{pretext}{
    \fancyhf{}
    \fancyhead[RO,LE]{\small PRETEXT PAGE, language is \lmc@language}
    }
    }{}
    \fi
\makeatother

%Empty pagestyle
\fancypagestyle{empty}{%
  \fancyhf{}% clear all header and footer fields
  \fancyfoot{}
  }
\makeatletter
\iflmc@debug
\@ifclasswith{book}{oneside}{}{
    \fancypagestyle{empty}{%
    \fancyhf{}% clear all header and footer fields
    \fancyhead[R]{\small EMPTY}
    \fancyfoot{}
    }
    }{}
\@ifclasswith{book}{twoside}{
    \fancypagestyle{empty}{%
    \fancyhf{}% clear all header and footer fields
    \fancyhead[RO, LE]{\small EMPTY}
    \fancyfoot{}
    }
    }{}
  \fi
\makeatother


\makeatletter
\@ifclasswith{book}{oneside}{
    \fancypagestyle{plain}{%
    \fancyhf{}% clear all header and footer fields
    \fancyhead[R]{\small\thepage}
    \fancyhead[L]{\small\textit\theauthor}
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
    }
    }{}
\@ifclasswith{book}{twoside}{
    \fancypagestyle{plain}{%
    \fancyhf{}% clear all header and footer fields
    \fancyhead[RO,LE]{\small\thepage}
    \fancyhead[LO,RE]{\small\textit\theauthor}
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
    }
    }{}
\makeatother

% State this to make sure that fancyhdr pagestyles are used
\pagestyle{fancy}
\pagestyle{plain}
% Make TOC, LOF and LOT with pretext pagestyle
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{pretext}}}
\AtBeginDocument{\addtocontents{lof}{\protect\thispagestyle{pretext}}}
\AtBeginDocument{\addtocontents{lot}{\protect\thispagestyle{pretext}}}

% ======== CREATE CUSTOM COMMANDS FOR 'METADATA' ======

  \newcommand{\ConcentrationArea}[1]{\def \theConcentrationArea {#1} }
  \newcommand{\Advisor}[1]{\def \theAdvisor{#1}}
  \newcommand{\Docversion}[1]{\def \theDocversion{#1}}
  \newcommand{\City}[1]{\def \theCity{#1}}
  \newcommand{\School}[1]{\def \theSchool{#1}}
  \newcommand{\Department}[1]{\def \theDepartment{#1}}
  \newcommand{\TitlePageText}[1]{\def \theTitlePageText{#1}}
  \makeatletter
  \newcommand{\theLanguage}{\lmc@language}
  \makeatother



% ==== SETUP OF ANNEX, APPENDIX AND DEBUG OPTIONS =======
\crefname{appendix}{appendix}{appendices}
\Crefname{appendix}{Appendix}{Appendices}
\crefname{annex}{annex}{annexes}
\Crefname{annex}{Annex}{Annexes}

\renewcommand{\appendix}{%
  \cleardoublepage

 \titleformat{\chapter}[hang]
              {\normalfont\normalsize\bfseries} %format
              {\MakeUppercase{\chaptername{}} \thechapter. \normalsize}
              {0pt}
              {{\MakeUppercase{##1}}}

  \renewcommand{\chaptername}{\appendixname} % Change "Chapter" to "Appendix"
  \renewcommand{\thechapter}{\Alph{chapter}} % A, B, C numbering
  \crefalias{chapter}{\appendixname}
  \setcounter{chapter}{0}  % Reset numbering
  % Define TOC entry format
  \titlecontents{chapter} % Applies to \chapter entries
  [0pt]   % Left indentation
  {\bfseries}   % Format for the chapter title in TOC
  {\contentspush{\MakeUppercase\appendixname~\thecontentslabel. }\MakeUppercase}   % Before the number
  {}   % After the number
  {\titlerule*[3.3pt]{.}\contentspage} % Fills with dots before page number
  \crefalias{chapter}{appendix} % Make cleverref name the chapter as "appendix"
}

\newcommand{\annex}{%
  \cleardoublepage

  \titleformat{\chapter}[hang]
              {\normalfont\normalsize\bfseries} %format
              {\MakeUppercase{\chaptername{}} \thechapter. \normalsize}
              {0pt}
              {{\MakeUppercase{##1}}}
  \renewcommand{\chaptername}{\annexname} % Change "Chapter" to "Annex"
  \renewcommand{\thechapter}{\Alph{chapter}} % A, B, C numbering
% Define TOC entry format
\titlecontents{chapter} % Applies to \chapter entries
[0pt]   % Left indentation
{\bfseries}   % Format for the chapter title in TOC
{\contentspush{\MakeUppercase\annexname~\thecontentslabel. }}   % Before the number
{}   % After the number
{\titlerule*[3.3pt]{.}\contentspage} % Fills with dots before page number
\setcounter{chapter}{0}  % Reset numbering
\crefalias{chapter}{\annexname} % Make cleverref name the chapter as "annex"
}

\long\def\DEBUG#1{
  \titleformat{\chapter}[hang]
  {\normalfont\normalsize\bfseries} %format
  {\MakeUppercase{\chaptername{}} \thechapter. \normalsize}
  {0pt}
  {{\MakeUppercase{##1}}}

\renewcommand{\chaptername}{DEBUG} % Change "Chapter" to "Debug"
\renewcommand{\thechapter}{DBG \Alph{chapter}} % A, B, C numbering
\crefalias{chapter}{DEBUG}
\setcounter{chapter}{0}  % Reset numbering
% Define TOC entry format
\titlecontents{chapter} % Applies to \chapter entries
[0pt]   % Left indentation
{\bfseries}   % Format for the chapter title in TOC
{\thecontentslabel. \MakeUppercase}   % Before the number
{}   % After the number
{\titlerule*[3.3pt]{.}\contentspage} % Fills with dots before page number
\crefalias{chapter}{appendix} % Make cleverref name the chapter as "appendix"  
#1}

% Define \annexname to be used with babel
\addto\captionsenglish{%
  \def\annexname{Annex}%
}

\addto\captionsbrazil{%
  \def\annexname{Anexo}%
}

\addto\captionsfrench{%
  \def\annexname{Annexe}%
}

\addto\captionsspanish{%
    \def\annexname{Anexo}%
}



% ======== SETUP OF PRE-TEXTUAL PARTS
\newcommand{\beginpretext}{\pagestyle{pretext}}
\newcommand{\beginmaintext}{\pagestyle{plain}}

%========== Setup cover =================
% Creates a cover page
\newcommand{\cover}{
    \pagestyle{pretext}
	\cleardoublepage
	\pagestyle{pretext}
	\begin{center}{\large \MakeUppercase{\theSchool} \par
        \theDepartment }\par
        \vspace{3cm}
        {\Large\theauthor} \par
        \vspace{1cm}
        {\LARGE\bfseries{\thetitle}}%\par \vspace{.5cm}
        \vfill
        \theCity\par
        \thedate
    \end{center}
    \cleardoublepage
	}

%========== Setup title page =================
% Creates a title page with an optional "ficha catalográgica" on its back-side
\newcommand{\TitlePage}[1]{
	\cleardoublepage
	\pagestyle{pretext}
	\begin{center}{ \large \MakeUppercase{\theSchool} \par
        \theDepartment }\par
        \vspace{3cm}
        {\Large{\theauthor}}\par
        \vspace{1cm}
        {\LARGE{\bfseries{\thetitle}}}
       \vspace{3cm}
        \vfill
        {\bfseries{\theDocversion}} 
        
        \vfill
        \hspace{.5\textwidth} % posicionando a minipage 
        \begin{minipage}{.4\textwidth}
            \small{\theTitlePageText}
        \end{minipage}

        \vfill
        \theCity 
        
        \thedate
    \end{center}

    % If "ficha catalográfica" is present, include it. Do nothing otherwise.
    \ifstrempty{#1}{
        % Empty: do nothing
    }{
      \includepdf{#1}%
      }

    \cleardoublepage
	}

%overrides TOC calls to force black links
\makeatletter

\newcommand{\lmc@blacklinks}[1]{%
    \begingroup
        \hypersetup{linkcolor=black}%
        #1%
    \endgroup
}

\let\lmc@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
    \lmc@blacklinks{\lmc@tableofcontents}%
}

\let\lmc@listoffigures\listoffigures
\renewcommand{\listoffigures}{%
    \lmc@blacklinks{\lmc@listoffigures}%
}

\let\lmc@listoftables\listoftables
\renewcommand{\listoftables}{%
    \lmc@blacklinks{\lmc@listoftables}%
}

\makeatother


%\newcommand{\DEBUG}[1]{#1}
\makeatletter
\iflmc@debug
\else
\renewcommand{\DEBUG}[1]{}
\fi
\makeatother
