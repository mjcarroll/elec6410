<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp " "> ]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:escape="http://www.mathworks.com/namespace/latex/escape"
  xmlns:mwsh="http://www.mathworks.com/namespace/mcode/v1/syntaxhighlight.dtd">
<xsl:output method="text" indent="no"/>

<xsl:template match="mscript">
% This LaTeX was auto-generated from an M-file by MATLAB.
% To make changes, update the M-file and republish this document.

\documentclass[11pt]{article}
\usepackage{amsmath,amsfonts,amsthm,amssymb}
\usepackage{fullpage,fancyhdr}
\usepackage[pdftex]{graphicx}
\usepackage[usenames,dvipsnames]{color}
\usepackage{listings}
\usepackage{courier}
\usepackage{ifthen}
\usepackage{setspace}
\usepackage{lastpage}
\usepackage{extramarks}
\usepackage{chngpage}
\usepackage{soul}
\usepackage{graphicx,float,wrapfig}
\usepackage{epstopdf}
\usepackage{geometry}
\usepackage{pdfcolmk}
\usepackage{hyperref}
\DeclareGraphicsRule{.tif}{png}{.png}{`convert #1 `dirname #1`/`basename #1 .tif`.png}

\definecolor{lightgray}{gray}{0.5}
\definecolor{darkgray}{gray}{0.3}
\definecolor{MyDarkGreen}{rgb}{0.0,0.4,0.0}

\topmargin=-0.45in      %
\evensidemargin=0in     %
\oddsidemargin=0in      %
\textwidth=6.5in        %
\textheight=9.0in       %
\headsep=0.25in         %

\pagestyle{fancyplain}

% For faster processing, load Matlab syntax for listings
\lstloadlanguages{Matlab}%
\lstset{language=Matlab,
        frame=single,
        basicstyle=\ttfamily,
        keywordstyle=[1]\color{Blue}\bf,
        keywordstyle=[2]\color{Purple},
        keywordstyle=[3]\color{Blue}\underbar,
        identifierstyle=,
        commentstyle=\usefont{T1}{pcr}{m}{sl}\color{MyDarkGreen}\small,
        stringstyle=\color{Purple},
        showstringspaces=false,
        tabsize=5,
        % Put standard MATLAB functions not included in the default
        % language here
        morekeywords={xlim,ylim,var,alpha,factorial,poissrnd,normpdf,normcdf},
        % Put MATLAB function parameters here
        morekeywords=[2]{on, off, interp},
        % Put user defined functions here
        morekeywords=[3]{FindESS},
        morecomment=[l][\color{Blue}]{...},
        numbers=left,
        firstnumber=1,
        numberstyle=\tiny\color{Blue},
        stepnumber=5
        }

 
\fancyhf{}
 
\lhead{\fancyplain{}{Michael Carroll}}
\chead{\fancyplain{}{ELEC6410 - DSP}}
\rhead{\fancyplain{}{\today}}
\rfoot{\fancyplain{}{\thepage\ of \pageref{LastPage}}}

     <!-- Determine if the there should be an introduction section. -->
     <xsl:variable name="hasIntro" select="count(cell[@style = 
'overview'])"/>
     <xsl:if test = "$hasIntro">
      \title{<xsl:apply-templates select="cell[1]/steptitle"/>\\
      {\large <xsl:apply-templates select="cell[1]/text"/>}}
      \author{Michael J. Carroll}
     </xsl:if>

\begin{document}
   \maketitle

     <xsl:variable name="body-cells" select="cell[not(@style = 
'overview')]"/>

     <!-- Include contents if there are titles for any subsections. 
     <xsl:if test="count(cell/steptitle[not(@style = 'document')])">
   \tableofcontents
     </xsl:if>
     -->

     <!-- Loop over each cell -->
     <xsl:for-each select="$body-cells">
         <!-- Title of cell -->
         <xsl:if test="steptitle">
           <xsl:variable name="headinglevel">
             <xsl:choose>
               <xsl:when test="steptitle[@style = 
'document']">section</xsl:when>
               <xsl:otherwise>subsection</xsl:otherwise>
             </xsl:choose>
           </xsl:variable>

\<xsl:value-of select="$headinglevel"/>*{<xsl:apply-templates 
select="steptitle"/>}

</xsl:if>

         <!-- Contents of each cell -->
         <xsl:apply-templates select="text"/>
         <xsl:apply-templates select="mcode"/>
         <xsl:apply-templates select="mcodeoutput"/>
         <xsl:apply-templates select="img"/>
% end of cell

     </xsl:for-each>


<xsl:if test="copyright">
\begin{par} \footnotesize \color{lightgray} \begin{flushright}
\emph{<xsl:apply-templates select="copyright"/>}
\end{flushright} \color{black} \normalsize \end{par}
</xsl:if>


\end{document}

</xsl:template>



<!-- HTML Tags in text sections -->
<xsl:template match="p">

<xsl:apply-templates/><xsl:text></xsl:text>
</xsl:template>

<xsl:template match="ul">\begin{itemize}
\setlength{\itemsep}{-1ex}
<xsl:apply-templates/>\end{itemize}
</xsl:template>
<xsl:template match="ol">\begin{enumerate}
\setlength{\itemsep}{-1ex}
<xsl:apply-templates/>\end{enumerate}
</xsl:template>
<xsl:template match="li"> \item <xsl:apply-templates/><xsl:text>
</xsl:text></xsl:template>
<xsl:template match="pre">
   <xsl:choose>
     <xsl:when test="@class='error'">
\begin{verbatim}<xsl:value-of select="."/>\end{verbatim}
     </xsl:when>
     <xsl:otherwise>
\begin{verbatim}<xsl:value-of select="."/>\end{verbatim}
     </xsl:otherwise>
   </xsl:choose>
</xsl:template>
<xsl:template match="b">\textbf{<xsl:apply-templates/>}</xsl:template>
<xsl:template match="tt">\texttt{<xsl:apply-templates/>}</xsl:template>
<xsl:template match="i">\textit{<xsl:apply-templates/>}</xsl:template>
<xsl:template match="a">\begin{verbatim}<xsl:value-of 
select="."/>\end{verbatim}</xsl:template>

<xsl:template match="text()">
   <!-- Escape special characters in text -->
   <xsl:call-template name="replace">
     <xsl:with-param name="string" select="."/>
   </xsl:call-template>
</xsl:template>

<xsl:template match="equation">
<xsl:value-of select="."/>
</xsl:template>


<!-- Code input and output -->

<xsl:template match="mcode">\begin{lstlisting}[language=matlab]
<xsl:value-of select="."/>
\end{lstlisting}
</xsl:template>

<xsl:template match="mcodeoutput">
   {\color{lightgray} \small\begin{verbatim}<xsl:value-of 
select="."/>\end{verbatim} }
</xsl:template>


<!-- Figure and model snapshots -->

<xsl:template match="img">
\begin{figure}[here]
	\begin{center}
		\includegraphics [width=4in]{<xsl:value-of select="@src"/>}
		\caption{}
		\label{fig:}
	\end{center}
\end{figure}
</xsl:template>

<!-- Colors for syntax-highlighted input code -->

<xsl:template 
match="mwsh:code">\begin{verbatim}<xsl:apply-templates/>\end{verbatim}
</xsl:template>
<xsl:template match="mwsh:keywords">
   <span class="keyword"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:strings">
   <span class="string"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:comments">
   <span class="comment"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:unterminated_strings">
   <span class="untermstring"><xsl:value-of select="."/></span>
</xsl:template>
<xsl:template match="mwsh:system_commands">
   <span class="syscmd"><xsl:value-of select="."/></span>
</xsl:template>


<!-- Used to escape special characters in the LaTeX output. -->

<escape:replacements>
   <!-- special TeX characters -->
   <replace><from>$</from><to>\$</to></replace>
   <replace><from>&amp;</from><to>\&amp;</to></replace>
   <replace><from>%</from><to>\%</to></replace>
   <replace><from>#</from><to>\#</to></replace>
   <replace><from>_</from><to>\_</to></replace>
   <replace><from>{</from><to>\{</to></replace>
   <replace><from>}</from><to>\}</to></replace>
   <!-- mainly in code -->
   <replace><from>~</from><to>\ensuremath{\tilde{\;}}</to></replace>
   <replace><from>^</from><to>\^{}</to></replace>
   <replace><from>\</from><to>\ensuremath{\backslash}</to></replace>
   <!-- mainly in math -->
   <replace><from>|</from><to>\ensuremath{|}</to></replace>
   <replace><from>&lt;</from><to>\ensuremath{&lt;}</to></replace>
   <replace><from>&gt;</from><to>\ensuremath{&gt;}</to></replace>
</escape:replacements>

<xsl:variable name="replacements" 
select="document('')/xsl:stylesheet/escape:replacements/replace"/>

<xsl:template name="replace">
   <xsl:param name="string"/>
   <xsl:param name="next" select="1"/>

   <xsl:variable name="count" select="count($replacements)"/>
   <xsl:variable name="first" select="$replacements[$next]"/>
   <xsl:choose>
     <xsl:when test="$next > $count">
       <xsl:value-of select="$string"/>
     </xsl:when>
     <xsl:when test="contains($string, $first/from)">
       <xsl:call-template name="replace">
         <xsl:with-param name="string"
                         select="substring-before($string, $first/from)"/>
         <xsl:with-param name="next" select="$next+1" />
       </xsl:call-template>
       <xsl:copy-of select="$first/to" />
       <xsl:call-template name="replace">
         <xsl:with-param name="string"
                         select="substring-after($string, $first/from)"/>
         <xsl:with-param name="next" select="$next"/>
       </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       <xsl:call-template name="replace">
         <xsl:with-param name="string" select="$string"/>
         <xsl:with-param name="next" select="$next+1"/>
       </xsl:call-template>
     </xsl:otherwise>
   </xsl:choose>
</xsl:template>

</xsl:stylesheet>
