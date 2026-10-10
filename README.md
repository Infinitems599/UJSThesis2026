# 江苏大学本科毕业论文 LaTeX 模板（2026）

面向理工农医教类本科毕业设计（论文），以江苏大学 2026 年写作规范与通用格式模板为依据，从 UJS_thesis-master 旧版改写。当前包含引用、图片、表格、公式和附录的排版示例。

## 编译

使用 TeX Live 2025、XeLaTeX 和 BibTeX。字体依赖 Windows 的宋体（SimSun）、黑体（SimHei）及 Times New Roman。

在项目目录执行：

```sh
xelatex main
bibtex main
xelatex main
xelatex main
```

也可使用 `latexmk -xelatex main.tex`。VS Code 安装 LaTeX Workshop 后，选择仓库自带的 `xe->bib->xe->xe` 配方。

参考文献采用 TeX Live 提供的 `gbt7714-numerical.bst`。无需项目内的旧版 `.bst` 文件。

## 结构与使用

- `main.tex`：页面顺序与各章入口。
- `UJSThesis2026.cls`：页面、字体、标题、目录、页眉页码及编号规则。
- `pages/cover.tex`：题目与个人信息占位项，使用时按实际内容填写。
- `pages/abstract.tex`、`pages/enabstract.tex`：中英文摘要与关键词。
- `pages/introduction.tex`：引言示例。
- `pages/chapter1.tex` 至 `chapter4.tex`：正文。
- `pages/references.tex` 与 `refs.bib`：参考文献入口与数据库。
- `pages/thanks.tex`、`pages/appendix.tex`：致谢和附录。
- `pages/declaration.pdf`：从官方模板提取的原创性声明页。
- `figures/`：封面图片和纯色 PDF 测试图。

声明为 I、中文摘要为 II、英文摘要为 III，目录从 IV 起并延续罗马数字。引言从阿拉伯数字 1 开始，正文与附录页码连续。

正文行距保留原设置；二级标题前的留白由半行增加为一行，二级标题后及三级标题前后间距保留原设置。章编号采用黑体；正文节与小节编号采用宋体；目录节与小节编号采用 Times New Roman。

## 示例和交叉引用

测试文件通过章节末尾的 `input` 加载，正式写作可移除或替换：

| 文件 | 测试内容 |
| --- | --- |
| `pages/citation-test.tex` | 单篇、多篇、连续、重复和平排文献引用 |
| `pages/figure-test.tex` | PDF 图片、图题、图号和正文引用 |
| `pages/table-test.tex` | 数值表、文字表、表注及数字对齐 |
| `pages/formula-test.tex` | 单行、多行、无编号公式及交叉引用 |
| `pages/appendix-test.tex` | 附录 A/B 的图表公式编号与跨章引用 |

示例文献与表格数值用于格式演示，不代表论文研究结果。

```latex
\upcite{chen2000}             % 上标文献引用
图~\ref{fig:test-blue}       % 图片引用
表~\ref{tab:test-numeric}    % 表格引用
式\eqref{eq:test-ohm}        % 带括号的公式引用
```

正文图、表、公式分别按全文连续编号。图题在图下，表题在表上。多行公式通过 `multline` 或末行编号的 `align` 排版。

附录先调用 `\ujsappendix`，再用 `\ujschapter{附录 A\quad 标题}` 开始各附录。每个新附录的图、表、公式计数重置，显示 A1、A2 或 B1 等；链接锚点与正文分开。

## 验证与限制

已用 XeLaTeX 编译并检查文献引用、图表位置、数字对齐、公式末行编号、附录重置和链接目标。测试 PDF 为本地生成产物，`main.pdf` 与编译中间文件不纳入 Git。

字体配置面向 Windows；其他系统需安装对应字体或调整文档类。LaTeX 的分页不保证与 Word 完全一致。官方参考文件和排版核验工作目录保留在仓库外。

## 许可与来源

代码沿用原项目的 MIT License，保留 2023 Abyss 版权声明，见 `LICENSE`。封面图片、声明页及示例文字来源于江苏大学官方模板，MIT 代码许可不替代这些材料原有的权利归属。



