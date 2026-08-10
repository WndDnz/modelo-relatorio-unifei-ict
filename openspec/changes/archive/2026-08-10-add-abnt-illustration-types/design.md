## Context

See proposal.md — Why. The normative basis is NBR 14724:2024 §5.8 (designative word), §4.2.1.9 (per-type lists), §5.9 and §4.2.1.10 (tables as a separate category bound to the IBGE tabular rules), read directly from the standard.

What exists to build on:

- `figuraabnt` and `tabelaabnt` (`UnifeiICTReport.sty`, added by `enforce-abnt-caption-position`) — thin `xparse` environments taking label and caption as arguments and opening a real `figure`/`table` float internally, so the caption is emitted before the body by construction.
- `\counterwithout{figure}{chapter}` and siblings (line ~275) — float numbering is already continuous across the document rather than per-chapter.
- `\listoffigures`/`\listoftables` redefined for heading style (lines ~911–928); a per-type list needs the same treatment applied to a new list file.
- `\reffig`/`\reftable`/`\reffigcomp`/`\reftablecomp` (lines ~588–592) — the cross-reference family, built on `\figurename`/`\tablename`.

## Goals / Non-Goals

**Goals:**

- Make the designative word a property of the illustration.
- Ship the types that actually occur in ICT reports, and leave the mechanism open for the rest of §5.8's list.
- Hold the illustration/table boundary, and teach it, since that is where authors err.
- Change nothing for documents already using `figuraabnt`/`tabelaabnt`.

**Non-Goals:**

- Reworking caption separator, caption margins or list-entry format — that is `fix-abnt-caption-label-format`, which must land first.
- Implementing the IBGE tabular rules for tables. Real, separate, and much larger: open sides, obligatory header, notes structure.
- Automatic type inference from content. There is no reliable signal, and guessing wrong produces a conformance error the author cannot see.

## Decisions

**Depends on `fix-abnt-caption-label-format`; do not apply first.**
That change fixes the separator, the caption/illustration margin alignment and the list-entry format. All three apply to every type introduced here. Applying this change first means implementing three known defects across three types and then fixing nine instances instead of three. The dependency is one-directional and the sequencing is not negotiable.

**A type is declared, not hardcoded, and `figuraabnt` becomes an instance of the mechanism.**
§5.8's list — desenho, esquema, fluxograma, fotografia, gráfico, mapa, organograma, planta, quadro, retrato, figura, imagem — is explicitly open ("entre outros"). Shipping a fixed set of environments would mean a package edit every time a report needs a type nobody anticipated. A declaration command that creates the environment, the counter, the cross-reference command and the list hook for a named type covers the shipped types and the unanticipated ones with the same code.

Ship Figura, Quadro and Gráfico. Not the whole §5.8 list: each type costs a counter and an auxiliary list file, and a template carrying nine unused ones is noise. Three covers the observed cases and proves the mechanism.

**`figuraabnt` keeps its name and its behavior.**
Renaming it to something type-generic would break every document written against the current interface, including the model's own examples, for no reader-visible gain. It becomes the type declared as "Figura" and keeps its spelling.

**Tables stay out of the mechanism.**
Tempting to unify — a table looks like an illustration with a different word. It is not: §5.9 governs it separately, §4.2.1.10 gives it its own list, and the norm binds it to a different standard entirely (IBGE, *Normas de apresentação tabular*, 1993, cited in §2). Folding tables into the illustration mechanism would make it structurally easy to produce the exact error this change exists to prevent. Keep the boundary in the code, not only in the documentation.

**The Quadro/Tabela distinction is taught by example, not only stated.**
This is the one authors get wrong, and a definitional sentence will not stop them. The example chapter should show the same content twice — once as a Quadro because its central information is textual, once as a Tabela because its central information is numeric — so the boundary is visible rather than asserted. The UFV guide's formulation is the one to paraphrase: a tabela is the non-discursive presentation of information whose numeric datum stands out as the central information.

**Per-type lists reuse the existing list styling rather than reimplementing it.**
`\listoffigures` and `\listoftables` are already redefined identically except for the heading name and the auxiliary file extension (lines ~911–928). A new list per type is the same body with two substitutions. Factor it when adding the third, not before — but do factor it, because a fourth type copying a fourth near-identical block is where these things rot.

## Risks / Trade-offs

- **Auxiliary file extensions must not collide.** → Each type's list needs its own extension via `\@starttoc`. LaTeX has a hard limit on open write streams (16), and `glossaries`, `biblatex`, `hyperref` and the existing `toc`/`lof`/`lot` already consume several. Three types is safe; a document declaring many custom types could exhaust it. Check the count during implementation and document the ceiling rather than letting an author discover it as an inscrutable error.
- **`\counterwithout` must be applied to each new counter.** → The template detaches figure, table and equation numbering from the chapter counter. A new type's counter created without the same treatment would silently number per chapter, inconsistent with everything else. Easy to forget, invisible until a document has two chapters with illustrations.
- **Cross-reference commands multiply.** → Three types times the plain and the composed reference forms is six commands, plus whatever a custom type generates. The declaration command should generate them rather than requiring hand-written pairs, or the interface grows faster than the value.
- **Interaction with `subcaption`.** → The subfigure width-accumulation hooks (`UnifeiICTReport.sty:216–265`) key on `\AtBeginEnvironment{figure}`. A new type opening a `figure` float internally inherits them; one opening something else would not. Verify with a compound Quadro before assuming.

## Open Questions

- Does the ICT expect a LISTA DE ILUSTRAÇÕES combining all types, as §4.2.1.9's first example shows, or one list per type, as its second shows? The norm permits both — "quando necessário, recomenda-se a elaboração de lista própria para cada tipo". The mechanism should support both; which one the model demonstrates by default is an institutional call.
