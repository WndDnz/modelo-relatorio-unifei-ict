## 1. Caption label separator

- [x] 1.1 In `UnifeiICTReport.sty`, add `labelsep=endash` to the document-wide `\captionsetup` at line ~282, so figures, tables and any float type added later inherit the travessão.
- [x] 1.2 Comment the line with the normative reference (NBR 14724:2024 §5.8) and note that `labelsep=emdash` is the one-key alternative if the em dash is preferred — the norm's examples use it, the UFV guide uses a hyphen, and the choice is institutional (see design.md Decisions).
- [x] 1.3 Confirm `\caption*{...}` blocks (used for the secondary descriptions in `Capitulos/cap2/cap2.tex`) are unaffected, since they carry no label. Verified: rendered PDF page 20 shows the `\caption*` body with no label/dash prefix.

## 2. Caption aligned to the illustration's margins

- [x] 2.1 Add an optional width key to `figuraabnt` and `tabelaabnt`. When supplied, the begin code issues `\captionsetup{width=<w>}` before `\caption`, so the caption wraps within the illustration's width.
- [x] 2.2 Make the same width drive `\fonte{}` for that float, so caption, content and source share both edges. `\fonte{}` already boxes to `\LastGraphicWidth` (`UnifeiICTReport.sty:627`); the declared width must take precedence over the measured one for the float that declared it, and must not leak into the next float. Implemented via `\Unifei@DeclaredWidth`, reset per environment invocation (group-local), so it cannot leak into the next float.
- [x] 2.3 When the width is NOT supplied, behavior must be byte-identical to before this change: caption across the text block, `\fonte{}` on the measured `\LastGraphicWidth`. Verified: `Tabela 1` and `Figura 2` (no declared width) render exactly as before — full-width caption, `\fonte{}` aligned to measured content width.
- [x] 2.4 Decide and document where the width key goes in the signature. The environments are already `O{!htbp} m m o`; adding a fifth argument makes the call site hard to read. Prefer a keyval optional argument or a dedicated key over another positional `o`. Implemented as a dedicated `D<>{}` xparse argument (`<0.9\textwidth>`) rather than a second `[...]` bracket, so it can never be confused with the short-caption slot and needs no empty `[]` when omitted.

## 3. List of figures / list of tables entries

- [x] 3.1 Declare caption list formats injecting the designative word and the travessão, and bind them per float type. Implemented as `\DeclareCaptionListFormat{abntfig}{#1\figurename~#2 –~}` plus `\captionsetup[figure]{listformat=abntfig}`, and the `\tablename` equivalent for tables — using a **literal en dash character**, not `--`: verified by compiling that under XeLaTeX/fontspec, `--` does not ligate (text ligatures are off by default) and prints as two separate hyphens in list entries, even though the `caption` package's own `labelsep=endash` renders correctly in the caption itself via direct glyph insertion. Caught and fixed during verification (task 5).
- [x] 3.2 CRITICAL — the list format alone produces overprinting. Verified by compiling: `Figura 1 –` overflows `book`'s default 1.5em `\numberline` box in `\l@figure` and collides with the title. Redefine `\l@figure` and `\l@table` with a number box wide enough for word + number + travessão, following the existing `\l@chapter`/`\l@section` redefinitions at `UnifeiICTReport.sty:955–995`.
- [x] 3.3 Size the number box for a three-digit order number (`Figura 100 –`), not just the single digit the model happens to use, and comment why. Sized to 6.5em.
- [x] 3.4 Confirm wrapped titles align under the first letter of the title, matching the behavior the existing `\l@section` redefinitions already provide for the TOC. Inherited for free from `\@dottedtocline`'s hang-indent (indent + numwidth) — no example in the model currently has a long enough title to visually confirm wrapping, but the mechanism is identical to `\l@section`'s.
- [x] 3.5 Confirm the list entries keep the `unifeiblue`/Exo2 styling applied to the rest of the pre-textual lists, and that the hyperlink still covers the whole entry. Verified in rendered LISTA DE FIGURAS/LISTA DE TABELAS: entries are `unifeiblue`-colored and fully clickable (hyperref's automatic tocline linking, unaffected by the `\l@figure`/`\l@table` redefinition).

## 4. Example chapter and documentation

- [x] 4.1 In `Capitulos/cap2/cap2.tex`, add the width argument to the single-figure example so the model demonstrates the conformant path, and leave at least one example without it so both behaviors are visible. `Figura 1` (single-figure example) now declares `<0.9\textwidth>`; `Tabela 1` and `Figura 2` (multi-subfigure) intentionally left without, per the task's own guidance to keep both behaviors visible.
- [x] 4.2 Update the surrounding prose to explain the width argument and why it exists — cite §5.8's requirement that type, number, title, source, legend and notes all follow the illustration's margins.
- [x] 4.3 Update the `figuraabnt`/`tabelaabnt` entry in `README.md` with the new optional width.

## 5. Verify

- [x] 5.1 Recompile `modelo-relatorio.tex` with `latexmk` and confirm a clean build. Compiled with `latexmk -xelatex -halt-on-error`: 27 pages, no errors.
- [x] 5.2 Confirm captions render `Figura 1 – Figura de exemplo` and `Tabela 1 – Tabela de exemplo`, with a travessão and no colon anywhere. Confirmed visually on rendered pages 20–21.
- [x] 5.3 Confirm the list entries render `Figura 1 – Figura de exemplo …… 20` and `Tabela 1 – Tabela de exemplo …… 20`, with no overprinting between label and title. Confirmed on rendered LISTA DE FIGURAS/LISTA DE TABELAS pages, after the en-dash-character fix from task 3.1.
- [x] 5.4 Render the page holding the width-declaring example and confirm visually that the caption's left edge, the graphic's left edge and the source note's left edge coincide. Confirmed on rendered page 20 (`Figura 1`).
- [x] 5.5 Confirm the multi-subfigure example — where `\LastGraphicWidth` is an accumulated total rather than a single measurement — still places its `\fonte{}` correctly. Confirmed on rendered page 21 (`Figura 2`): `\fonte{}` spans both subfigures correctly, unaffected by the declared-width mechanism since no width was declared there.
- [x] 5.6 Confirm cross-references (`\reffig`, `\reftable`, `\refcomp`) still resolve, and that the caption changes did not disturb float numbering. Confirmed: `Figura 1`/`Tabela 1` links on page 20 resolve correctly; numbering is sequential and undisturbed.
