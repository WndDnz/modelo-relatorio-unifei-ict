## 0. Precondition

- [ ] 0.1 Confirm `fix-abnt-caption-label-format` is applied before starting. Every type added here inherits its separator, margin and list-entry behavior; applying this change first means implementing three known defects three times over. See design.md Decisions.

## 1. Type declaration mechanism

- [ ] 1.1 Provide a declaration command that, given a type name and its designative word, creates the environment, the counter, the cross-reference commands and the list hook for that type.
- [ ] 1.2 Apply `\counterwithout{<counter>}{chapter}` to every counter the mechanism creates, matching what the template already does for figure, table and equation at line ~275. Omitting it makes the new type number per chapter while everything else numbers continuously — silent, and invisible until a document has two chapters with illustrations.
- [ ] 1.3 Give each type its own auxiliary list-file extension, and count the total open write streams against LaTeX's limit of 16 with `glossaries`, `biblatex`, `hyperref` and the existing `toc`/`lof`/`lot` already loaded. Document the resulting ceiling on custom types rather than letting an author hit it as an inscrutable error.
- [ ] 1.4 Generate the cross-reference commands from the declaration rather than hand-writing a pair per type, so a custom type gets them for free.

## 2. Shipped types

- [ ] 2.1 Redefine `figuraabnt` as the type declared with the word "Figura", keeping its name, its signature and its behavior byte-identical for existing documents.
- [ ] 2.2 Declare the Quadro type.
- [ ] 2.3 Declare the Gráfico type.
- [ ] 2.4 Verify `tabelaabnt` is untouched and remains outside the mechanism — the boundary between §5.8 illustrations and §5.9 tables must hold in the code, not only in the prose.

## 3. Per-type lists

- [ ] 3.1 Provide a list-printing command per declared type, styled like the existing `\listoffigures`/`\listoftables` (`UnifeiICTReport.sty:911–928`) with the type's own heading.
- [ ] 3.2 Factor the shared list body rather than copying the block a third time — the two existing ones differ only in heading name and file extension.
- [ ] 3.3 Confirm a type used in the document but whose list is never printed produces no empty page and no warning.
- [ ] 3.4 Confirm a list printed for a type with no occurrences produces no spurious output.

## 4. Example chapter

- [ ] 4.1 Add a Quadro example and a Gráfico example.
- [ ] 4.2 Teach the Quadro/Tabela boundary by showing the same content twice — once as a Quadro because its central information is textual, once as a Tabela because its central information is numeric. A definitional sentence alone does not stop authors making this error; see design.md Decisions.
- [ ] 4.3 Update the prose that currently describes `figuraabnt`/`tabelaabnt` to describe the type mechanism, including how to declare a type the template does not ship.
- [ ] 4.4 Add the new list-printing commands to `modelo-relatorio.tex`, commented out by default like the existing optional lists.
- [ ] 4.5 Update `README.md`.

## 5. Verify

- [ ] 5.1 Recompile `modelo-relatorio.tex` with `latexmk` and confirm a clean build.
- [ ] 5.2 Confirm captions read `Quadro 1 – Título` and `Gráfico 1 – Título`, with the travessão inherited from `fix-abnt-caption-label-format`.
- [ ] 5.3 Confirm the sequences are independent: a document with Figura, Quadro, Figura, Gráfico in that order must number them Figura 1, Quadro 1, Figura 2, Gráfico 1.
- [ ] 5.4 Confirm each list contains only its own type, with entries formatted like the existing lists.
- [ ] 5.5 Confirm cross-references to a Quadro and to a Gráfico resolve to their own designative words, and that the existing `\reffig`/`\reftable` family still resolves exactly as before.
- [ ] 5.6 Compile a compound Quadro containing `subfigure` blocks and confirm the width-accumulation hooks (`UnifeiICTReport.sty:216–265`, keyed on `\AtBeginEnvironment{figure}`) still fire, so `\fonte{}` aligns correctly.
- [ ] 5.7 Confirm the pre-change examples render identically, since `figuraabnt` and `tabelaabnt` were both supposed to be behavior-preserving.
