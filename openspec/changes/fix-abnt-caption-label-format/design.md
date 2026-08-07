## Context

See proposal.md — Why. All three defects were confirmed empirically, not inferred: the colon and the bare-number list entries are visible in the current compiled `modelo-relatorio.pdf`, and the caption/`\fonte{}` misalignment follows from `\fonte{}` using `\LastGraphicWidth` (`UnifeiICTReport.sty:627`) while the caption uses the full text block.

The relevant existing machinery:

- `UnifeiICTReport.sty:282` — `\captionsetup{font=small,labelfont={bf,sf},textfont={sf}}`. No `labelsep`, hence the package default colon.
- `UnifeiICTReport.sty:911–928` — `\listoffigures`/`\listoftables` are already redefined for the heading style, but `\l@figure`/`\l@table` are not, so list entries use `book`'s `\@dottedtocline{1}{1.5em}{2.3em}`.
- `UnifeiICTReport.sty:955–995` — `\l@chapter`, `\l@section`, `\l@subsection`, `\l@subsubsection` are already redefined with custom `\@dottedtocline` parameters. Precedent and natural home for `\l@figure`/`\l@table`.
- `figuraabnt`/`tabelaabnt` (added by `enforce-abnt-caption-position`) already emit `\caption` in their begin code, which is where a `\captionsetup{width=...}` would have to go.

## Goals / Non-Goals

**Goals:**

- Bring caption separator, caption extent and list-entry format into conformance with NBR 14724:2024.
- Keep every existing document compiling: no argument becomes mandatory, no environment is renamed.
- Define the separator once, so illustration types added later inherit it.

**Non-Goals:**

- Adding new illustration types (Quadro, Gráfico, …) — separate change.
- Changing caption *position* relative to content — already governed by `figure-caption-compliance`.
- Automatic width detection (see Decisions).
- Changing the `\refcomp` family's own hyphen (`Seção 1 - Introdução`). That is cross-reference text invented by this template, not a caption; the norm does not govern it. Worth revisiting for internal consistency, but out of scope here.

## Decisions

**Width is declared by the author, not measured automatically.**
The caption is emitted *before* the body — that is the whole point of `figuraabnt` — so at caption time the content width does not yet exist. Three ways out were considered:

| Approach | Cost |
|---|---|
| Author declares width (chosen) | One optional argument; author repeats the number already passed to `\includegraphics` |
| Capture body into a box first, measure, then emit caption | Freezes catcodes: `verbatim`/`\verb` inside a float stops working |
| Round-trip the measured width through the `.aux` file | Extra compile pass, "rerun to get widths right" warnings, wrong on the first build of a new figure |

Chosen: explicit declaration. It is the only one that is correct on the first pass, survives arbitrary body content (tikz, subfigures, longtable), and gives the author control when the content's natural width is not knowable (a `tikzpicture`, a table sized by its own contents). Verified by compiling: with `\captionsetup{width=\GW}` inside the float plus `\includegraphics[width=\GW]` and `\fonte{}` boxed to `\GW`, caption, image and source note share both edges exactly.

Note that the box-capture objection is weaker than it looks — this template already captures `tabular` bodies with an `xparse` `b` argument (`UnifeiICTReport.sty:186`), so `\verb` inside a `tabular` is already broken here. It was still rejected: it would spread an existing wart rather than contain it, and it would not solve the `tikzpicture` case.

**Width omitted keeps today's behavior rather than defaulting to `\linewidth` for `\fonte{}` too.**
Making the width mandatory, or silently defaulting both caption and `\fonte{}` to `\linewidth`, would change the appearance of every existing figure whose graphic is narrower than the text block — including all three examples in the model. Keeping the unset case exactly as-is means this change is provably safe for existing documents, and the norm-conformant path is opt-in and documented. The cost is that full conformance requires the author to do something; the alternative cost was a silent layout change for everyone.

**Separator is `endash` (` – `), set once via `\captionsetup`.**
The sources disagree on the exact dash: NBR 14724:2024's own examples show an em dash (`Quadro 1 — Análise…`), the UFV guide shows a hyphen (`Figura 1 - Pirâmide alimentar`). Both are read as "travessão" in Brazilian typographic practice. `labelsep=endash` produces ` – `, which is what the great majority of Brazilian ABNT templates use and what reads correctly at 12pt. Setting it in the document-wide `\captionsetup` rather than per-type means later illustration types inherit it for free. If an institution demands the em dash, it is a one-key change, and the `.sty` comment should say so.

**List entries use `\DeclareCaptionListFormat` plus widened `\l@figure`/`\l@table`.**
Verified by compiling: `\DeclareCaptionListFormat{abntfig}{#1\figurename~#2 --~}` with `\captionsetup[figure]{listformat=abntfig}` does inject the word and the travessão, but on its own the result overprints — `Figura 1 –` overflows `book`'s 1.5em `\numberline` box and collides with the title. Both halves are required: the list format *and* a redefined `\l@figure`/`\l@table` with a number box wide enough for word, number and travessão. The existing `\l@chapter`/`\l@section` redefinitions at lines 955–995 are the model to follow, including the multi-line title alignment they already handle.

## Risks / Trade-offs

- **Every caption and both lists change appearance.** → Mitigation: that is the point; the change is a conformance fix. Verification compares the rendered PDF against the norm's own examples, and page count is expected to move.
- **Number box width is a magic constant that can be outgrown.** → A document reaching `Figura 100 –` would need a wider box than one stopping at `Figura 9 –`. Mitigation: size the box for a three-digit number from the start and comment the reasoning; over-wide costs a little indentation, under-wide costs a collision.
- **Authors will forget the width argument.** → Accepted. The unset case is the current, tolerable behavior rather than a broken one, and the example chapter plus README teach the argument. An alternative — warn at compile time when the width is unset — was rejected as noise: the model itself has legitimate full-width floats.
- **`labelsep` interacts with `\caption*`.** → The secondary description captions used in the example chapter (`\caption*{...}`) carry no label, so the separator does not apply to them. Confirm during verification that they are untouched.

## Open Questions

- Does the ICT have a house preference between ` – ` and ` — `? Defaulting to the en dash; a one-line change if the answer differs.
