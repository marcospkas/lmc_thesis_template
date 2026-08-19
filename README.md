By Marcos Pires Kassab

# Introduction
This template is intended to be used for PhD thesis, Master's dissertation, qualification exams or monographies in general, closely following what is preconized in the 2024 version of the oficial USP ["Guidelines for thesis and dissertations"](https://doi.org/10.11606/9786598386221). Of course, most of the recomendations are paraphrased from ABNT norms.

Users are free to modify this template to match personal needs or to comply with the always changing specific rules from the Polytechnic School (see [https://www.poli.usp.br/en/ensino/posgraduacao/atendimento-pos-graduacao/procedimentos-para-a-edicao-revisada-de-teses-e-dissertacoes/] vs [https://www.poli.usp.br/en/bibliotecas/servicos/publicacoes-online/]).

This template uses a custom class called *lmc.cls*, which is derived from standard *Book* class. Extra options to make the writing process smoother, see [Class Options](#class-options).

The class provides several utility commands, that are displayed at the provided template. Some key design decisions revolve around the compatibility/usability with the `Subfile` package (including correct hyperreferences), so that the authors do not need to always recompile the big main file.

# Compilation
First, make sure to have a Latex engine in your computer. For Windows, I have used successfully [MiKTeX](https://miktex.org/).

I have tested this suite for Miktex PDFLatex + VSCode, with Latex Workshop extension. To compile using ABNT citation style from Biblatex, one must use the modern Biber backend, instead of the elderly Bibtex. In VSCode, simply go to the command pallete `ctrl+shift+p` &rarr; `build with recipe` &rarr; `PDFLatex + Biber + 2*PDFLatex`. If you have copied the complete suite, including the `.vscode/settings.json` file, this option should appear to you by default.

It is probably easy to make it work with TexMaker and Overleaf as well, but I have not tried this yet.

# Class options
## Standard *Book* options
You can use any *Book* class options. I suggest sticking to `12pt` and `a4paper`. You can choose either `oneside` or `twoside`, the custom class can deal with both.
## Custom options
This template provides two optional arguments:
- `language`: passed internally to Babel package. Used to automatically name sections (e.g. Appendix, Reference) in the selected langugage. This template has custom names, which are available for `portuguese` (PT/PT), `brazil` (PT/BR), `english` (ENG), `french` (FR) and `spanish` (ESP);
- `debug`: might be `true` or `false`. If `true`, display line numbers, page margins, header annotation ,and the `debug` section (see [Custom commands](#custom-commands). Try it out!

# Custom commands
The class template provides several commands, mainly to create pre-textual elements and appendix/annex. Let's see them:
- metadata: many field should be filled, to correctly generate the cover and the title page. Namely, we have `\author`, `\date`, `\City`, `\title`, `\Docversion`, `\Advisor`, `\ConcentrationArea`, `\School`, `\Department`, `\TitlePageText`;
-`\cover`: creates the cover, using metadata; 
- `\TitlePage{#1}`: creates the title page, using metadata. If an non-empty argument is passed, tries to import a pdf file to use as the "Catalographic data";
- `\appendix` and `\annex`: switch the chapter name to the correponding title, and makes chapater number into Roman letters;
- `\Debug`: same as `\appendix` or `\annex`, but for a drafting/testing chapter that is only included if `debug=true` when the class is loaded;
- reference/citation style: controled directly from main file when calling `\usepackage[...](biblatex)`. Personally, I prefer the ABNT-numbers, and further format it to have dots in the reference section (see `\DeclareFieldFormat{labelnumber}{\ifbibliography{\mkbibbold{#1\addperiod}}{#1}}` in the template).

# Dealing with Subfiles and individual chapter compilation
When using multiple files with the `Subfiles` package, and trying to compile an isolated chapter, getting correct section numbers and cross-references from other chapters might be troublesome. Read this section if you are having troubles!

## Correct chapter number for individual subfile compilation
The first challenge is the chapter number itself. When compiling the subfile only, Latex is unaware of the other chapters, thus the chapter counter is set to 1. An easy fix to this is to add a conditional with hardcoded chapter number:
```
\ifSubfilesClassLoaded{
    \setcounter{chapter}{1} } % chapter number minus one
    {}
```
Then, the next `\chapter` will have the correct number.

## Getting cross-reference from other files
The next challeng is to create cross-references to contents from other subfiles. Thankfully, the command `\externaldocument` is available! With it, you can define prefixes to specific anchors, that allows for usual `\ref`s, `\cref`s, etc., to be seen from the subfiles and then Latex can work out the correct numbering of the references. This can be achieved by:
- first, compile the full document. An auxiliary file with *.aux* extension is generated.
- then, add to the main file's preamble a command that looks like `\externaldocument[M-]{\subfix{main}}`. The `\subfix` command is important to make Latex find the correct file path depending on wheter you are compiling the full document or only a subfile;
- lastly, call references to other chapters using the defined prefix `M-`, for example `\cref{M-fig:some_figure}`. Latex uses the *.aux* from the main file to work out the correct references.

The result is the correct cross-ref through an external link, which refers to the previously fully compiled `main.pdf`.

*Observation:* in the VSCode pdf viewer, the extenal references do not seem to be clickable, probably due to safety constraints (VSCode blocks external links). If you open it in a regular PDF viewer, it will probably work.

# Other available libraries
You can find other template options in the web. Particularly useful ones are:
- [ABNTEX-Webpage](https://www.abntex.net.br/) or [ABNTEX-Github](https://github.com/abntex/abntex2/blob/master/doc/latex/abntex2/examples/abntex2-modelo-trabalho-academico.tex)
- [POLITEX-github](https://github.com/lfochamon/poliTeX)

Personally, I have tried them but had issues with bad interactions of the classes above and definitions of commonly used utility libraries. If those issues do not show up for you, feel free to addopt them for your work :)! They might have better support for special environments, such as in-text direct citations!

Another option is the [IME_USP template](https://gitlab.com/ccsl-usp/modelo-latex), but I have never tried this one.

