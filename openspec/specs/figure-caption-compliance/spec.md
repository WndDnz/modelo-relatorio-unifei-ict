# figure-caption-compliance Specification

## Purpose
Guarantees every figure and table caption renders above its illustration or table and the source note below it, per NBR 14724:2024 §5.8/5.9, by construction — not by relying on authors writing `\caption` before the float content.
## Requirements
### Requirement: Caption position is guaranteed by the environment, not by authoring convention
The document class SHALL provide `figuraabnt` and `tabelaabnt` environments that accept the label and caption text as mandatory environment arguments and typeset that caption above the environment's body content, regardless of what the author writes inside the body or in what order.

#### Scenario: Author writes body content in any order
- **WHEN** an author opens a `figuraabnt` or `tabelaabnt` environment with a caption argument and then writes `\includegraphics`, `tabular`, or `subfigure` content inside the body, in any order
- **THEN** the compiled PDF shows the caption text above all of that body content

#### Scenario: Plain `figure`/`table` environments remain available but uncontracted
- **WHEN** an author uses the raw LaTeX `figure` or `table` environment directly instead of `figuraabnt`/`tabelaabnt`
- **THEN** the document class makes no positioning guarantee for that block — caption order depends entirely on source order, as in standard LaTeX

### Requirement: Source note remains below the float content
The `\fonte{}` macro SHALL continue to render its source-attribution text below the float content and left-aligned to the last measured graphic/table width, called by the author as the last element inside the environment body, exactly as before this change.

#### Scenario: Single figure with source note
- **WHEN** a `figuraabnt` environment contains `\includegraphics` in its body, followed by a `\fonte{...}` call as the last element of that body
- **THEN** the compiled PDF shows, top to bottom: caption, image, source note

#### Scenario: Compound figure with subfigures and a shared source note
- **WHEN** a `figuraabnt` environment's body contains multiple `subfigure` blocks, followed by a single `\fonte{...}` call as the last element of that body
- **THEN** the compiled PDF shows the top-level caption above all subfigures and the source note below all of them, matching the existing multi-subfigure example's visual result

### Requirement: Float placement behavior is preserved
`figuraabnt` and `tabelaabnt` SHALL preserve standard LaTeX float placement (`[!htbp]`-style specifiers, page-floating behavior) by opening a real `figure`/`table` float internally, rather than reimplementing float placement logic.

#### Scenario: Placement specifier still works
- **WHEN** an author writes `\begin{figuraabnt}[!htbp]{...}{...}`
- **THEN** the float placement behaves exactly as `\begin{figure}[!htbp]` would today

