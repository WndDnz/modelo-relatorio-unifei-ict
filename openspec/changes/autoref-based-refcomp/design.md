## Context

See proposal.md - Why. `UnifeiICTReport.sty` already loads `hyperref` (line 114) and already sets `\setcounter{secnumdepth}{3}` (line 847), so subsubsections are numbered and hyperref's Portuguese `\subsubsectionautorefname` ("Subsubseção") applies correctly — confirmed by compiling a minimal reproduction with the same `secnumdepth`. All findings below came from compiling small standalone test files against the installed TeX Live, not from documentation alone.

## Goals / Non-Goals

**Goals:**
- Make chapter-level references say "Seção", not "Capítulo", automatically, everywhere, without per-call author discipline.
- Preserve an explicit fallback for labels `\autoref` can't or shouldn't name automatically.
- Zero behavior change for the existing `\reffigcomp`/`\reftablecomp`/`\refeqcomp` wrappers.

**Non-Goals:**
- Auto-detecting appendix/anexo labels (`\appendixautorefname` exists in hyperref, but this template has no appendix/anexo macro yet — out of scope until that's built).
- Changing the "Tipo N - Nome" output format itself (only how the "Tipo" part is determined).

## Decisions

**All four autorefnames must be redefined via `\AtBeginDocument`, not `\addto\captionsbrazilian` or a bare preamble `\renewcommand`.**
Tested all three approaches directly (initially with just `\chapterautorefname`, confirmed the same hook applies to all four):
- Bare `\renewcommand{\chapterautorefname}{Seção}` before `\begin{document}`: overridden — hyperref sets its own value later. Result: "Capítulo".
- `\addto\captionsbrazilian{\renewcommand{\chapterautorefname}{Seção}}`: also overridden. Result: "Capítulo". hyperref's autorefname strings are not wired through babel's `\captions<lang>` mechanism at all — they're set by hyperref's own internal per-language block (`\HyLang@portuges`), independently.
- `\AtBeginDocument{\renewcommand{\chapterautorefname}{Seção}}`, placed in the `.sty` (so it's queued after hyperref.sty's own `\AtBeginDocument`-queued redefinition): wins. Result: "Seção 1 - Introdução". Confirmed by compiling.
This is a LaTeX hook-ordering fact specific to this hyperref version, not guesswork — future hyperref updates could in principle change the queuing order, so this is worth a one-line comment in the `.sty` explaining why `\AtBeginDocument` is required here (a bare `\renewcommand` looking "simpler" is a trap a future editor could fall into).

**The demotion cascades through all four levels, not just chapter.**
Demoting `\chapter` to "Seção" alone would leave `\section` still also named "Seção" via `\sectionautorefname` — a collision, two different structural levels both called "Seção". The user's fix: shift every level down one name — chapter takes what was section's name, section takes what was subsection's name, subsection takes what was subsubsection's name, and subsubsection (the lowest numbered level here, `secnumdepth=3`) takes "Parágrafo". Confirmed end-to-end by compiling all four redefinitions together in one `\AtBeginDocument` block: "Seção 1 - Intro; Subseção 1.1 - Sec; Subsubseção 1.1.1 - Sub; Parágrafo 1.1.1.1 - Subsub" — four distinct names, no collision, no dropped `\nameref`.
No collision with LaTeX's actual `\paragraph` command: this template doesn't use `\paragraph` (numbering stops at subsubsection per `secnumdepth=3`), so "Parágrafo" is free to reuse as the subsubsection's autoref name without shadowing a real, separately-numbered paragraph level.
Section/subsection/subsubsection headings themselves are unaffected by any of this — like `\chapter` (`UnifeiICTReport.sty` line 796), they already print only `\thesection`/`\thesubsection`/`\thesubsubsection` via `titlesec`'s `\titleformat` (lines 799–801), with no literal type word in the heading. Only `\autoref`-based cross-reference prose changes.

**`\refcomp` gains a star (`xparse` `s m m`), not a new command name.**
Keeps `\reffigcomp`/`\reftablecomp`/`\refeqcomp` (which call `\refcomp` internally) working with zero changes to them. Alternative considered: a new `\refcompauto{label}` (1-arg) command alongside the existing 2-arg `\refcomp`, leaving `\refcomp` itself untouched — rejected because it does nothing about the already-wrong `\refcomp{Capítulo}{...}` calls already in the example chapters; the whole point is that the safe behavior should be the default, with the unsafe/manual behavior opt-in via `*`, not the other way around.

**Unstarred `\refcomp` ignores rather than validates its first argument.**
Simpler than cross-checking the passed string against what `\autoref` would produce and warning on mismatch. Given the type name becomes irrelevant for the auto-resolved path, `\reffigcomp` etc. can keep passing `\figurename` etc. as before without needing to change — the argument is accepted for backward-compatible call shape, just not used for the printed name.

## Risks / Trade-offs

- [Hyperref changes its internal hook-queue order in a future release, breaking the `\AtBeginDocument` override] → Mitigation: covered by task 4 (recompile + visual check) on every future template update, plus the explanatory comment in the `.sty`. Low likelihood — this is long-stable hyperref internals.
- [Author forgets the star and gets a bare number with no name, for a custom-counter label] → Mitigation: task 3 rewrites the example chapter prose to explicitly teach when the star is needed, with a worked example, not just document the syntax.
- [Existing `\refcomp{Capítulo}{...}` calls elsewhere in the document silently start printing "Seção" — a wording change, not a break, but worth a human look] → Not a risk to mitigate, this is the intended fix; called out here only so the recompile/verify step actually reads the changed output rather than just checking it compiles.
