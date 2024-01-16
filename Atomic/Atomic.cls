%---setup
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Atomic}
\LoadClass[openany]{book}

%---packages
\RequirePackage[pages=some]{background}
\RequirePackage{tikz}
\RequirePackage[svgnames]{xcolor}
\RequirePackage{eso-pic}
\RequirePackage{setspace}
\RequirePackage{makeidx}
\RequirePackage[a4paper]{geometry}
\RequirePackage[linktoc=all,bookmarksnumbered,pagebackref]{hyperref}
\RequirePackage{color}
\RequirePackage{titlesec}
\RequirePackage{xhfill}
\RequirePackage{fancyhdr}
\RequirePackage{xpatch}
\RequirePackage{minitoc}
\RequirePackage{emptyPage}
\RequirePackage{float}
%\RequirePackage{ctex} %uncomment for Chinese documents

%---Basic infos
%set colors
\newcommand{\setThemeColor}[1]{\def\themeColor{#1}}
\newcommand{\setLinkColor}[1]{\def\linkColor{#1}}
%---title page
\newcommand{\setTitle}[1]{\def\@myTitle{#1}}
\newcommand{\setSummary}[1]{\def\@mySummary{#1}}
\newcommand{\setBackground}[1]{\def\@myBackground{#1}}

\renewcommand*{\maketitle}{%
\begin{titlepage}
\insertCover%comment this out if there is no background image
%draw the banner
    \begin{tikzpicture}[remember picture,overlay]
        %primary
        \node [rectangle, fill=\themeColor, anchor=south, minimum width=\paperwidth, minimum height=10cm, opacity = 0.8] (primary) at (current page.south) {};
        %secondary shadow
        \node [rectangle, fill=black, anchor=center, minimum width=\paperwidth, minimum height=6.2cm, opacity = 0.9] (secondaryShadow) at (primary.center) {};
        %secondary
        \node [rectangle, fill=white, anchor=center, minimum width=\paperwidth, minimum height=6cm, opacity = 0.9] (box) at (secondaryShadow.center) {};
    \end{tikzpicture}

    \begin{center}
        \vspace{21cm}
        \huge
        \textbf{\@myTitle}\\
        \rule{10cm}{.4pt}\\
        \vspace{0.2cm}
        \large
        \textbf{\@mySummary}
    \end{center}
\end{titlepage}
}
%---begin document setup
\AtBeginDocument{
    %---chapter head setup
    \titleformat{\chapter}[display]
    {\filcenter}
    {\mbox{}
    %\xrfill[0.4ex]{3pt}[rulecolor]
    \textsc{\large\enspace\chaptername~\thechapter
    }
    \vspace{0.2cm}
    %\xrfill[0.4ex]{3pt}[rulecolor]
    \mbox{}}{0.3ex} {{\color{\themeColor}\rule{10cm}{1pt}\\
    }
    \vskip3ex\huge\bfseries
    }
    [\medskip{\color{\themeColor}\rule{10cm}{1pt}}]
    %---header footer setup
    \pagestyle{fancy}
    \fancyhead{}\fancyfoot{}
    \renewcommand{\headrulewidth}{1pt}
    \renewcommand{\footrulewidth}{1pt}
    \xpretocmd\headrule{\color{\themeColor}}{}{\PatchFailed}
    \xpretocmd\footrule{\color{\themeColor}}{}{\PatchFailed}
    %headers
    \fancyhead[L]{\toChapter}%link to the start of the chapter at left header
    \fancyhead[C]{\@myTitle}
    \fancyhead[R]{\toSection}
    %footers
    \fancyfoot[L]{\toChapter}%link to the start of the chapter at left header
    \fancyfoot[C]{\thepage}
    \fancyfoot[R]{\toSection}
    %---setup minitoc
    \dominitoc
    \mtcsetrules{*}{off}
}
%---begin chapter setup
\apptocmd\@chapter{
    \minitoc%mini table of contents
   }{}{\FAILED}
%---commands
%draw line
\newcommand{\quickRule}{\color{\themeColor}\rule{.8\textwidth}{.4pt}\color{black}}
%draw cover as background
\newcommand{\insertCover}{
\backgroundsetup{
    scale=1,
    color=black,
    opacity=1,
    angle=0,
    contents={%
      \includegraphics[width=\paperwidth,height=\paperheight]{\@myBackground}
    }%
}
\BgThispage
}
%draw link to current chapter
\newcommand{\toChapter}{
    \hyperlink{chapter.\arabic{chapter}}
    {\chaptername~\thechapter\ --\ \leftmark}
}
%draw link to current section
\newcommand{\toSection}{
    \hyperlink{section.\arabic{chapter}.\arabic{section}}
    {\rightmark}
}
%quick insert images
\newcommand{\singleImg}[4]{
	\begin{figure}[h]
		\centering
		\includegraphics[scale = #2]{#1}\\
		\quickRule
		\caption{#3}
		\label{fig:#4}
	\end{figure}
}
%---renew commands
\renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}