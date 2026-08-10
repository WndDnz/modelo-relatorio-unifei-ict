## Why

Two groups of structural elements required or contemplated by ABNT NBR 14724:2024 have no support at all in the template today. They are grouped in one change because they share the same underlying problem: both are document divisions that live *outside* the numbered body, and the template's structural machinery (`\frontmatter`/`\mainmatter` redefined at `UnifeiICTReport.sty:997–1012`, `\titleformat{\chapter}` at line ~883, the `\chapterautorefname` cascade at lines ~132–137) assumes everything is either a pre-textual element or a numbered primary section. Neither assumption holds for an approval sheet or an appendix.

**Folha de aprovação** — §4.2.1.3, mandatory, inserted after the title page. Constituted by author name, title and subtitle, natureza, approval date, and the name, titulação and signature of the examining board members plus their institutions. §5.2.4 classifies it as an element with neither title nor numeric indicative; §5.2 requires the natureza set in single spacing and aligned from the middle of the text block to the right margin. The template produces no such page, so every report built from it is missing a mandatory element.

The norm reaches further than "thesis and dissertation": §1 Escopo states it "aplica-se, no que couber, aos trabalhos acadêmicos e similares, intra e extraclasse", and §4.2.1.1.1(e) names *"aprovação em disciplina"* as a valid objetivo within the natureza. A course-report approval sheet is therefore a case the norm contemplates, not a local deviation. What genuinely varies by work type is who signs and what fields exist — a course report has a professor and possibly a grade, a TCC has an examining board, an internship report adds a company supervisor.

**Apêndices e anexos** — §4.2.3.3 and §4.2.3.4, optional post-textual. Each must be preceded by the word APÊNDICE or ANEXO, identified by consecutive capital letters, a travessão and the respective title, with doubled letters once the alphabet is exhausted, and with the same typographic emphasis as the primary section. §5.2.3 classifies them as titles without numeric indicative, to be centered. §5.3 requires their pagination to continue that of the main text.

The template offers nothing here, and the naive workaround is actively broken: `\appendix` from `book` makes `\thechapter` a letter, but this template's `\titleformat{\chapter}` prints the counter bare — the reader would get `A` with no word. `\backmatter`, which the driver already invokes at `modelo-relatorio.tex:133`, switches chapters to unnumbered, which removes the letter the norm requires. And the `\chapterautorefname` cascade pins the primary-section name to "Seção" document-wide, so a cross-reference to an appendix would read "Seção A".

## What Changes

- A single `\folhaaprovacao` command, parameterized by work type, defaulting to the course-report type. It renders the elements §4.2.1.3 requires, drawing on metadata already declared in the preamble (`\title`, `\author`, `\supervisor`, `\subject`) plus new type-specific metadata. Emits nothing unless invoked, so existing documents are unaffected.
- Four work types supported: relatório de disciplina (default), relatório de estágio, trabalho de conclusão de curso, dissertação de mestrado. The type selects which fields appear and who signs.
- New preamble metadata for the fields the current commands do not cover: examining board members with titulação and institution, approval date, natureza text, and the type-specific extras (grade, company supervisor).
- Post-textual `apendices` and `anexos` support: each entry titled `APÊNDICE A — Título` / `ANEXO A — Título`, centered, letter-sequenced independently per group, styled like the primary section, with pagination continuing the main text.
- Cross-references into appendices resolve to "Apêndice"/"Anexo" rather than "Seção", by switching the `autoref` name when entering each group.
- The example chapter and driver demonstrate both, and the README documents them.

## Capabilities

### New Capabilities

- `approval-sheet`: the mandatory folha de aprovação, its required content per §4.2.1.3, its typographic rules per §5.2 and §5.2.4, and the selection of a layout by work type.
- `appendix-annex`: post-textual appendices and annexes — their identification by consecutive capital letters per §4.2.3.3/§4.2.3.4, their centered untitled-indicative heading per §5.2.3, their continuous pagination per §5.3, their appearance in the sumário, and their cross-reference naming.

### Modified Capabilities

(none — `openspec/specs/` is empty. `internal-cross-reference-naming`, from the completed `autoref-based-refcomp` change, is closely related: this change adds appendix and annex names to the cascade it established. Once that change is archived, the appendix naming requirement should be reconsidered as a delta against it rather than as part of `appendix-annex`.)

## Impact

- `UnifeiICTReport.sty`: new metadata-holding commands; the `\folhaaprovacao` command and its per-type layouts; a post-textual heading style for appendices and annexes; a state switch for the `autoref` name; likely a `\backmatter` redefinition, since the inherited one is incompatible with letter-identified appendices.
- `modelo-relatorio.tex`: `\folhaaprovacao` invoked after `\maketitle`; appendix and annex sections demonstrated after `\printbibliography`; new metadata fields in the preamble block.
- `Capitulos/`: at least one example appendix and one example annex, since the model teaches by example.
- `README.md`: metadata table and the new commands.
- Interacts with `enforce-abnt-caption-position` and `autoref-based-refcomp` (both complete, unarchived): illustrations inside appendices must keep working, and the cross-reference cascade gains two names.
- No effect on bibliography, citations, or the numbering of the main body.
