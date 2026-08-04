## Why

The template's cross-reference command, `\refcomp{Tipo}{label}`, requires the author to manually type the division-type word ("Capítulo", "Seção", "Subseção"...) on every call. This is already wrong in the shipped example: `Capitulos/cap1/cap1.tex:35` writes `\refcomp{Capítulo}{cap:introducao}`, printing the literal word "Capítulo" — which contradicts the earlier decision (this template's primary divisions must never be labeled "Capítulo" in output, even though they're built with `\chapter` internally). The bug is structural, not a typo: nothing stops any future author from typing the wrong word for any label, the same class of correctness-depends-on-discipline problem already found and fixed for figure/table caption ordering (see `enforce-abnt-caption-position`).

## What Changes

- `\refcomp` becomes a starred command (`s m m` via `xparse`): the unstarred form ignores its type-name argument and auto-resolves the correct name via hyperref's `\autoref`, already loaded and already shipping correct Portuguese names for chapter/section/subsection/subsubsection/figure/table/equation. The starred form (`\refcomp*{Tipo}{label}`) keeps today's literal-string behavior, for labels outside the autoref-resolvable hierarchy (custom counters, list items, custom theorem-like environments) — confirmed by testing that plain `\autoref` on a custom counter silently prints just the bare number with no type name.
- Demoting `\chapter` to "Seção" cascades down the whole hierarchy, since every level below it shifts down one name to avoid colliding with the level it now borrows from: `\chapterautorefname` "Capítulo"→"Seção", `\sectionautorefname` "Seção"→"Subseção", `\subsectionautorefname` "Subseção"→"Subsubseção", `\subsubsectionautorefname` "Subsubseção"→"Parágrafo" (the lowest numbered level in this template — `secnumdepth=3` stops at subsubsection, and LaTeX's real `\paragraph` command isn't used here, so there's no collision with an actual paragraph-level heading). All four redefinitions go via `\AtBeginDocument` — confirmed by testing that this is the only hook that reliably wins: neither a bare `\renewcommand` in the preamble nor `\addto\captionsbrazilian{...}` survives hyperref's own later internal override; `\AtBeginDocument`, queued after hyperref loads, does.
- Section/subsection/subsubsection headings already print only the bare number (`\thesection` etc., no literal type word) via the existing `titlesec` `\titleformat` configuration (`UnifeiICTReport.sty` lines 799–801) — same pattern already confirmed for `\chapter`. So this cascade only affects cross-reference prose (`\autoref`, `\refcomp`), never the headings themselves.
- `\reffigcomp`, `\reftablecomp`, `\refeqcomp` keep calling `\refcomp` unstarred internally — unaffected, since `\autoref` already resolves figure/table/equation labels to the same names those wrappers pass today.
- Usage instructions in the example chapters (`Capitulos/cap1/cap1.tex:35`, `Capitulos/cap2/cap2.tex` ~lines 99–109) are rewritten to demonstrate and explain the new starred/unstarred distinction, and the existing `\refcomp{Capítulo}{...}` calls are fixed to the correct (now automatic) usage.

## Capabilities

### New Capabilities
- `internal-cross-reference-naming`: guarantees that a cross-reference to a standard sectioning/float division (chapter-as-section, section, subsection, subsubsection, figure, table, equation) prints the correct division name automatically, without depending on the author typing it correctly, while still allowing an explicit escape hatch for labels outside that hierarchy.

### Modified Capabilities
(none — no existing specs in this repo yet)

## Impact

- `UnifeiICTReport.sty`: `\refcomp` redefinition (`s m m` signature) and one `\AtBeginDocument` block with four `\renewcommand`s (chapter/section/subsection/subsubsection autorefnames).
- `Capitulos/cap1/cap1.tex`, `Capitulos/cap2/cap2.tex`: fix the already-wrong `\refcomp{Capítulo}{...}` calls, rewrite the explanatory prose around `\refcomp` usage, and update the subsection/subsubsection example prose to match the cascaded names.
- `\reffigcomp`/`\reftablecomp`/`\refeqcomp`: no interface change, verify output unchanged after recompile.
- Requires a recompile + visual check that every existing `\refcomp`/`\reffig`/`\reftable`/`\refeqcomp` call in the document still resolves correctly against the full cascaded naming: chapter-level → "Seção", section → "Subseção", subsection → "Subsubseção", subsubsection → "Parágrafo" — each level distinct, none falling back to a neighboring level's name.
