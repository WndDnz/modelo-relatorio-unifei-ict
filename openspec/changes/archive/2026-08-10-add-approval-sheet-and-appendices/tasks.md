## 1. Spike: the `autoref` name switch

- [ ] 1.1 FIRST, before any design is fixed. Build a throwaway document with a main body and two appendices, switching `\chapterautorefname` at the appendix boundary, and place four cross-references: main body → main body, main body → appendix, appendix → appendix, appendix → main body. Compile and read the rendered PDF.
- [ ] 1.2 Determine from that whether hyperref resolves the autoref name at reference-expansion time (in which case a naive global switch retroactively renames main-body references that appear after the switch) or at label time. Record the answer in design.md — this determines the whole approach and is the highest-risk unknown in this change.
- [ ] 1.3 If the naive switch fails, evaluate per-label naming — for example a dedicated counter with its own `\...autorefname`, or the template's own starred `\refcomp*` — and record what was chosen and why.

## 2. Appendix and annex structure

- [ ] 2.1 Verify what `\backmatter` does to the chapter counter in this template as it stands, by compiling. The inherited `\backmatter` sets `\@mainmatterfalse`, which makes `\chapter` unnumbered — confirm this against the actual build before designing around it, since `\frontmatter`/`\mainmatter` are already redefined here (`UnifeiICTReport.sty:997–1012`) and the interaction is not obvious from reading.
- [ ] 2.2 Provide commands opening the appendix group and the annex group, each with an independent capital-letter sequence.
- [ ] 2.3 Provide a heading style: word + letter + travessão + title, centered, carrying the same emphasis as the primary section (`\unifeifont`, `unifeiblue`, `\Large\bfseries`, uppercase — see `UnifeiICTReport.sty:883`), with no numeric indicative.
- [ ] 2.4 Handle letters past Z per §4.2.3.3 (`AA`, `BB`, …), or fail with an explicit message naming the limit. `\Alph` overflows with a raw LaTeX error past 26, so doing nothing means a hard failure in exactly the case the norm names.
- [ ] 2.5 Confirm pagination continues the main text without restarting or changing style (§5.3).
- [ ] 2.6 Add collective `APÊNDICES` and `ANEXOS` entries to the sumário, without section numbers, matching the UFV published model.
- [ ] 2.7 Verify a figure and a table placed inside an appendix still continue the document's float sequences and still appear in the lists — `\counterwithout{figure}{chapter}` at line ~275 should make this work, but verify rather than assume.

## 3. Approval sheet metadata

- [ ] 3.1 Design the public interface for examining board members: each needs name, titulação and institution, which does not fit the flat `\supervisor{...}` pattern used today. Whatever is chosen is what authors write against, so settle it before implementing the layouts.
- [ ] 3.2 Add metadata for the approval date, the natureza text, and the type-specific extras — company supervisor for the internship type, and the grade field if question 2 in design.md's Open Questions is answered yes.
- [ ] 3.3 Reuse existing declarations (`\title`, `\subtitle`, `\author`, `\supervisor`, `\subject`) rather than requiring them to be restated.

## 4. Approval sheet command

- [ ] 4.1 Implement the command with a type parameter defaulting to the course-report type, and an explicit error listing the supported types when an unknown one is given.
- [ ] 4.2 Implement the four layouts: course report, internship report, undergraduate final project, master's dissertation.
- [ ] 4.3 Set the natureza in single spacing, aligned from the middle of the text block to the right margin (§5.2). Note this is the same rule the title page already follows — check whether `\maketitle` already implements it and reuse rather than duplicate.
- [ ] 4.4 Emit no heading, no section number and no sumário entry (§5.2.4).
- [ ] 4.5 Render correctly-shaped blank signature blocks when board members have not been declared. This is the normal case, not an error — the sheet is printed to be signed (§4.2.1.3). Do not warn.
- [ ] 4.6 Comment in the `.sty` which types are norm-contemplated and which are institutional adaptation: the course report is covered by §1 Escopo and §4.2.1.1.1(e), the internship report only by "e similares". This prevents a future editor from "correcting" the course-report layout on the false belief that it is unregulated.

## 5. Example document

- [ ] 5.1 Invoke the approval sheet in `modelo-relatorio.tex` after `\maketitle`, with the default type, and comment how to select the others.
- [ ] 5.2 Add one example appendix and one example annex, with content that teaches the apêndice/anexo distinction the norm draws by authorship (§3.3, §3.4) — an appendix is the author's own, an annex is someone else's.
- [ ] 5.3 Put a figure or table inside one of them, to exercise task 2.7 in the model itself.
- [ ] 5.4 Document the new commands and metadata in `README.md`.

## 6. Verify

- [ ] 6.1 Recompile `modelo-relatorio.tex` with `latexmk` and confirm a clean build.
- [ ] 6.2 Render the approval sheet and check it against §4.2.1.3's content list item by item, and against the two UFV published models for plausibility of layout.
- [ ] 6.3 Confirm the appendix and annex headings read `APÊNDICE A — Título` and `ANEXO A — Título`, centered, with the primary section's emphasis and no section number.
- [ ] 6.4 Confirm the letter sequences are independent between the two groups.
- [ ] 6.5 Confirm page numbers continue unbroken from the last page of the main text into the appendices.
- [ ] 6.6 Confirm all four cross-reference combinations from task 1.1 resolve to the right names in the final document, not just in the spike.
- [ ] 6.7 Confirm a document that invokes neither the approval sheet nor any appendix still renders identically to the pre-change build.
