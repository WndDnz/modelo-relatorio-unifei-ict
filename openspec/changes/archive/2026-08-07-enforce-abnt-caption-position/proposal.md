## Why

NBR 14724:2024 §5.8/5.9 requires the caption ("Figura N – título" / "Tabela N – título") to sit ABOVE the illustration or table, with the source note ("Fonte: ...") below it. `UnifeiICTReport.sty` only achieves this today because the example chapter (`Capitulos/cap2/cap2.tex`) happens to place `\caption` before `\includegraphics`/`tabular` in every block — nothing in the package enforces or checks this order. A student who writes a new figure with `\includegraphics` before `\caption` (the more common LaTeX habit) gets a silent ABNT violation: no warning, no build error, wrong output.

## What Changes

- **BREAKING**: `UnifeiICTReport.sty` introduces two new wrapper environments, `figuraabnt` and `tabelaabnt`, that take the label and caption text as mandatory environment arguments (typeset immediately, before the body). Authors no longer call `\caption{}`/`\label{}` freely inside the float body for the primary caption — order is guaranteed by the wrapper instead of by convention.
  - Note: the caption package's `position=top` key was considered and rejected — verified against the installed `caption.pdf` manual, it only selects which caption skip-length applies; it does not move a `\caption` call that was written in the wrong place. It cannot deliver the guarantee this change requires.
- The example chapter (`Capitulos/cap2/cap2.tex`) is rewritten to teach `figuraabnt`/`tabelaabnt` instead of raw `figure`/`table` + manual `\caption`.
- The existing `\fonte{}` macro, its `\LastGraphicWidth` measurement, and the `includegraphics`/`tabular`/`subfigure` capture hooks (`UnifeiICTReport.sty` lines ~127–241) are unchanged and still called by the author after the body, as today.
- `figure`/`table` themselves are left untouched (not redefined) to avoid destabilizing LaTeX's float placement internals — `figuraabnt`/`tabelaabnt` are thin wrappers that open a real `figure`/`table` float internally.

## Capabilities

### New Capabilities
- `figure-caption-compliance`: guarantees figure/table captions render above the float content and source notes below it, per NBR 14724:2024, independent of the order authors write `\caption` vs. the float content in their `.tex` source.

### Modified Capabilities
(none — no existing specs in this repo yet)

## Impact

- `UnifeiICTReport.sty`: two new environments (`figuraabnt`, `tabelaabnt`), built with `xparse` following the same pattern already used for the `tabular`/`subfigure` redefinitions.
- `Capitulos/cap2/cap2.tex`: existing figure/table examples (single figure, table, multi-subfigure figure) rewritten to the new environments — this is the model's own teaching material, so it must demonstrate the new interface.
- Any report already started from this template with raw `figure`/`table` blocks will need those blocks migrated to keep compiling correctly against the new expectations — acceptable since this is a template repo with no external consumers yet, but worth a README callout.
- Requires a full recompile + visual check of `modelo-relatorio.tex` (single figure, table, and the multi-subfigure example) to confirm the new environments interact correctly with the `\fonte{}` width-measurement hooks (`\LastGraphicWidth`, the redefined `tabular`/`includegraphics`/`subfigure` environments around `UnifeiICTReport.sty` lines 127–241) and the `longtable` fallback.
- No effect on bibliography, citations, or document structure.
