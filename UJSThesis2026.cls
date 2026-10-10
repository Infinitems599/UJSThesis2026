%% =====================================================================
%% 江苏大学本科毕业设计（论文）LaTeX 模板 —— 2026 版
%%
%% 严格依照下列文件实现：
%%   《江苏大学毕业设计（论文）写作规范（2026）》（附件 2）
%%   《江苏大学毕业设计（论文）通用格式模板（理工农医教）2026 版》（附件 3）
%%
%% 编译方式：XeLaTeX + BibTeX（必须）
%%     xelatex main
%%     bibtex  main
%%     xelatex main
%%     xelatex main
%%
%% 本文件由 UJS_thesis-master（2023 旧版）的 UJSBachelor.cls 改写而来。
%% =====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UJSThesis2026}[2026/01/01 v2026 Jiangsu University bachelor thesis]

%%% ------------------------------------------------------------------
%%% 一、基类与页面
%%% ------------------------------------------------------------------
\LoadClass[a4paper,openany,oneside]{book}   % A4（210mm*297mm）、单面印刷、左侧装订

\RequirePackage[AutoFakeBold=2.5,AutoFakeSlant=0.2]{xeCJK}
\RequirePackage{xeCJKfntef}   % 提供 \textsuperscript 等 CJK 感知的装饰命令
\RequirePackage[zihao=-4,UTF8,heading=true,fontset=windows]{ctex}

% 页面设置（规范：上方天头 25mm，左侧订口 25mm，下方地脚 20mm，右侧切口 20mm）
\RequirePackage{geometry}
\geometry{
  a4paper,
  top=25mm, bottom=20mm, left=25mm, right=20mm,
  headheight=16pt, headsep=5.5mm, footskip=27pt,
  includefoot
}

%%% ------------------------------------------------------------------
%%% 二、字体（中文宋体/黑体，西文与数字 Times New Roman）
%%%    西文字体在第九节载入 newtxmath 之后统一设置，见该处说明。
%%% ------------------------------------------------------------------
\RequirePackage{etoolbox}

%%% ------------------------------------------------------------------
%%% 三、行距与段落
%%%    正文：1.5 倍行距（小四 12pt -> 18pt 基线），首行缩进 2 字符
%%% ------------------------------------------------------------------
\RequirePackage{setspace}
\setstretch{1.6}
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\AtBeginDocument{\setlength{\abovedisplayskip}{6pt}\setlength{\belowdisplayskip}{6pt}}

%%% ------------------------------------------------------------------
%%% 四、页眉页脚
%%%    封面无页眉页码；
%%%    原创性声明等前置页：左侧页眉标题 + 右侧“江苏大学本科毕业设计（论文）”，宋体六号；
%%%    正文起：仅右侧“江苏大学本科毕业设计（论文）”（宋体六号）；
%%%    页眉文字下方加一根 0.5pt 横线（\headrule）；
%%%    前置页页码为大写罗马数字，正文起为阿拉伯数字，小五号 Times New Roman 居中。
%%% ------------------------------------------------------------------
\RequirePackage{fancyhdr}
\renewcommand{\footrulewidth}{0pt}
%% 页眉横线：0.75pt，紧贴页眉文字下方（\headruleskip=0）。
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headruleskip}{0pt}
%% 页眉整体上移量。
%% 附件 3 页眉汉字在 y 44.28..52.56；本模板原在 46.44..54.18，偏低 2.16pt。
%% 用 \raisebox 把文字与横线一起抬起，不改 headheight/headsep，故版心首行不动。
\newcommand{\ujs@headraise}{0pt}

% 页面左侧栏目标题（前置页页眉用）
\newcommand{\ujs@headleft}{}
\newcommand{\ujsheadleft}[1]{\gdef\ujs@headleft{#1}}
% 正文页眉统一文字
\newcommand{\ujs@headright}{江苏大学本科毕业设计（论文）}
%% 页眉字号：8.5pt（实测决定，不是字号表里的档位）。
%% 依据：附件 3 的 PDF 页眉汉字墨高实测 8.46pt。逐个量过：
%%   小五 \zihao{5}(9pt)   墨高 9.72   ← 偏大
%%   六号 \zihao{6}(7.5pt) 墨高 7.20   ← 偏小
%%   8.5pt                墨高 8.47   ← 与附件 3 一致
%% 故直接用 \fontsize 指定，不用 \zihao。
\newcommand{\ujs@headfont}{\songti\fontsize{8.5}{10.5}\selectfont}
%% 页眉左侧标题为纯英文时（目前只有 “ABSTRACT”）改用 Times New Roman：
%% \songti 会把西文字族也指到宋体，故这种情况下不能调用它，直接 \rmfamily
%% （本模板的 \rmdefault 即 Times New Roman）。
\newcommand{\ujs@headfontlatin}{\fontsize{8.5}{10.5}\selectfont}
%% 需要走 Times New Roman 的页眉标题（与 \ujs@headleft 精确比较）
\def\ujs@headlatin{ABSTRACT}
\newcommand{\ujs@headtext}[1]{%
  \raisebox{\ujs@headraise}[0pt][0pt]{%
    \def\ujs@tmp{#1}%
    \ifx\ujs@tmp\ujs@headlatin
      \ujs@headfontlatin\rmfamily #1%
    \else
      \ujs@headfont #1%
    \fi}}

\fancypagestyle{ujs@front}{%   前置页：双栏页眉 + 横线 + 罗马数字页码
  \fancyhf{}%
  \fancyhead[L]{\ujs@headtext{\ujs@headleft}}%
  \fancyhead[R]{\ujs@headtext{\ujs@headright}}%
  \fancyfoot[C]{\rmfamily\zihao{5}\thepage}%
}
\fancypagestyle{ujs@main}{%    正文：右侧页眉 + 横线 + 阿拉伯数字页码
  \fancyhf{}%
  \fancyhead[R]{\ujs@headtext{\ujs@headright}}%
  \fancyfoot[C]{\rmfamily\zihao{5}\thepage}%
}
\fancypagestyle{ujs@plain}{%   无页眉，仅有页码（封面后过渡页）
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%   %% 关键：\fancyhf{} 只清页眉“文字”，
  \fancyfoot[C]{\rmfamily\zihao{5}\thepage}%  %% 横线由 \headrule 单独绘制，
}%                                          %% 必须把宽度置 0 才不画线
\fancypagestyle{ujs@empty}{%   封面等：无页眉、无横线、无页码
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{ujs@main}

%%% ------------------------------------------------------------------
%%% 五、各级标题（规范“标题层次”与附件 3 样式）
%%%    章标题（一级）：黑体小二号，居中，段前段后 1 行
%%%    节标题（二级）：宋体四号，加粗，左对齐，段前段后 0.5 行
%%%    小节标题（三级）：宋体小四号，加粗，左对齐，段前段后 0.5 行
%%% ------------------------------------------------------------------
\newfontfamily\ujsheitiLatin{SimHei}
\newfontfamily\ujssongtiLatin[AutoFakeBold=2.5]{SimSun}
\ctexset{
  chapter = {
    name        = {},
    number      = \arabic{chapter},
    format      = {\centering\heiti\ujsheitiLatin\zihao{-2}},
    nameformat  = {},
    titleformat = {},
    aftername   = {\hspace{0.5em}},
    beforeskip  = 0pt,
    afterskip   = 0pt,
    fixskip     = true,
  },
  section = {
    format      = {\setstretch{1.5}\raggedright\songti\ujssongtiLatin\bfseries\zihao{4}},
    aftername   = {\hspace{0.5em}},
    beforeskip  = \baselineskip,
    afterskip   = \baselineskip,
    fixskip     = true,
  },
  subsection = {
    format      = {\setstretch{1.5}\raggedright\songti\ujssongtiLatin\bfseries\zihao{-4}},
    aftername   = {\hspace{0.5em}},
    beforeskip  = \baselineskip,
    afterskip   = \baselineskip,
    fixskip     = true,
  },
  subsubsection = {
    format      = {\setstretch{1.5}\raggedright\songti\ujssongtiLatin\bfseries\zihao{-4}},
    aftername   = {\hspace{0.5em}},
    beforeskip  = 0.5\baselineskip,
    afterskip   = 0.5\baselineskip,
    fixskip     = true,
  },
}
\setcounter{secnumdepth}{3}   % 编号到第三级
\setcounter{tocdepth}{2}      % 目录列至三级（chapter=0, section=1, subsection=2）
\setcounter{chapter}{0}       % 正文首章编号为 1
\makeatletter

%% 章标题排版：段前 1 行、段后 1 行
%% 传入的是与附件 3 完全相同的整条标题（含编号，如“1  **”），
%% 因此这里不再拼接编号，以保证正文标题与目录条目逐字一致。
%% 注意：\centering 必须放在**分组**里。\centering 会同时设置
%% \leftskip 与 \rightskip 为 0pt plus 1fil，且是全局赋值 —— 不分组就会
%% 泄漏到章标题之后的**全文**，使所有正文段落变成居中（实测确认）。
%% 而 \raggedright 只设置 \rightskip，不会产生这种可见后果。
\newcommand{\ujs@chapterfmt}[1]{%
  \vspace*{0.5\baselineskip}%
  \par\noindent{\centering\heiti\ujsheitiLatin\zihao{-2}#1\par}%
  \vspace{0.7\baselineskip}%
  \ujsheadleft{#1}%
}
% 带编号章（编号自动递增）
\def\@chapter[#1]#2{%
  \ifnum\c@secnumdepth>\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \phantomsection
  \ujs@chapterfmt{\thechapter\hspace{0.5em}#2}%
}
% 不带编号的章标题排版（供需要手工排版的章节直接调用）
\newcommand{\ujschaptertitle}[1]{\ujs@chapterfmt{#1}}

% “字面标题章”：标题在正文中不再拼接编号，但章计数器仍递增，
% 使后续 \section 的编号（1.1、1.2……）与附件 3 的示意一致。
% 正文标题与目录条目均为所给整条标题（如“1  **”），与附件 3 逐字相同。
\newcommand{\ujschapter}[1]{%
  \clearpage
  \refstepcounter{chapter}%
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
  \chaptermark{#1}%
  \ujs@chapterfmt{#1}%
}

% 完全不参与章节编号的章（致谢、附录等）
%   \ujsunnumberedchapter{正文标题}          目录用同一串
%   \ujsunnumberedchapter{正文标题}[目录标题] 目录用短标题
% 用途：标题里的字间空隙（如“附\qquad 录”）只在正文页显示，目录条目不带空隙。
\newcommand{\ujsunnumberedchapter}[1]{%
  \@ifnextchar[{\ujs@unnumchap{#1}}{\ujs@unnumchap{#1}[#1]}%
}
\def\ujs@unnumchap#1[#2]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{#2}%
  \chaptermark{#2}%
  \ujs@chapterfmt{#1}%
}

%%% 附录：章号为 A、B、C，节号 B.1、B.2，图表号为 图B1、表B1
\newcommand{\ujsappendix}{%
  \clearpage
  \setcounter{chapter}{0}%
  \renewcommand{\thechapter}{\Alph{chapter}}%
  %% 附件 3 示例为 B2、B2.1；图表、公式为 B1、B2。
  \renewcommand{\thesection}{\thechapter\arabic{section}}%
  \counterwithin*{figure}{chapter}%
  \counterwithin*{table}{chapter}%
  \counterwithin*{equation}{chapter}%
  \renewcommand{\theequation}{\thechapter\arabic{equation}}%
  \renewcommand{\thefigure}{\thechapter\arabic{figure}}%
  \renewcommand{\thetable}{\thechapter\arabic{table}}%
  %% 附录与正文使用不同的超链接锚点，避免计数重置导致跳错页。
  \renewcommand{\theHchapter}{appendix.\Alph{chapter}}%
  \renewcommand{\theHfigure}{appendix.\thechapter.\arabic{figure}}%
  \renewcommand{\theHtable}{appendix.\thechapter.\arabic{table}}%
  \renewcommand{\theHequation}{appendix.\thechapter.\arabic{equation}}%
  \gdef\@chapapp{附录}%
}
%%% ------------------------------------------------------------------
%%% 六、目录
%%%    标题“目　录”：黑体二号居中，段前 1 行、段后 0.5 行
%%%    章条目：黑体四号；节条目：宋体小四号缩进 2 字符；小节：缩进 4 字符
%%% ------------------------------------------------------------------
\RequirePackage{tocloft}
\renewcommand{\cfttoctitlefont}{\hfill\heiti\zihao{2}}
\renewcommand{\contentsname}{目\hspace{2em}录}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{1\baselineskip}
\setlength{\cftaftertoctitleskip}{0.5\baselineskip}
\renewcommand{\cftdot}{$\cdot$}
\renewcommand{\cftdotsep}{1}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchapfont}{\heiti\ujsheitiLatin\zihao{4}}
\renewcommand{\cftchappagefont}{\heiti\zihao{4}}
\renewcommand{\cftsecfont}{\songti\rmfamily\zihao{-4}}
\renewcommand{\cftsecpagefont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecfont}{\songti\rmfamily\zihao{-4}}
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}}
\renewcommand{\cftsubsubsecfont}{\songti\rmfamily\zihao{-4}}
% 章级目录项按附件 3 的约 31.2pt 基线间距设置（含后置章节）。
\setlength{\cftbeforechapskip}{4.1pt}
\renewcommand{\cftchapafterpnum}{\par\vspace{4.1pt}}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{2em}
\setlength{\cftsubsecindent}{4em}
\setlength{\cftsubsubsecindent}{6em}
\setlength{\cftchapnumwidth}{2em}
% 目录节与小节编号保留 Times New Roman；编号与标题之间留一个空格。
\setlength{\cftsecnumwidth}{21pt}
\setlength{\cftsubsecnumwidth}{30pt}
\setlength{\cftsubsubsecnumwidth}{39pt}

%%% ------------------------------------------------------------------
%%% 七、图表标题
%%%    图题置于图下，表题置于表上；序号用阿拉伯数字连续编排
%%% ------------------------------------------------------------------
\RequirePackage[labelsep=space]{caption}
\DeclareCaptionFont{ujscap}{\songti\zihao{-4}}
\captionsetup{font=ujscap,labelsep=space,justification=centering}
\captionsetup[table]{position=above}
\captionsetup[figure]{position=below}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}

%% 规范 二·（六）2、3、4：图、表、公式的序号一律用阿拉伯数字依序【连续】编排
%% （不分章），如 图1、图2、表1、表2、式(1)、式(2)
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{equation}{chapter}
\renewcommand{\theequation}{\arabic{equation}}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}

\RequirePackage{tabularx, makecell, longtable, booktabs, multirow}
\newcolumntype{L}{X}
\newcolumntype{C}{>{\centering \arraybackslash}X}
\newcolumntype{R}{>{\raggedleft \arraybackslash}X}

%%% ------------------------------------------------------------------
%%% 八、列表、脚注
%%% ------------------------------------------------------------------
\RequirePackage{enumitem}
\setlist{noitemsep,topsep=3pt}

\RequirePackage{tikz}
\newcommand*\circled[1]{\tikz[baseline=(char.base)]{%
  \node[shape=circle,draw,inner sep=0.5pt] (char) {#1};}}
\long\def\@makefnmark{\hbox{{\normalfont\textsuperscript{\circled{\@thefnmark}}}}}
\long\def\@makefntext#1{\parindent 1em\noindent\hb@xt@ 1.8em{\hss\circled{\@thefnmark}}#1}
\skip\footins=10mm plus 1mm
\footnotesep=6pt
\renewcommand{\footnotesize}{\songti\zihao{5}}
\renewcommand\footnoterule{\vspace*{-3pt}\hrule width 0.3\columnwidth height 1pt\vspace*{2.6pt}}

%%% ------------------------------------------------------------------
%%% 九、数学、定理、算法、代码
%%% ------------------------------------------------------------------
\RequirePackage{amsmath, amssymb}
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{graphicx, subcaption}
\RequirePackage{listings}
\RequirePackage{algorithm2e, algorithmic}
\RequirePackage{pgfplots}
\RequirePackage{fontspec, color, url, array, xcolor}
%% 数学字体：Times 风格（newtxmath 使用 TeX Gyre Termes，与 Times New Roman 配套），
%% 不再载入 txfonts——它会改写 \rmdefault 而覆盖 Times New Roman 正文西文字体。
\RequirePackage{newtxmath}

%% 西文字体统一为 Times New Roman。
%% 必须放在 newtxmath 之后：该宏包会改写 \rmdefault 与数学字母字体，
%% 若顺序颠倒，正文西文与公式中的字母会变成 Latin Modern。
\setmainfont[Ligatures=Rare]{Times New Roman}
\setsansfont[Ligatures=Rare]{Times New Roman}
\setmonofont[Ligatures=Rare]{Times New Roman}

\theoremstyle{plain}
\theoremheaderfont{\heiti}
\theorembodyfont{\songti}\theoremindent0em
\theorempreskip{0pt}\theorempostskip{0pt}
\theoremnumbering{arabic}
\newtheorem{theorem}{\hspace{2em}定理}[chapter]
\newtheorem{definition}{\hspace{2em}定义}[chapter]
\newtheorem{lemma}{\hspace{2em}引理}[chapter]
\newtheorem{corollary}{\hspace{2em}推论}[chapter]
\newtheorem{proposition}{\hspace{2em}性质}[chapter]
\newtheorem{example}{\hspace{2em}例}[chapter]
\newtheorem{remark}{\hspace{2em}注}[chapter]
\theoremstyle{nonumberplain}
\theoremheaderfont{\heiti}
\theorembodyfont{\normalfont\rm\songti}
\theoremindent0em\theoremseparator{\hspace{1em}}
\theoremsymbol{$\square$}
\newtheorem{proof}{\hspace{2em}证明}

\renewcommand{\algorithmcfname}{算法}

%%% ------------------------------------------------------------------
%%% 十、参考文献：GB/T 7714-2015
%%% ------------------------------------------------------------------
\RequirePackage[sort&compress]{natbib}
\setcitestyle{numbers,square,comma}
\renewcommand{\bibname}{参考文献}
\renewcommand{\bibnumfmt}[1]{\makebox[2em][l]{[#1]}}
%% 参考文献样式：随 TeXLive 提供的 GB/T 7714-2015 数字制样式。
%% （旧版仓库里的 data/gbt7714-2015.bst 已不再需要，保留仅为兼容旧工程。）
\bibliographystyle{gbt7714-numerical}
%% 参考文献的章标题用与其它章一致的排版（\ujs@chapterfmt 在第四节定义）。
%% 目录项由 pages/references.tex 手工 \addcontentsline 添加，避免重复。
\renewcommand{\bibsection}{\ujs@chapterfmt{\bibname}}
%% 数字制文献列表：编号顶格，正文及续行统一缩进 2 字符。
\renewcommand{\NAT@bibsetnum}[1]{%
  \setlength{\labelwidth}{2em}%
  \setlength{\labelsep}{0pt}%
  \setlength{\leftmargin}{2em}%
  \setlength{\itemsep}{\bibsep}%
  \setlength{\parsep}{0pt}%
  \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}%
}
\AtBeginDocument{\let\@bibsetup\NAT@bibsetnum}
%% 上标引用：GB/T 7714 与附件 3 示例均为上标方括号
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
\renewcommand{\eqref}[1]{\textup{{\normalfont（\ref{#1}）\normalfont}}}

\RequirePackage{pdfpages}   % 原创性声明直接插入附件 3 的单页 PDF
\RequirePackage{hyperref}
%% 弹性余量：吸收无法断行的长串。附件 3 的参考文献里有两条把 URL 写错
%% （如 “http://http://www.mod.gov.cn/…”、“http://ww w.moe.gov.cn/…”），
%% 都是源文件自带的笔误，照录不改，但它们无法在合适位置断行 →
%% Overfull \hbox。给 \emergencystretch 留 8em 余量后由 TeX 自动微调，
%% 实测：3em 时仍剩 1 处 Overfull，8em 可清零；正常段落外观不受影响。
\setlength{\emergencystretch}{8em}
\hypersetup{
  citecolor=magenta,
  linkcolor=black,
  urlcolor=blue,
  pdfborder={0 0 0},          % 去掉链接的红/绿/蓝方框
  bookmarksnumbered=true,
  unicode=true
}

\graphicspath{{figures/}}

%%% ------------------------------------------------------------------
%%% 十一、封面
%%%    —— 1:1 还原原模板 UJS_thesis-master 的封面版式 ——
%%%    顶部校徽图片（figures/UJSlogo.png），居中，118pt 见方
%%%    中文题目二号黑体居中，可分两行；英文题目 16pt Times New Roman 加粗居中
%%%    学院名称等六项：标签四号宋体，宽度 4cm 两端对齐，六个“：”竖直对齐；
%%%                    取值四号宋体，宽度 6.1cm 居中并加下划线
%%%    日期小四宋体居中
%%% ------------------------------------------------------------------
\def\etitle#1{\def\@etitle{#1}}\def\@etitle{}
\def\ctitle#1{\def\@ctitle{#1}}\def\@ctitle{}
\def\cschool#1{\def\@cschool{#1}}\def\@cschool{}
\def\cmajor#1{\def\@cmajor{#1}}\def\@cmajor{}
\def\cauthor#1{\def\@cauthor{#1}}\def\@cauthor{}
\def\cstudentid#1{\def\@cstudentid{#1}}\def\@cstudentid{}
\def\cadvisor#1{\def\@cadvisor{#1}}\def\@cadvisor{}
\def\cadvisorinfo#1{\def\@cadvisorinfo{#1}}\def\@cadvisorinfo{}

%% 日期：附件 3 写作“年      月”，即“年”“月”之间留一段空隙。
%% 说明：TeX 读取宏参数时会把连续空格压成一个，而且 \catcode 只能局部生效，
%% 无法让 \cdate 自己感知空格，因此这里提供 \gap 命令显式给出该空隙，
%% 在 cover.tex 中写成 \cdate{年\gap 月（小四宋体，居中）}。
%% 若日期是连续文字（如“二〇二六年六月”），直接写 \cdate{二〇二六年六月}。
\newcommand{\gap}{\hspace{4em}}
\def\cdate#1{\def\@cdate{#1}}\def\@cdate{}

%% 封面信息标签：宽度 98.4pt，两端对齐（[s]）。
%% 关键：盒宽必须 ≥ 最长标签的自然宽度，否则长标签会把“：”挤出盒外，
%% 六行的“：”就无法对齐。实测自然宽度：
%%     学院名称：     70.26pt
%%     指导教师姓名： 98.37pt   ← 决定盒宽下限
%%     指导教师职称： 98.37pt
%% 故取 98.4pt：5 字标签被拉开（字距约 21pt，与附件 3 的 21.12pt 相符），
%% 6 字标签自然占满，六行的“：”一律落在该盒右端。
\newcommand{\ujs@label}[1]{\makebox[98.4pt][s]{#1}}
%% 封面信息取值：宽度 241pt 居中并加下划线。
%% 附件 3 PDF 实测：下划线为 x 233.2–474.2（宽 241.0pt，高 0.48pt）。
\newcommand{\ujs@value}[1]{\underline{\makebox[241pt][c]{#1}}}

\newcommand{\maketitlepage}{%
  \clearpage
  \thispagestyle{ujs@empty}%
  \begingroup
  \setstretch{1.3}%
  \begin{center}
    %% 顶部：校徽 + “江苏大学”手写体 + “JIANGSU UNIVERSITY”（带下划线）+
    %% “本科毕业设计（论文）”整块做成**一张图片** figures/ujudt-header.png，
    %% 由附件 3 的 PDF 第 1 页原样裁出。该页上半部共三个墨迹行块：
    %%   y 132.66–238.68（校徽+校名+JIANGSU UNIVERSITY 及其下划线）
    %%   y 257.94–279.00（本科毕业设计（论文））
    %% 故裁剪框取 x 43.02–546.66、y 117.72–294.00，四边各留约 15pt 白边，
    %% 1:1 显示时 width=503.64pt、height=176.22pt。
    %% 该宽度比正文宽（469.47pt）宽 34.17pt —— 附件 3 自己的这一块也压出了
    %% 页边距，故用 \makebox[\textwidth][c] 居中，保持 1:1 不缩放，同时不报
    %% Overfull \hbox。
    \vspace*{1pt}%
    %% 图片单独下移 31.4pt：用 \raisebox，把图片的 height/depth 都设为图片自身
    %% 尺寸，使这一行的占位高度与图片原高完全一致 —— 于是页面总高不变，
    %% 下面的题目、信息栏、日期都不动，只有图片本身下移。
    \makebox[\textwidth][c]{%
      \raisebox{-31.4pt}[\height][\depth]{%
        \includegraphics[width=500.64pt]{figures/ujudt-header.png}}}%
    \par
    \vspace{111.8pt}%
    %% 论文题目与信息栏整体上移一行（22pt 字的行高 33pt）。
    %% 位置按附件 3 实测：中文题目顶 374.95、英文题目顶 408.74，
    %% 中文题目底 394.89 → 英文题目顶 408.74 ＝ 13.85pt，故题间距取 5.3pt。
    %% minipage 取 15cm：附件 3 的英文题目行宽 377.9pt，13cm（369.5pt）放不下
    %% 会报 Overfull \hbox。
    \begin{minipage}[c]{15cm}
      \centering
      {\heiti\zihao{2}\setlength{\baselineskip}{32pt}\@ctitle\par}
      \vspace{0pt}%
      {\rmfamily\bfseries\zihao{3}\@etitle\par}
    \end{minipage}
    \par\vspace{95pt}%
    %% 封面信息六项（附件 3 行距实测 31.9pt = 22.0 字行高 + 9.9 附加）
    {\songti\zihao{4}%
      \renewcommand{\arraystretch}{1.0}%
      \begin{tabular}{@{}r@{\hspace{0.9em}}l@{}}
        \ujs@label{学院名称：}     & \ujs@value{\@cschool}     \\[10pt]
        \ujs@label{专业班级：}     & \ujs@value{\@cmajor}      \\[10pt]
        \ujs@label{学生姓名：}     & \ujs@value{\@cauthor}     \\[10pt]
        \ujs@label{学生学号：}     & \ujs@value{\@cstudentid}  \\[10pt]
        \ujs@label{指导教师姓名：} & \ujs@value{\@cadvisor}    \\[10pt]
        \ujs@label{指导教师职称：} & \ujs@value{\@cadvisorinfo}\\[10pt]
      \end{tabular}}
    \par\vspace{28pt}%
    %% 日期：小四宋体居中
    {\songti\zihao{-4}\@cdate\par}
  \end{center}
  \endgroup
  \clearpage
}

%%% ------------------------------------------------------------------
%%% 十二、原创性声明
%%% ------------------------------------------------------------------
%%% 十二、原创性声明 —— 直接插入附件 3 的**单页 PDF**，不用 LaTeX 重排
%%%
%%% pages/declaration.pdf 由附件 3 的 PDF 第 2 页原样抽出：
%%%   pdfseparate -f 2 -l 2 "附件3 ….pdf" pages/declaration.pdf
%%% 该页自带页眉（左“原创性声明”＋右校名＋横线）与页码 I，与本文档体系一致，
%%% 故用 fitpaper=true 1:1 插入、pagecommand={} 不再叠加本模板的页眉页码。
%%%
%%% 注意：该页版心为 63.0pt 起，本模板为 70.87pt 起，正文左右边界相差约 7.9pt；
%%% 若要求逐点一致，可另行叠加白色遮罩重画页眉（见 README）。
%%% ------------------------------------------------------------------
\newcommand{\makedeclaration}{%
  \clearpage
  %% \thispagestyle{empty} 抑制本模板在插入页上叠加页眉/页脚：
  %% 该页的页眉与页码（I）由它自己的 PDF 内容提供，不能再叠一层。
  \thispagestyle{empty}%
  \includepdf[pages=1,fitpaper=true,pagecommand={}]{pages/declaration.pdf}%
}

%%% ------------------------------------------------------------------
%%% 十三、中文摘要、英文摘要
%%%    中文：“摘要：”黑体四号 + 内容宋体小四，1.5 倍行距，首行缩进 2 字符
%%%    关键词：段前 1 行，左顶格，“关键词”黑体四号
%%%    英文：题目 16pt Times New Roman 加粗居中；“ABSTRACT”小四加粗
%%%
%%%    题目由环境参数给出，而非取自封面，以便与附件 3 示例逐字一致：
%%%      \begin{cnabstract}{题目}{关键词}
%%%      \begin{enabstract}{Title}{Key words}
%%% ------------------------------------------------------------------
\newenvironment{cnabstract}[2]{%
  \clearpage
  \ujsheadleft{摘要}%
  \thispagestyle{ujs@front}%
  \leavevmode
  \begin{center}
    {\heiti\zihao{3}#1}
    \par\vspace{0.75\baselineskip}
    {\songti\zihao{-4}
      \setlength{\tabcolsep}{2.5em}%
      \hspace*{-1em}%
      \begin{tabular}{@{}ll@{\hspace{1.4em}}ll@{}}
        专业班级：\@cmajor & 学生姓名：\@cauthor \\
        指导教师：\@cadvisor & 职\qquad 称：\@cadvisorinfo
      \end{tabular}}
  \end{center}
  \par\vspace{0.5\baselineskip}
  \def\ujs@cnkeyword{#2}%
  \setstretch{1.65}%
  \songti\zihao{-4}\par
}{%
  \par\vspace{\baselineskip}
  \noindent{\heiti\zihao{4}关键词：}{\songti\zihao{-4}\ujs@cnkeyword\par}%
  \clearpage
}

\newenvironment{enabstract}[2]{%
  \clearpage
  \ujsheadleft{ABSTRACT}%
  \thispagestyle{ujs@front}%
  \leavevmode\vspace{-0.6em}
  \begin{center}
    {\rmfamily\bfseries\zihao{4}#1}
  \end{center}
  \par\vspace{0.45\baselineskip}
  \def\ujs@enkeyword{#2}%
  \setstretch{1.6}%
  %% 首段（“ABSTRACT …”）按要求：ABSTRACT 加粗 + 首行缩进 1 字符。
  %% 依据附件 3 实测：该段 run[0..1] bold=True（“ABSTRACT ”），
  %% 段落 first_line_indent = 153035 EMU = 12.04pt = 小四 12pt 的 1em。
  %% 用 \everypar 在**首段开头**自动插入加粗的“ABSTRACT ”并把首行缩进设为 1em，
  %% 插一次即撤钩子，故其余段落完全不受影响。
  \setlength{\parindent}{0pt}%
  \everypar{\hspace{1em}\hbox{\rmfamily\bfseries ABSTRACT\/\normalfont\songti\zihao{-4}\ }\everypar{}}%
  \songti\zihao{-4}\par
}{%
  \par\vspace{0.8\baselineskip}
  \noindent{\rmfamily\bfseries KEY WORDS:\ }{\zihao{-4}\ujs@enkeyword\par}%
  \clearpage
}

%%% ------------------------------------------------------------------
%%% 十四、目录与正文分界
%%% ------------------------------------------------------------------
\newcommand{\ujscontents}{%
  \clearpage
  \ujsheadleft{目录}%
  \thispagestyle{ujs@front}%
  %% 延续原创性声明、中文摘要和英文摘要的页码，目录从 IV 起。
  %% 不用 \tableofcontents：ctex 的 \tableofcontents 内部会走一次 \chapter*
  %% （即 \@makeschapterhead），它会把 \thispagestyle 重置，导致目录页与后续
  %% 目录页没有页眉。这里手工排目录标题（与章标题同样式：黑体小二号居中、
  %% 段前 1 行段后 0.5 行），再直接调用 \@starttoc{toc}。
  \begingroup
  \ctexset{chapter/format={\centering\heiti\zihao{2}}}
  \vspace*{-0.5em}%
  {\centering\heiti\zihao{2}\contentsname\par}%
  \vspace{0.5\baselineskip}%
  \@starttoc{toc}%
  \endgroup
  \clearpage
}
%% 正文开始：切换页眉样式、阿拉伯数字页码重新计数、章计数器归零
\newcommand{\ujsmainmatter}{%
  \clearpage
  \pagestyle{ujs@main}%
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
  \setcounter{chapter}{0}%
}

%%% ------------------------------------------------------------------
%%% 十五、前置部分：封面 + 原创性声明（页码自原创性声明起用大写罗马数字）
%%% ------------------------------------------------------------------
\newcommand{\ujsfrontmatter}{%
  \maketitlepage
  \pagenumbering{Roman}%
  \setcounter{page}{1}%
  \makedeclaration
}

\makeatother
\endinput









