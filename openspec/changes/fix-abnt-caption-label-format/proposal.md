## Why

Three conformance defects in how the template presents figure and table captions, all verified against ABNT NBR 14724:2024 §5.8 and §4.2.1.9/§4.2.1.10 and all visible in the compiled `modelo-relatorio.pdf` today:

1. **Wrong separator.** §5.8 requires the designative word, the arabic number, a **travessão** and then the title. The template renders `Figura 1: Figura de exemplo` — a colon. It comes from the `caption` package's default `labelsep`, which `UnifeiICTReport.sty:282` never overrides. The norm's own examples are unambiguous: `Gráfico 1 – Quantidade de alunos por curso`, `Quadro 1 — Análise de erro técnico…`, `Tabela 1 — Perfil socioeconômico…`
2. **Caption ignores the illustration's margins.** §5.8: *"Tipo, número de ordem, título, fonte, legenda e notas devem acompanhar as margens da ilustração."* Today the caption is set across the full text block while `\fonte{}` aligns to the measured graphic width — so the same float has two different left edges, and neither matches the norm when the graphic is narrower than the text block.
3. **List entries lack the designative word and the travessão.** §4.2.1.9 requires each list item to be *"designado por seu nome específico, travessão, título e respectivo número da folha ou página"*; §4.2.1.10 says the same for tables, naming the word `Tabela` explicitly. The template's LISTA DE FIGURAS prints `1   Figura de exemplo` — bare number, no word, no travessão.

These are defects in already-shipped behavior, not missing features. They affect every figure and table in every report built from this template, including the `figuraabnt`/`tabelaabnt` environments added by `enforce-abnt-caption-position`. Fixing them first means the illustration-type work that follows (Quadro, Gráfico, etc.) inherits correct formatting instead of replicating three bugs across new types.

## What Changes

- `UnifeiICTReport.sty` sets a travessão as the caption label separator for figures and tables, replacing the package default colon.
- `figuraabnt` and `tabelaabnt` accept an optional width; when given, the caption, the content and `\fonte{}` all share that width and the same left and right edges, satisfying §5.8. When omitted, current behavior is preserved (caption across the text block, `\fonte{}` on the measured width) so no existing document breaks.
- `\l@figure` and `\l@table` are redefined so list entries read `Figura 1 – Título …… 20`, with the number box widened enough to hold the word plus number plus travessão.
- The example chapter demonstrates the width argument on the single-figure example, and the prose explains why it exists.

Not breaking: every change is either a formatting default or an opt-in optional argument. Documents written against the current interface keep compiling and only change appearance where the norm requires it.

## Capabilities

### New Capabilities
- `illustration-caption-format`: governs the typographic presentation of figure and table captions — label separator, alignment relative to the illustration, and the format of the corresponding entries in the lists of illustrations and tables, per NBR 14724:2024 §5.8, §4.2.1.9 and §4.2.1.10.

### Modified Capabilities
(none — `openspec/specs/` is empty; `figure-caption-compliance`, from the completed `enforce-abnt-caption-position` change, is a distinct concern: it governs caption *position* relative to the content, this one governs caption *format*. The two do not overlap.)

## Impact

- `UnifeiICTReport.sty`: `\captionsetup` near line 282; `\l@figure`/`\l@table` added near the existing `\l@chapter`/`\l@section` redefinitions (lines ~955–995); the `figuraabnt`/`tabelaabnt` definitions gain an optional width key.
- `Capitulos/cap2/cap2.tex`: the figure/table examples and the surrounding explanatory prose.
- `README.md`: the `figuraabnt`/`tabelaabnt` entry documents the new optional width.
- Visual change to every existing figure and table caption and to both lists. Page count may shift by one.
- No effect on bibliography, citations, cross-references, or document structure.
