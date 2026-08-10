## Why

ABNT NBR 14724:2024 §5.8 does not speak of figures. It speaks of illustrations, each preceded by **its own designative word**:

> "Qualquer tipo de ilustração deve ser precedido por sua palavra designativa (desenho, esquema, fluxograma, fotografia, gráfico, mapa, organograma, planta, quadro, retrato, figura, imagem, entre outros), seguida de seu número de ordem de ocorrência no texto, em algarismos arábicos, de travessão e do respectivo título."

The template offers exactly one word — "Figura" — for all of them. A chart is a Gráfico, a structured textual table is a Quadro, and a report that labels either as "Figura" is not conformant. §4.2.1.9 goes further and recommends a separate list per illustration type when warranted, showing `Quadro 1 — Análise de erro técnico…` as its own example entry.

The Quadro case is the sharpest, because it is not a naming preference but a category error. A quadro is an illustration; a tabela is not. The UFV guide states the boundary: a tabela is *"a forma não discursiva de apresentar informações das quais o dado numérico se destaca como informação central"*, and the norm binds tables to the IBGE *Normas de apresentação tabular*, listing them separately in §5.9 and giving them their own list in §4.2.1.10. Structured textual content set as a `tabelaabnt` today is labelled "Tabela" and lands in the LISTA DE TABELAS, where by the norm it does not belong.

This change generalizes the illustration type. It depends on `fix-abnt-caption-label-format` landing first, so that new types inherit the correct separator, margin behavior and list-entry format rather than replicating three known defects across a wider surface.

## What Changes

- The illustration environment is generalized so the designative word is a property of the illustration, not hardcoded. `figuraabnt` remains, and becomes one type among several.
- Ships concrete types for the cases that actually occur in ICT reports: Figura, Quadro, Gráfico. The mechanism is open, so a document needing Fluxograma or Organograma can declare one without patching the package.
- Each type carries its own arabic order sequence, per §5.8.
- Each type can have its own list, per §4.2.1.9. The existing LISTA DE FIGURAS stays; LISTA DE QUADROS and others become available.
- `tabelaabnt` is unchanged and stays a separate category, bound to §5.9 and the IBGE tabular rules — not folded into the illustration mechanism.
- The example chapter teaches the Quadro/Tabela distinction explicitly, since it is the one authors get wrong.
- Cross-reference commands resolve to the correct designative word per type.

## Capabilities

### New Capabilities

- `illustration-types`: the designative word as a property of each illustration, per-type numbering sequences, per-type lists, and the boundary between illustration and table per §5.8/§5.9.

### Modified Capabilities

(none — `openspec/specs/` is empty. Two completed but unarchived changes are adjacent: `figure-caption-compliance` from `enforce-abnt-caption-position` governs caption position, and `illustration-caption-format` from `fix-abnt-caption-label-format` governs caption format. Both apply to every type introduced here; neither needs its requirements changed. Once those are archived, revisit whether any requirement here is better expressed as a delta against them.)

## Impact

- `UnifeiICTReport.sty`: the `figuraabnt` definition generalizes; new counters and list files per type; `\reffig`-family cross-reference commands gain per-type equivalents; the `\listoffigures` styling at lines ~911–928 becomes a pattern applied per list.
- `Capitulos/cap2/cap2.tex`: new Quadro and Gráfico examples, and prose teaching the Quadro/Tabela boundary.
- `modelo-relatorio.tex`: additional list-printing commands in the pre-textual block, commented out by default like the existing optional lists.
- `README.md`: the illustration-environment documentation covers the type mechanism.
- Depends on `fix-abnt-caption-label-format`. Applying this first would mean fixing the travessão, the margin alignment and the list-entry format across three types instead of one.
- No effect on bibliography, citations, or document structure.
