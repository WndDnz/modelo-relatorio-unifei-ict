## 1. Implement `figuraabnt` environment

- [x] 1.1 In `UnifeiICTReport.sty`, define `figuraabnt` via `xparse` (`O{!htbp} m m o` signature: optional placement, mandatory label, mandatory caption, optional short caption — see design.md Decisions for why no `b` body-capture) that opens `\begin{figure}[#1]`, calls `\caption{#3}` **then** `\label{#2}` (in that exact order), before typesetting the body `#4`, then closes `\end{figure}`.
- [x] 1.1a CRITICAL ordering constraint — `\label` MUST come after `\caption`, never before. Verified by compiling both orders: `\label` before `\caption` makes `\ref` resolve to the chapter counter ("1") instead of the float number ("1.3"), silently breaking every cross-reference to that float. Add a `.sty` comment stating this so a future editor doesn't reorder them.
- [x] 1.2 Confirm the existing `includegraphics`/`subfigure` width-capture hooks (lines ~127–241) still fire correctly when invoked from inside the body of `figuraabnt` (they hook on the environment names themselves, not on `figure`, so this should be unaffected — verify by compiling).
- [x] 1.3 Add a one-line `.sty` comment near the environment definitions noting that raw `figure`/`table` remain usable but make no caption-position guarantee (per design.md Risks).

## 2. Implement `tabelaabnt` environment

- [x] 2.1 Define `tabelaabnt` the same way as `figuraabnt` (including the `\caption`-before-`\label` ordering from 1.1a), wrapping `table` instead of `figure`.
- [x] 2.2 Verify the `tabular`-capture hook and the `longtable` `\AtEndEnvironment` fallback (lines ~177–190) both still measure width correctly when `tabular`/`longtable` is used inside `tabelaabnt`'s body.

## 3. Rewrite example chapter

- [x] 3.1 In `Capitulos/cap2/cap2.tex`, replace the single-figure example (current lines ~268–275) with `figuraabnt`, moving the caption text into the environment argument; keep `\fonte{}` called after `\end{figuraabnt}` as today.
- [x] 3.2 Replace the table example (current lines ~277–290) with `tabelaabnt` the same way.
- [x] 3.3 Replace the multi-subfigure example (current lines ~296–314) with `figuraabnt`, keeping the per-subfigure `\caption{}`/`\caption*{}` calls inside the body unchanged (only the top-level caption moves to the environment argument).
- [x] 3.4 Update the explanatory prose immediately before/after these examples (currently describes calling `\caption`/`\label` manually) to describe the new environment signature instead.

## 4. Verify

- [x] 4.1 Recompile `modelo-relatorio.tex` with `latexmk` (per the project's `.latexmkrc`, xelatex pipeline) and confirm it builds cleanly.
- [x] 4.2 Visually inspect the rendered PDF: single figure, table, and multi-subfigure figure all show caption above content and `Fonte:` below, matching current output.
- [x] 4.3 Confirm float placement (`[!htbp]`) still behaves as expected — figures/tables still float to a sensible page position, not forced inline or misplaced.
- [x] 4.4 Confirm cross-references (`\reffig{}`, `\reftable{}`, `\ref{}` to the `figuraabnt`/`tabelaabnt` labels) still resolve correctly.
