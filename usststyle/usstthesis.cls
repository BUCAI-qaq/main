%%
%% This is file `usstthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% usstthesis.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2005-2016 by Ruini Xue <xueruini@gmail.com>
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3a
%% of this license or (at your option) any later version.
%% The latest version of this license is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3a or later is part of all distributions of LaTeX
%% version 2004/10/01 or later.
%% 
%% To produce the documentation run the original source files ending with `.dtx'
%% through LaTeX.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{usststyle/usstthesis}
[2023/10/20 5.3.1 USST University Thesis Template]
\hyphenation{usst-Thesis}
\def\usstthesis{\textsc{UsstThesis}}
\def\version{5.3.1}

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=usst,
  prefix=usst@,
  setkeys=\kvsetkeys}
\newif\ifusst@bachelor
\newif\ifusst@master
\newif\ifusst@doctor
\newif\ifusst@postdoctor
\define@key{usst}{type}{%
  \usst@bachelorfalse
  \usst@masterfalse
  \usst@doctorfalse
  \usst@postdoctorfalse
  \expandafter\csname usst@#1true\endcsname}
\def\usst@deprecated@type@option{%
  \kvsetkeys{usst}{type=\CurrentOption} % for compatability.
  \ClassError{usstthesis}{Option '\CurrentOption' is deprecated, \MessageBreak
                         please use 'type=\CurrentOption' instead}{}}
\DeclareVoidOption{bachelor}{\usst@deprecated@type@option}
\DeclareVoidOption{master}{\usst@deprecated@type@option}
\DeclareVoidOption{doctor}{\usst@deprecated@type@option}
\DeclareVoidOption{postdoctor}{\usst@deprecated@type@option}
\DeclareBoolOption{secret}
\DeclareBoolOption{arialtoc}
\DeclareBoolOption{arialtitle}
\DeclareBoolOption{raggedbottom}
\DeclareBoolOption{pifootnote}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\kvsetkeys{usst}{%
  raggedbottom,
  arialtitle}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}

\LoadClass[a4paper,openany,UTF8,zihao=-4,scheme=plain,ontset=ubuntu]{ctexbook}

\ifusst@bachelor\relax\else
  \ifusst@master\relax\else
    \ifusst@doctor\relax\else
      \ifusst@postdoctor\relax\else
        \ClassError{usstthesis}%
                   {Please specify thesis type in option: \MessageBreak
                    type=[bachelor | master | doctor | postdoctor]}{}
      \fi
    \fi
  \fi
\fi
\newcommand{\universitythesistitle}{} % 初始化全局字符串变量

\ifusst@bachelor
  \def\universitythesistitle{上海理工大学学士学位论文} % 如果是本科论文，设置全局变量为"上海理工大学学士学位论文"
\else\ifusst@master
  \def\universitythesistitle{上海理工大学硕士学位论文} % 如果是硕士论文，设置全局变量为"上海理工大学硕士学位论文"
\else\ifusst@doctor
  \def\universitythesistitle{上海理工大学博士学位论文} % 如果是博士论文，设置全局变量为"上海理工大学博士学位论文"
\else\ifusst@postdoctor
  \def\universitythesistitle{上海理工大学博士后学位论文} % 如果是博士后论文，设置全局变量为"上海理工大学博士后学位论文"
\else
  \ClassError{usstthesis}%
  {请在选项中指定论文类型：\MessageBreak type=[bachelor | master | doctor | postdoctor]}{}
\fi\fi\fi\fi
\RequirePackage{etoolbox}
\RequirePackage{ifxetex}
\RequirePackage{xparse}
\RequirePackage{amsmath}
\RequirePackage{amssymb} %% gang added
\RequirePackage[defaultsups]{newtxtext}
%\RequirePackage{newtxmath}
\RequirePackage{amsfonts}  %% gang added
\RequirePackage{tgcursor}   %% gang added 字体变为新罗马
\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{environ}
\ifusst@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
\ifusst@pifootnote
  \RequirePackage{pifont}
\fi
\RequirePackage{CJKfntef}
\ifxetex
  \def\CJK@null{\kern\CJKnullspace\Unicode{48}{7}\kern\CJKnullspace}
  \defaultfontfeatures{Mapping=tex-text}
\fi
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
% \RequirePackage[numbers,super,sort&compress]{natbib}
\RequirePackage{hyperref}
\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi
\hypersetup{%
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  colorlinks=false,
  plainpages=false,
  pdfborder=0 0 0}
\urlstyle{same}
\RequirePackage{geometry}
\geometry{
  a4paper, % 210 * 297mm
  hcentering,
  ignoreall,
  nomarginpar}
\ifusst@bachelor
  \geometry{
    left=32mm,
    headheight=5mm,
    headsep=5mm,
    textheight=220mm,
    bottom=37mm,
    footskip=17mm}
\else
  \geometry{
    left=30mm,
    right=30mm,
    headheight=5mm,
    headsep=5mm,
    textheight=237mm, 
    top=35mm,
    bottom=25mm,
    footskip=6mm}
\fi
\RequirePackage{fancyhdr}
\let\usst@cleardoublepage\cleardoublepage
\newcommand{\usst@clearemptydoublepage}{%
  \clearpage{\pagestyle{usst@empty}\usst@cleardoublepage}}
%\renewcommand\thechapter{\Alph{chapter}}  %% wang gang added  中文编号
\let\cleardoublepage\usst@clearemptydoublepage
\renewcommand\frontmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{usst@empty}}
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \ifusst@bachelor\pagestyle{usst@plain}\else\pagestyle{usst@headings}\fi}
\renewcommand\backmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
%  \abovedisplayskip=20bp \@plus 2bp \@minus 2bp
%  \abovedisplayshortskip=20bp \@plus 2bp \@minus 2bp
%  \belowdisplayskip=\abovedisplayskip
%  \belowdisplayshortskip=\abovedisplayshortskip}
\abovedisplayskip=10bp
\abovedisplayshortskip=10bp
\belowdisplayskip=\abovedisplayskip
\belowdisplayshortskip=\abovedisplayshortskip} % gang added 调整公式环境与下文的距离
\def\usst@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
\usst@def@fontsize{chuhao}{42bp}
\usst@def@fontsize{xiaochu}{36bp}
\usst@def@fontsize{yihao}{26bp}
\usst@def@fontsize{xiaoyi}{24bp}
\usst@def@fontsize{erhao}{22bp}
\usst@def@fontsize{xiaoer}{18bp}
\usst@def@fontsize{sanhao}{16bp}
\usst@def@fontsize{xiaosan}{15bp}
\usst@def@fontsize{sihao}{14bp}
\usst@def@fontsize{banxiaosi}{13bp}
\usst@def@fontsize{xiaosi}{12bp}
\usst@def@fontsize{dawu}{11bp}
\usst@def@fontsize{wuhao}{10.5bp}
\usst@def@fontsize{xiaowu}{9bp}
\usst@def@fontsize{liuhao}{7.5bp}
\usst@def@fontsize{xiaoliu}{6.5bp}
\usst@def@fontsize{qihao}{5.5bp}
\usst@def@fontsize{bahao}{5bp}
\fancypagestyle{usst@empty}{% 
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{usst@plain}{%
  \fancyhead{}
  \fancyfoot[C]{\xiaowu\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{usst@headings}{%
  \fancyhead[CO,CE]{\thepage}
  \fancyhead[CE]{{\wuhao \universitythesistitle}}
  \fancyhead[CO]{\wuhao\songti\leftmark}
  \fancyfoot{}
  \fancyfoot[C]{\wuhao\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}}
\ctexset{%
  punct=quanjiao,
  space=auto,
  autoindent=true}
\setlist{nosep}
\def\usst@textcircled#1{%
  \ifnum\value{#1} >9
    \ClassError{usstthesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \ifusst@pifootnote%
    \ding{\numexpr171+\value{#1}}%
  \else%
    \textcircled{\xiaoliu\arabic{#1}}%
  \fi}
\renewcommand{\thefootnote}{\usst@textcircled{footnote}}
\renewcommand{\thempfootnote}{\usst@textcircled{mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\usst@footnotesize\footnotesize
\renewcommand\footnotesize{\usst@footnotesize\xiaowu[1.5]}
\footnotemargin1.5em\relax
\let\usst@makefnmark\@makefnmark
\def\usst@@makefnmark{\hbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\usst@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\usst@makefnmark}{}{}
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter.\fi\@arabic\c@equation}
\def\make@df@tag{\@ifstar\usst@make@df@tag@@\make@df@tag@@@}
\def\usst@make@df@tag@@#1{\gdef\df@tag{\usst@maketag{#1}\def\@currentlabel{#1}}}
\iffalse
\ifusst@bachelor
  \def\usst@maketag#1{\maketag@@@{%
    (\ignorespaces\text{\equationname\hskip0.5em}#1\unskip\@@italiccorr)}}
  \def\tagform@#1{\maketag@@@{%
    (\ignorespaces\text{\equationname\hskip0.5em}#1\unskip\@@italiccorr)\equcaption{#1}}}
\fi
\fi
\def\usst@maketag#1{\maketag@@@{(\ignorespaces #1\unskip\@@italiccorr)}}
\def\tagform@#1{\maketag@@@{(\ignorespaces #1\unskip\@@italiccorr)\equcaption{#1}}}
\renewcommand{\eqref}[1]{\textup{(\ref{#1})}}
\theorembodyfont{\rmfamily\songti}
\theoremheaderfont{\bfseries\rmfamily\songti}
\setlength{\theorempreskipamount}{0em} %gang added 调整定理环境与上文的距离
\setlength{\theorempostskipamount}{0em}%gang added 调整定理环境与下文的距离
\setlength{\floatsep}{20bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{20bp \@plus4pt \@minus2pt}
\setlength{\textfloatsep}{20bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\ifusst@master
  \g@addto@macro\appendix{\renewcommand*{\thefigure}{\thechapter-\arabic{figure}}}
  \g@addto@macro\appendix{\renewcommand*{\thetable}{\thechapter-\arabic{table}}}
\fi 
\renewcommand{\thefigure}{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@figure} 
\renewcommand\thetable{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@table}
\let\old@tabular\@tabular
\def\usst@tabular{\dawu[1.5]\old@tabular}
\DeclareCaptionLabelFormat{usst}{{\xiaosi\songti #1~~\rmfamily #2}}  %% gang added
\DeclareCaptionLabelSeparator{usst}{\hspace{1em}}
\DeclareCaptionFont{usst}{\xiaosi}
\captionsetup{labelformat=usst,labelsep=usst,font=usst}
\captionsetup[table]{position=top,belowskip={15bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[sub]{font=usst,skip=6bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\let\usst@LT@array\LT@array
\def\LT@array{\dawu[1.5]\usst@LT@array} % set default font size
\def\hlinewd#1{%
  \noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
    \reserved@a\@xhline}
\def\usst@title@font{%
  \ifusst@arialtitle\sffamily\else\relax\fi}
\AtBeginDocument{%
  \pagestyle{usst@empty}
  \renewcommand{\chaptermark}[1]{\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}}}
\newcommand\usst@chapter@titleformat[1]{%
  \ifusst@bachelor #1\else%
    \ifthenelse%
      {\equal{#1}{\eabstractname}}%
      {\bfseries #1}%
      {#1}%
  \fi}
\ctexset{%
  chapter={
    afterindent=true,
    number={\chinese{chapter}},
    pagestyle={\ifusst@bachelor usst@plain\else usst@headings\fi},
    beforeskip={\ifusst@bachelor 13bp\else 9bp\fi},
    aftername=\hskip\ccwd,
    afterskip={\ifusst@bachelor 20bp\else 24bp\fi},
    format={\centering\usst@title@font\rmfamily\heiti\ifusst@bachelor\xiaosan\else\xiaoer[1]\fi},
    nameformat=\relax,
    numberformat=\relax,
    titleformat=\usst@chapter@titleformat,
  },
  % 根据上海理工大学博士、硕士研究生学位论文写作规范设置——牟海明
  section={
    afterindent=true,indent=0em,
    beforeskip=24bp, % 设置段前间距: 24bp 
    afterskip=6bp,   % 设置段后间距: 6bp  
    format={\bfseries\usst@title@font\rmfamily\songti\sihao[1.429]},
  },
  subsection={
    afterindent=true,indent=0em,
    beforeskip=12bp, % 设置段前间距
    afterskip=6bp,   % 设置段后间距
    format={\bfseries\usst@title@font\rmfamily\songti\ifusst@bachelor\xiaosi[1.667]\else\banxiaosi[1.538]\fi},
  },
  subsubsection={
    afterindent=true,indent=0em,
    beforeskip=6bp, % 设置段前间距
    afterskip=6bp,   % 设置段后间距
    format={\csname usst@title@font\endcsname\rmfamily\songti\xiaosi[1.667]},
  },
  paragraph/afterindent=true,
  subparagraph/afterindent=true}
\newcounter{usst@bookmark}
\NewDocumentCommand\usst@chapter{s o m o}{
  \IfBooleanF{#1}{%
    \ClassError{usstthesis}{You have to use the star form: \string\usst@chapter*}{}
  }%
  \if@openright\cleardoublepage\else\clearpage\fi\phantomsection%
  \IfValueTF{#2}{%
    \ifthenelse{\equal{#2}{}}{%
      \addtocounter{usst@bookmark}\@ne
      \pdfbookmark[0]{#3}{usstchapter.\theusst@bookmark}
    }{%
      \addcontentsline{toc}{chapter}{#3}
    }
  }{%
    \addcontentsline{toc}{chapter}{#3}
  }%
  \chapter*{#3}%
  \IfValueTF{#4}{%
    \ifthenelse{\equal{#4}{}}
    {\@mkboth{}{}}
    {\@mkboth{#4}{#4}}
  }{%
    \@mkboth{#3}{#3}
  }
}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\renewcommand\tableofcontents{%
  \usst@chapter*[]{\contentsname}
  \ifusst@bachelor\xiaosi[1.8]\else\xiaosi[1.65]\fi\@starttoc{toc}\normalsize
  }
\ifusst@arialtoc
 \def\usst@toc@font{\sffamily}  
\fi
\def\@pnumwidth{2em}
\def\@tocrmarg{\@pnumwidth}
\def\@dotsep{1}
\patchcmd{\@dottedtocline}{#4}{\csname usst@toc@font\endcsname #4}{}{}
\patchcmd{\@dottedtocline}{\hb@xt@\@pnumwidth}{\hbox}{}{}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 4bp \@plus\p@
    \setlength\@tempdima{3.5em}%  %% 章编号 与 章标题 间距
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      % numberline is called here, and it uses \@tempdima
      {\ifusst@bachelor\sffamily\else\csname usst@toc@font\endcsname\fi\songti #1}
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak{\normalfont\normalcolor #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section{%
  \@dottedtocline{1}{\ccwd}{2.1em}}
\renewcommand*\l@subsection{%
  \@dottedtocline{2}{\ifusst@bachelor 1.5\ccwd\else 2\ccwd\fi}{3em}}
\renewcommand*\l@subsubsection{%
  \@dottedtocline{3}{\ifusst@bachelor 2.4em\else 3.5em\fi}{3.8em}}
\def\usst@def@term#1{%
  \define@key{usst}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname usst@#1\endcsname{##1}}
  \csname #1\endcsname{}}
\usst@def@term{secretlevel}
\usst@def@term{secretyear}
\usst@def@term{ctitle}
\usst@def@term{etitle}
\usst@def@term{cauthor}
\usst@def@term{csupervisor}
\usst@def@term{cassosupervisor}
\usst@def@term{ccosupervisor}
\usst@def@term{eauthor}
\usst@def@term{esupervisor}
\usst@def@term{eassosupervisor}
\usst@def@term{ecosupervisor}
\usst@def@term{cdegree}
\usst@def@term{edegree}
\usst@def@term{cdepartment}
\def\caffil{% for compatibility
  \ClassWarning{usstthesis}
    {'\string\caffil' is deprecated, please use '\string\cdepartment' instead.}{}%
  \cdepartment}
\usst@def@term{edepartment}
\def\eaffil{% for compability
  \ClassWarning{usstthesis}
    {'\string\eaffil' is deprecated, please use '\string\edepartment' instead.}{}%
  \edepartment}
\usst@def@term{cmajor}
\def\csubject{% for compatibility
  \ClassWarning{usstthesis}
    {'\string\csubject' is deprecated, please use '\string\cmajor' instead.}{}%
  \cmajor}
\usst@def@term{emajor}
\def\esubject{%for compability
  \ClassWarning{usstthesis}
    {'\string\esubject' is deprecated, please use '\string\emajor' instead.}{}%
  \emajor}
\usst@def@term{cdate}
\usst@def@term{edate}
\usst@def@term{id}
\usst@def@term{udc}
\usst@def@term{catalognumber}
\usst@def@term{cfirstdiscipline}
\usst@def@term{cseconddiscipline}
\usst@def@term{postdoctordate}
\newcommand{\usst@@cabstract}[1]{\long\gdef\usst@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\usst@@cabstract}{}
\newcommand{\usst@@eabstract}[1]{\long\gdef\usst@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\usst@@eabstract}{}
\def\usst@parse@keywords#1{
  \define@key{usst}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname usst@#1\endcsname{}
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname usst@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname usst@#1\endcsname{%
          \ignorespaces\csname usst@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname usst@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\usst@parse@keywords{ckeywords}
\usst@parse@keywords{ekeywords}
\def\usstsetup{\kvsetkeys{usst}}
\newcommand\usst@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newlength{\usst@title@width}
\newcommand{\usst@put@title}[2][\usst@title@width]{%
  \begin{CJKfilltwosides}{#1}#2\end{CJKfilltwosides}}
\def\usst@first@titlepage{%
  \ifusst@postdoctor\usst@first@titlepage@postdoctor\else\usst@first@titlepage@other\fi}
\newcommand{\usst@first@titlepage@postdoctor}{
  \begin{center}
    \setlength{\usst@title@width}{3em}
    \vspace*{0.7cm}
    \begingroup\wuhao[1.5]%
    \usst@put@title{\usst@catalog@number@title}\usst@underline\usst@catalognumber\hfill%
    \usst@put@title{\usst@secretlevel}%
      \expandafter\usst@underline\ifusst@secret\usst@secret@content\else\relax\fi\par
    \usst@put@title{U D C}\usst@underline\usst@udc\hfill%
    \usst@put@title{\usst@id@title}\usst@underline\usst@id\par\vskip3cm\endgroup
    \begingroup\heiti
      {\xiaochu\ziju{1}\usst@schoolname}\par\vskip2cm
      {\xiaoyi\ziju{1}\usst@postdoctor@report@title}\par\vskip3cm
      {\sanhao[1.5]\usst@ctitle}\par\vskip2cm
      {\xiaoer\usst@cauthor}
    \endgroup
    \par\vskip3cm
    {\xiaosan[1.5]\ziju{1}\usst@schoolname\par\vskip0.5em\CJK@todaysmall@short}
  \end{center}
  \cleardoublepage
  \begin{center}
    \vspace*{2cm}
    {\sihao\heiti\usst@ctitle\par\usst@etitle}\par
    \parbox[t][7cm][b]{\textwidth-6cm}{\sihao[1.5]%
      \setlength{\usst@title@width}{11em}
      \setlength{\extrarowheight}{6pt}
      \ifxetex % todo: ugly codes
        \begin{tabular}{p{\usst@title@width}@{}l@{\extracolsep{8pt}}l}
      \else
        \begin{tabular}{p{\usst@title@width}l@{}l}
      \fi
          \usst@put@title{\usst@author@title}
            & \usst@title@sep
            & \usst@cauthor \\
          \usst@put@title{\usst@postdoctor@first@discipline@title}
            & \usst@title@sep
            & \usst@cfirstdiscipline\\
          \usst@put@title{\usst@postdoctor@second@discipline@title}
            & \usst@title@sep
            & \usst@cseconddiscipline\\
          \usst@put@title{\usst@supervisor@title}
            & \usst@title@sep
            & \usst@csupervisor\\
        \end{tabular}}
    \vskip2cm
    {\sihao\usst@postdoctor@date@title\hskip1em\underline\usst@postdoctordate}
  \end{center}}
\newcommand{\usst@first@titlepage@other}{
  \begin{center}
    \vspace*{-1.6cm}
    \parbox[b][2.4cm][t]{\textwidth}{%
      \ifusst@secret{\heiti\sanhao\usst@secretlevel\usst@secret@content}\else\rule{1cm}{0cm}\fi}
    \ifusst@bachelor
      \vskip0.45cm
      {\includegraphics{tsinghua}}
      \par\vskip1.5cm
      {\xiaochu\heiti\ziju{0.5}\usst@bachelor@subtitle}
      \vskip2.2cm
      \noindent\heiti\xiaoer\usst@bachelor@title@pre\usst@title@sep
      \parbox[t]{12cm}{%
      \ignorespaces\yihao[1.55]%
      \renewcommand{\CJKunderlinebasesep}{0.25cm}%
      \renewcommand{\ULthickness}{1.3pt}%
      \ifxetex
        \xeCJKsetup{underline/format=\color{black}}%
      \else
        \def\CJKunderlinecolor{\color{black}}%
      \fi
      \CJKunderline*{\usst@ctitle}}%
      \vskip1.3cm
    \else
      \vskip0.8cm
      \parbox[t][9cm][t]{\paperwidth-8cm}{
      \renewcommand{\baselinestretch}{1.3}
      \begin{center}
      \yihao[1.2]{\sffamily\heiti\usst@ctitle}\par
      \par\vskip 18bp
      \xiaoer[1] \textrm{\usst@apply}
      \end{center}}
    \fi
    \ifusst@bachelor
      \vskip1cm
      \parbox[t][7.0cm][t]{\textwidth}{%
        {\fangsong\sanhao[1.8]%
         \hspace*{1.65cm}
         \setlength{\usst@title@width}{4em}
         \setlength{\extrarowheight}{6pt}
         \ifxetex % todo: ugly codes
           \begin{tabular}{p{\usst@title@width}@{}l@{\extracolsep{8pt}}l}
         \else
           \begin{tabular}{p{\usst@title@width}l@{}l}
         \fi
             \usst@put@title{\usst@department@title} & \usst@title@sep
               & \usst@cdepartment\\
             \usst@put@title{\usst@major@title}      & \usst@title@sep
               & \usst@cmajor\\
             \usst@put@title{\usst@author@title}     & \usst@title@sep
               & \usst@cauthor \\
             \usst@put@title{\usst@supervisor@title} & \usst@title@sep
               & \usst@csupervisor\\
             \ifx\usst@cassosupervisor\@empty\else%
               \usst@put@title{\usst@assosuper@title} & \usst@title@sep
               & \usst@cassosupervisor\\
             \fi
           \end{tabular}
        }}
    \else
      \vskip 5bp
      \parbox[t][7.8cm][t]{\textwidth}{{\sanhao[1.5]
        \begin{center}\fangsong
          \setlength{\usst@title@width}{5em}
          \setlength{\extrarowheight}{4pt}
          \ifxetex % todo: ugly codes
            \begin{tabular}{p{\usst@title@width}@{}c@{\extracolsep{8pt}}l}
          \else
            \begin{tabular}{p{\usst@title@width}c@{\extracolsep{4pt}}l}
          \fi
              \usst@put@title{\usst@department@title}  & \usst@title@sep
                & {\ziju{0.1875}\usst@cdepartment}\\
              \usst@put@title{\usst@major@title}       & \usst@title@sep
                & {\ziju{0.1875}\usst@cmajor}\\
              \usst@put@title{\usst@author@title}      & \usst@title@sep
                & {\ziju{0.6875}\usst@cauthor}\\
              \usst@put@title{\usst@supervisor@title}  & \usst@title@sep
                & {\ziju{0.6875}\usst@csupervisor}\\
              \ifx\usst@cassosupervisor\@empty\else
                \usst@put@title{\usst@assosuper@title} & \usst@title@sep
                & {\ziju{0.6875}\usst@cassosupervisor}\\
              \fi
              \ifx\usst@ccosupervisor\@empty\else
                \hfill\makebox[0pt][r]{\usst@cosuper@title} & \usst@title@sep
                & {\ziju{0.6875}\usst@ccosupervisor}\\
              \fi
            \end{tabular}
        \end{center}}}
      \fi
     \begin{center}
       {\ifusst@bachelor\vskip-1.0cm\hskip-1.2cm\xiaosi\else%
         \vskip-0.5cm\sanhao\fi%
         \songti\usst@cdate}
     \end{center}
    \end{center}} % end of titlepage
\newcommand{\usst@engcover}{%
  \newif\ifusst@professional\usst@professionalfalse
  \ifusst@master
    \ifthenelse{\equal{\usst@edegree}{\usst@master@art}}
      {\relax}
      {\ifthenelse{\equal{\usst@edegree}{\usst@master@sci}}
        {\relax}
        {\usst@professionaltrue}}
  \fi
  \ifusst@doctor
    \ifthenelse{\equal{\usst@edegree}{\usst@doctor@phi}}
      {\relax}
      {\usst@professionaltrue}
  \fi
  \begin{center}
    \vspace*{-5pt}
    \parbox[t][5.2cm][t]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
        \erhao[1.1]\bfseries\sffamily\usst@etitle
      \end{center}}
    \parbox[t][][t]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.3}
      \begin{center}
        \sanhao
        \ifusst@master Thesis \else Dissertation \fi
        Submitted to\\
        {\bfseries  University of Shanghai for Science and Technology}\\
        in partial fulfillment of the requirement\\
        for the \ifusst@professional professional \fi
        degree of\\
        {\bfseries\sffamily\usst@edegree}
        \ifusst@professional\relax\else
          \\in\\[3bp]
          {\bfseries\sffamily\usst@emajor}
        \fi
      \end{center}}
    \parbox[t][][b]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.3}
      \begin{center}
        \sanhao\sffamily by\\[3bp]
        \bfseries\usst@eauthor
        \ifusst@professional
          \ifx\usst@emajor\empty\relax\else
            \\(~\usst@emajor~)
        \fi\fi
      \end{center}}
    \par\vspace{0.9cm}
    \parbox[t][2.1cm][t]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.2}\xiaosan\centering
      \begin{tabular}{rl}
        \ifusst@master Thesis \else Dissertation \fi
        Supervisor : & \usst@esupervisor\\
        \ifx\usst@eassosupervisor\@empty
          \else Associate Supervisor : & \usst@eassosupervisor\\\fi
        \ifx\usst@ecosupervisor\@empty
          \else Cooperate Supervisor : & \usst@ecosupervisor\\\fi
      \end{tabular}}
    \parbox[t][2cm][b]{\paperwidth-7.2cm}{
    \begin{center}
      \sanhao\bfseries\sffamily\usst@edate
    \end{center}}
  \end{center}}
\newcommand{\usst@authorization@mk}{%
  \ifusst@bachelor\vspace*{0.2cm}\else\vspace*{0.42cm}\fi % shit code!
  \begin{center}\erhao\heiti\usst@authtitle\end{center}
  \ifusst@bachelor\vskip5pt\else\vskip40pt\sihao[2.03]\fi\par
  \usst@authorization\par
  \textbf{\usst@authorizationaddon}\par
  \ifusst@bachelor\vskip0.7cm\else\vskip1.0cm\fi
  \ifusst@bachelor
    \indent\mbox{\usst@authorsig\usst@underline\relax%
    \usst@teachersig\usst@underline\relax\usst@frontdate\usst@underline\relax}
  \else
    \begingroup
      \parindent0pt\xiaosi
      \hspace*{1.5cm}\usst@authorsig\usst@underline[7em]\relax\hfill%
                     \usst@teachersig\usst@underline[7em]\relax\hspace*{1cm}\\[3pt]
      \hspace*{1.5cm}\usst@frontdate\usst@underline[7em]\relax\hfill%
                     \usst@frontdate\usst@underline[7em]\relax\hspace*{1cm}
    \endgroup
  \fi}
% \def\makecover{%
%   \usst@setup@pdfinfo\usst@makecover}
% \def\usst@setup@pdfinfo{%
%   \hypersetup{%
%     pdftitle={\usst@ctitle},
%     pdfauthor={\usst@cauthor},
%     pdfsubject={\usst@cdegree},
%     pdfkeywords={\usst@ckeywords},
%     pdfcreator={\usstthesis-v\version}}}
% \NewDocumentCommand{\usst@makecover}{o}{
%   \phantomsection
%   \pdfbookmark[-1]{\usst@ctitle}{ctitle}
%   \normalsize%
%   \begin{titlepage}
%     \usst@first@titlepage
%     \ifusst@bachelor\relax\else
%       \ifusst@postdoctor\relax\else
%         \cleardoublepage\usst@engcover
%     \fi\fi
%     \ifusst@postdoctor\relax\else%
%       \ifusst@bachelor\clearpage\else\cleardoublepage\fi%
%       \IfNoValueTF{#1}{%
%         \ifusst@bachelor\usst@authorization@mk\else%
%           \begin{list}{}{%
%             \topsep\z@%
%             \listparindent\parindent%
%             \parsep\parskip%
%             \setlength{\leftmargin}{0.9mm}%
%             \setlength{\rightmargin}{0.9mm}}%
%           \item[]\usst@authorization@mk%
%           \end{list}%
%         \fi%
%       }{%
%         \includepdf{#1}%
%       }%
%     \fi
%   \end{titlepage}
%   \normalsize
%   \usst@makeabstract
%   \let\@tabular\usst@tabular}

\def\makecover{\usst@makecover}
\NewDocumentCommand{\usst@makecover}{o}{
  \phantomsection
  \normalsize
  \usst@makeabstract
  \let\@tabular\usst@tabular}
  
\newbox\usst@kw
\newcommand\usst@put@keywords[2]{%
  \begingroup
    \setbox\usst@kw=\hbox{#1}
    \ifusst@bachelor\indent\else\noindent\hangindent\wd\usst@kw\hangafter1\fi%
    \box\usst@kw#2\par
  \endgroup}
  
\newcommand{\usst@makeabstract}{%
  \ifusst@bachelor\clearpage\else\cleardoublepage\fi
  \usst@chapter*[]{\cabstractname} % no tocline
  \ifusst@bachelor
    \pagestyle{usst@plain}
  \else
    \pagestyle{usst@headings}
  \fi  
  % \pagenumbering{Roman}% 如果需要罗马数字页码，可以保留这一行
  \usst@cabstract
  \vskip12bp
  \usst@put@keywords{\textbf{\songti{\usst@ckeywords@title}}}{\textbf{\usst@ckeywords}}
  \usst@chapter*[]{\eabstractname} % no tocline
  \usst@eabstract
  \vskip12bp
  \usst@put@keywords{%
    \textbf{\ifusst@bachelor Keywords:\else Key Words:\fi\enskip}}{\textbf{\usst@ekeywords}}}

\newenvironment{denotation}[1][2.5cm]{%
  \usst@chapter*[]{\usst@denotation@name} % no tocline
  \vskip-30bp\xiaosi[1.6]\begin{usst@denotation}[labelwidth=#1]
}{%
  \end{usst@denotation}
}
\newlist{usst@denotation}{description}{1}
\setlist[usst@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\NewDocumentEnvironment{acknowledgement}{o}{%
    \usst@chapter*{\usst@ackname}
  }
  {
    
  }
%\let\ack\acknowledgement
%\let\endack\endacknowledgement
\def\usst@starttoc#1{% #1: float type, prepend type name in \listof*** entry.
  \let\oldnumberline\numberline
  \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
  \@starttoc{\csname ext@#1\endcsname}
  \let\numberline\oldnumberline}
\def\usst@listof#1{% #1: float type
  \@ifstar
    {\usst@chapter*[]{\csname list#1name\endcsname}\usst@starttoc{#1}}
    {\usst@chapter*{\csname list#1name\endcsname}\usst@starttoc{#1}}}
\renewcommand\listoffigures{\usst@listof{figure}}
\renewcommand*\l@figure{\addvspace{6bp}\@dottedtocline{1}{0em}{4em}}
\renewcommand\listoftables{\usst@listof{table}}
\let\l@table\l@figure
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\usst@listof{equation}}
\let\l@equation\l@figure

\let\usst@appendix\appendix
\renewenvironment{appendix}{%
  \let\title\usst@appendix@title
  \usst@appendix}{%
  \let\title\@gobble}
\let\title\@gobble
\newcommand{\usst@appendix@title}[1]{%
  \begin{center}
    \bfseries\xiaosi #1
  \end{center}}
\newlist{translationbib}{enumerate}{1}
\setlist[translationbib]{label=[\arabic*],align=left,nosep,itemsep=6bp,
  leftmargin=10mm,labelsep=!,before=\vspace{0.5\baselineskip}\wuhao[1.3]}
\newenvironment{resume}[1][\usst@resume@title]{%
  \usst@chapter*{#1}}{}
\newcommand{\resumeitem}[1]{%
  \vspace{24bp}{\sihao\heiti\centerline{#1}}\par\vspace{6bp}}
\newcommand{\researchitem}[1]{%
  \vspace{24bp}{\sihao\heiti{#1}}\par\vspace{12bp}}
\newlist{publications}{enumerate}{1}
\setlist[publications]{label=[\arabic*],align=left,nosep,itemsep=8bp,
  leftmargin=10mm,labelsep=!,before=\xiaosi[1.26],resume}
\newlist{achievements}{enumerate}{1}
\setlist[achievements]{label=[\arabic*],align=left,nosep,itemsep=8bp,
  leftmargin=10mm,labelsep=!,before=\xiaosi[1.26]}
\def\publicationskip{\bigskip\bigskip}
\NewDocumentCommand{\shuji}{O{\usst@ctitle} O{\usst@cauthor}}{%
  \newpage\thispagestyle{empty}\fangsong\xiaosan\ziju{0.4}%
  \noindent\hfill\rotatebox[origin=lt]{-90}{\makebox[\textheight]{#1\hfill#2}}}
    

%% BEGIN BIBLATEX SETTINGS
\usepackage[backend=biber,doi=false,url=true,style=gb7714-2015,firstinits=true,sorting=none,maxnames=3,minnames=3]{biblatex}
\DeclareNameAlias{author}{last-first}
\AtEveryBibitem{\clearfield{month}}
\AtEveryCitekey{\clearfield{month}}
 \AtEveryBibitem{\clearfield{issn}}

%\DeclareFieldFormat{titlecase}{\MakeSentenceCase*{#1}}
%\DeclareFieldFormat{titlecase}{\MakeSentenceCase{#1}}
\DeclareFieldFormat{sentencecase}{\MakeSentenceCase*{#1}}

\renewcommand*{\revsdnamepunct}{}
\renewrobustcmd*{\bibinitperiod}{}
\renewcommand*{\finalnamedelim}{\multinamedelim}

\DeclareFieldFormat*{title}{#1}
\DeclareFieldFormat*{journaltitle}{#1\isdot}
\DeclareFieldFormat*{issuetitle}{#1}
\DeclareFieldFormat*{maintitle}{#1}
\DeclareFieldFormat*{booktitle}{#1}
\renewbibmacro*{title}{%
  \ifboolexpr{
    test {\iffieldundef{title}}
    and
    test {\iffieldundef{subtitle}}
  }
    {}
    {\printtext[title]{%
       \printfield[sentencecase]{title}%
       \setunit{\subtitlepunct}%
       \printfield[sentencecase]{subtitle}}%
     \ifentrytype{article}{\setunit{}\printtext{[J]}}{}%
     \ifentrytype{book}{\setunit{}\printtext{[B]}}{}%
     \ifentrytype{inproceedings}{\setunit{}\printtext{[C]}}{}%
     \ifentrytype{thesis}{\setunit{}\printtext{[D]}}{}%
      \ifentrytype{incollection}{\setunit{}\printtext{[B]}}{}%
     \newunit}%
  \printfield{titleaddon}}
 
\renewbibmacro*{in:}{\ifentrytype{article}{}{\printtext{//}}}

\renewbibmacro*{journal+issuetitle}{%
  \usebibmacro{journal}%
  \iffieldundef{series}
    {}
    {\newunit
     \printfield{series}}%
  \setunit{\addcomma\space}%
  \printfield{issue}%
  \setunit{\addcomma\space}%
  \usebibmacro{date}
  \setunit{\addcolon\space}%
  \usebibmacro{issue}%
  \setunit{\addcomma\space}%
  \usebibmacro{volume+number+eid}%
  \setunit{\addspace}%
  \newunit}

\DeclareFieldFormat[article,periodical]{number}{\mkbibparens{#1}}
\renewbibmacro*{volume+number+eid}{%
  \printfield{volume}%
  \printfield{number}%
  \setunit{\addcomma\space}%
  \printfield{eid}}

\DeclareFieldFormat{pages}{#1}
\DeclareFieldFormat{postnote}{#1}
\DeclareFieldFormat{multipostnote}{#1}
\renewcommand*{\bibpagespunct}{\addcolon\addspace}
\renewcommand{\postnotedelim}{%
  \iffieldpages{postnote}
    {\addcolon\space}
    {\addspace}}

\AtEndOfClass{\input{usststyle/usstthesis.cfg}}
\AtEndOfClass{\sloppy}
\endinput
%%


    
%% End of file `usstthesis.cls'.
