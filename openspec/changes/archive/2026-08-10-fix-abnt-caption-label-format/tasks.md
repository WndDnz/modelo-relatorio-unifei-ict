## 1. Caption label separator

- [ ] 1.1 In `UnifeiICTReport.sty`, add `labelsep=endash` to the document-wide `\captionsetup` at line ~282, so figures, tables and any float type added later inherit the travessão.
- [ ] 1.2 Comment the line with the normative reference (NBR 14724:2024 §5.8) and note that `labelsep=emdash` is the one-key alternative if the em dash is preferred — the norm's examples use it, the UFV guide uses a hyphen, and the choice is institutional (see design.md Decisions).
- [ ] 1.3 Confirm `\caption*{...}` blocks (used for the secondary descriptions in `Capitulos/cap2/cap2.tex`) are unaffected, since they carry no label.

## 2. Caption aligned to the illustration's margins

- [ ] 2.1 Add an optional width key to `figuraabnt` and `tabelaabnt`. When supplied, the begin code issues `\captionsetup{width=<w>}` before `\caption`, so the caption wraps within the illustration's width.
- [ ] 2.2 Make the same width drive `\fonte{}` for that float, so caption, content and source share both edges. `\fonte{}` already boxes to `\LastGraphicWidth` (`UnifeiICTReport.sty:627`); the declared width must take precedence over the measured one for the float that declared it, and must not leak into the next float.
- [ ] 2.3 When the width is NOT supplied, behavior must be byte-identical to before this change: caption across the text block, `\fonte{}` on the measured `\LastGraphicWidth`. Verify by diffing the rendered output of an unmodified example against the pre-change build.
- [ ] 2.4 Decide and document where the width key goes in the signature. The environments are already `O{!htbp} m m o`; adding a fifth argument makes the call site hard to read. Prefer a keyval optional argument or a dedicated key over another positional `o`.

## 3. List of figures / list of tables entries

- [ ] 3.1 Declare caption list formats injecting the designative word and the travessão, and bind them per float type — verified working: `\DeclareCaptionListFormat{abntfig}{#1\figurename~#2 --~}` plus `\captionsetup[figure]{listformat=abntfig}`, and the `\tablename` equivalent for tables.
- [ ] 3.2 CRITICAL — the list format alone produces overprinting. Verified by compiling: `Figura 1 –` overflows `book`'s default 1.5em `\numberline` box in `\l@figure` and collides with the title. Redefine `\l@figure` and `\l@table` with a number box wide enough for word + number + travessão, following the existing `\l@chapter`/`\l@section` redefinitions at `UnifeiICTReport.sty:955–995`.
- [ ] 3.3 Size the number box for a three-digit order number (`Figura 100 –`), not just the single digit the model happens to use, and comment why.
- [ ] 3.4 Confirm wrapped titles align under the first letter of the title, matching the behavior the existing `\l@section` redefinitions already provide for the TOC.
- [ ] 3.5 Confirm the list entries keep the `unifeiblue`/Exo2 styling applied to the rest of the pre-textual lists, and that the hyperlink still covers the whole entry.

## 4. Example chapter and documentation

- [ ] 4.1 In `Capitulos/cap2/cap2.tex`, add the width argument to the single-figure example so the model demonstrates the conformant path, and leave at least one example without it so both behaviors are visible.
- [ ] 4.2 Update the surrounding prose to explain the width argument and why it exists — cite §5.8's requirement that type, number, title, source, legend and notes all follow the illustration's margins.
- [ ] 4.3 Update the `figuraabnt`/`tabelaabnt` entry in `README.md` with the new optional width.

## 5. Verify

- [ ] 5.1 Recompile `modelo-relatorio.tex` with `latexmk` and confirm a clean build.
- [ ] 5.2 Confirm captions render `Figura 1 – Figura de exemplo` and `Tabela 1 – Tabela de exemplo`, with a travessão and no colon anywhere.
- [ ] 5.3 Confirm the list entries render `Figura 1 – Figura de exemplo …… 20` and `Tabela 1 – Tabela de exemplo …… 20`, with no overprinting between label and title.
- [ ] 5.4 Render the page holding the width-declaring example and confirm visually that the caption's left edge, the graphic's left edge and the source note's left edge coincide.
- [ ] 5.5 Confirm the multi-subfigure example — where `\LastGraphicWidth` is an accumulated total rather than a single measurement — still places its `\fonte{}` correctly.
- [ ] 5.6 Confirm cross-references (`\reffig`, `\reftable`, `\refcomp`) still resolve, and that the caption changes did not disturb float numbering.
