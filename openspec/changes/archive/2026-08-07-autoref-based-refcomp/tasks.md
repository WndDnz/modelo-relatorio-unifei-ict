## 1. Redefine the autorefname cascade

- [x] 1.1 In `UnifeiICTReport.sty`, near the `hyperref` load (line ~114) or near the other `\AtBeginDocument`/language-hook code, add one `\AtBeginDocument{...}` block with four `\renewcommand`s: `\chapterautorefname`→"Seção", `\sectionautorefname`→"Subseção", `\subsectionautorefname`→"Subsubseção", `\subsubsectionautorefname`→"Parágrafo".
- [x] 1.2 Add a comment explaining why `\AtBeginDocument` is required here (hyperref overrides `\addto\captionsbrazilian` and bare preamble `\renewcommand` — see design.md Decisions), and why all four levels are redefined together (avoiding the chapter/section name collision — see design.md Decisions), so a future editor doesn't "simplify" it back to a bare `\renewcommand` or touch only one level.

## 2. Rewrite `\refcomp` with starred/unstarred behavior

- [x] 2.1 In `UnifeiICTReport.sty`, replace the `\refcomp` definition (line ~533) with an `xparse` `\NewDocumentCommand{\refcomp}{s m m}` implementation: unstarred branch uses `\autoref*{#3} - \nameref*{#3}` (ignoring `#2`); starred branch keeps today's literal `#2~\ref*{#3} - \nameref*{#3}` behavior.
- [x] 2.2 Confirm `\reffigcomp`, `\reftablecomp`, `\refeqcomp` (lines ~547–554) still compile unchanged, since they call `\refcomp` unstarred.

## 3. Fix and rewrite example-chapter usage

- [x] 3.1 In `Capitulos/cap1/cap1.tex:35`, the two `\refcomp{Capítulo}{...}` calls now correctly auto-resolve to "Seção" — verify the surrounding sentence still reads naturally with "Seção" instead of "Capítulo" (may need a small prose tweak, e.g. "A Seção 1 apresenta..." instead of "O Capítulo 1 apresenta...").
- [x] 3.2 In `Capitulos/cap2/cap2.tex` ~lines 99–103, rewrite the explanatory paragraph about `\refcomp{}{}`: explain the unstarred form auto-resolves the type name (no longer "digite o tipo em maiúsculas"), that the argument is now ignored for standard divisions, and list the cascaded names explicitly (chapter→Seção, section→Subseção, subsection→Subsubseção, subsubsection→Parágrafo) since "Capítulo, Seção, Subseção etc." (current line 100) is now wrong on two counts — the word list and the claim that the argument controls the name.
- [x] 3.3 Add a short new example demonstrating `\refcomp*{Tipo}{label}` for a label outside the standard hierarchy (e.g., a custom counter), so the star's purpose is taught, not just mentioned.
- [x] 3.4 Update the subsubsection example (~line 109, `\refcomp{Subsubseção}{sss:exemplo}`) — output now resolves to "Parágrafo", not "Subsubseção" — update the surrounding prose (~lines 105–109, which currently says "Assim como as seções e subseções, as subsubseções...") so it doesn't contradict the new cascaded name.
- [x] 3.5 Check the subsection example prose (~lines 95–103, `\subsection{Subseção de exemplo}\label{ssc:exemplo}`) — the section heading text itself says "Subseção de exemplo" but `\refcomp{Subseção}{ssc:exemplo}` now resolves to "Subsubseção" (since this is a `\subsection`, which cascades to "Subsubseção") — decide whether to reword the heading text too, to avoid the heading title and the auto-resolved reference name visibly disagreeing.

## 4. Verify

- [x] 4.1 Recompile `modelo-relatorio.tex` with `latexmk`.
- [x] 4.2 Visually confirm every existing `\refcomp`/`\reffig`/`\reftable`/`\refeqcomp` call in the compiled PDF against the full cascade: chapter-level → "Seção", section → "Subseção", subsection → "Subsubseção", subsubsection → "Parágrafo" — each distinct, figure/table/equation references unchanged from before this change.
- [x] 4.3 Confirm the new `\refcomp*{...}` example (task 3.3) renders with its literal type name as expected.
- [x] 4.4 Confirm all hyperlinks (`\hyperref`) still resolve to the correct target after the `\refcomp` rewrite.
