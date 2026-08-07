## Context

See proposal.md - Why. Key constraint discovered during design: the `caption` package's `position=top` key does not relocate a `\caption` call — verified against the installed `caption.pdf` manual ("position=top does NOT mean that the caption is actually placed at the top of the figure or table. Instead the caption is usually placed where you place the `\caption` command."). Any fix that actually guarantees order has to control where `\caption` gets invoked, not just how much space surrounds it.

`UnifeiICTReport.sty` already has precedent for this kind of wrapper: `tabular`, `includegraphics`, and `subfigure` are all redefined via `xparse`'s `RenewDocumentEnvironment`/`RenewDocumentCommand` to capture content into a box (`\unifeiLastGraphicBox`) and measure its width for `\fonte{}` (lines ~127–241).

## Goals / Non-Goals

**Goals:**
- Guarantee caption-above-content ordering by construction for any report built from this template going forward.
- Reuse the existing `\fonte{}` / width-measurement machinery unchanged.
- Preserve standard float placement behavior (`[!htbp]` etc.).

**Non-Goals:**
- Retrofitting old, already-compiled reports that used raw `figure`/`table` — out of scope, this is a template-level change.
- Enforcing anything about the *optional* secondary `\caption*{}` description text position (norm doesn't clearly govern this for compound figures either — see prior compliance analysis).
- Preventing authors from using raw `figure`/`table` entirely (see Decisions below).

## Decisions

**New environment names (`figuraabnt`/`tabelaabnt`) instead of redefining `figure`/`table` directly.**
Redefining `figure`/`table` themselves would touch LaTeX's float internals (`\@floatplacement`, `[htbp]` parsing, `\@dblfloat`, interactions with any future `float`/`here` package use) — much higher risk of subtle breakage than the existing `tabular`/`subfigure` wraps, which don't touch float mechanics at all. A thin wrapper environment that internally opens a real `figure`/`table` avoids that risk entirely: `figuraabnt`/`tabelaabnt` just call `\begin{figure}[#1]...\end{figure}` with the caption forced in first.
Alternative considered: redefine `figure`/`table` in place (zero new vocabulary, no need to touch cap2.tex's environment names) — rejected for the float-internals risk above, and because it would make every raw `figure` usage anywhere (including any the author writes without thinking) silently change behavior, which is harder to reason about than an opt-in named environment.

**Caption and label as environment arguments, not commands inside the body.**
`\begin{figuraabnt}[!htbp]{fig:label}{Texto da legenda}` — two mandatory `m` args after the standard optional placement `o`. This is what makes the guarantee possible: the wrapper's own code calls `\caption{...}` and `\label{...}` before `#3` (the body) is typeset, so there is no source position for the author to get wrong.
Alternative considered: keep `\caption{}` callable inside the body but have the wrapper detect and hoist it — rejected, this would require parsing/extracting a `\caption{...}` call out of arbitrary TeX body content, which is fragile (breaks on `\caption[short]{long}`, nested environments, etc.) and is exactly the kind of complexity `tabular`'s box-capture approach deliberately avoids.

**Inside the wrapper, `\caption` must be emitted before `\label`.**
Verified by compiling both orders against a real `figure` float: with `\label` first, `\ref` to that label resolves to the chapter counter ("1") instead of the float number ("1.3") — `\label` captures whatever counter is current, and it's `\caption` that steps the float counter. This is invisible at build time (no error, no warning), so it's exactly the kind of thing that ships broken. The `.sty` gets a comment marking the ordering as load-bearing.

**`\fonte{}` stays a separate, manually-called command, INSIDE the environment body, after the content.**
Corrected during implementation: an earlier draft of this document claimed `\fonte{}` was already called after `\end{figure}`. It is not — every existing example calls it as the last thing *inside* the float (`cap2.tex:293, 308, 332`). That placement is load-bearing: a float is typeset as a unit and moves to wherever LaTeX places it, so a `\fonte{}` written after `\end{figuraabnt}` would detach from its figure and stay in the running text. It also has to run while `\LastGraphicWidth` still holds the value the body just measured. Keeping it inside is both correct and a no-op for the interface — no change to `\fonte{}` itself.

**Environment signature is `O{!htbp} m m o`, not `o m m b`.**
Two deviations from the original task text. (a) No `b` body-capture argument: capturing the body as balanced tokens is unnecessary here — the wrapper only needs to emit `\caption`/`\label` in its *begin* code, and the body then typesets normally. Capturing it would freeze catcodes at read time and break `verbatim`/`\verb` inside a float for no gain. (b) The placement argument defaults to `!htbp` (`O{!htbp}`), matching what every existing example passed explicitly, and a trailing optional argument carries the short caption for the List of Illustrations — the multi-subfigure example already used `\caption[Figura múltipla]{...}`, so dropping short-caption support would have been a regression.

**Secondary `\caption*{}` description text remains usable inside the body, uncontracted.**
The existing example uses `\caption*{...}` for supplementary description (e.g., cap2.tex:272). This isn't the primary "Figura N – título" the norm governs the position of, so no guarantee is made about it — author places it wherever makes sense in the body.

## Risks / Trade-offs

- [Breaking change to authoring interface] → Mitigation: this is a template repo pre-adoption; the only place using the old pattern is the example chapter itself, which this change rewrites. Document the new environments prominently in `cap2.tex`'s citations/figures section (already the natural teaching spot).
- [Float-internals edge cases not covered by manual testing] → Mitigation: task list includes compiling and visually diffing all three existing figure/table examples (single figure, table, multi-subfigure) plus a `longtable` case, since `\fonte{}`'s `longtable` fallback (`UnifeiICTReport.sty` ~177–190) hooks `\AtEndEnvironment{longtable}` and needs to keep working when `longtable` is used inside `tabelaabnt`.
- [Raw `figure`/`table` still usable with no guarantee] → Accepted (see Decisions): forbidding raw floats outright would mean redefining `figure`/`table`, which was rejected for risk reasons above. The gap is smaller now (opt-in vs. default-fragile) but not zero — worth a one-line comment in the `.sty` near the environment definitions noting this explicitly, so a future maintainer doesn't assume raw floats are also covered.

## Open Questions

None — the approach was chosen directly with the user (macro wrapper over documentation-only) after the `position=top` dead end was found.
