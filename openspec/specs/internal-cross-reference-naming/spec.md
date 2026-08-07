# internal-cross-reference-naming Specification

## Purpose
Guarantees that a cross-reference to a standard document division (primary section built from `\chapter`, section, subsection, subsubsection, figure, table, equation) always prints the correct division name, without depending on the author typing that name correctly at the call site.
## Requirements
### Requirement: Unstarred cross-reference auto-resolves the division name
The unstarred `\refcomp{<ignored type>}{<label>}` call SHALL determine and print the division type name automatically from the referenced label's own counter, rather than from its first argument, for any label inside the standard sectioning/float hierarchy (chapter-level primary division, section, subsection, subsubsection, figure, table, equation).

#### Scenario: Reference to a chapter-level primary division
- **WHEN** an author calls `\refcomp{<anything>}{<label>}` where `<label>` was set inside a `\chapter`
- **THEN** the compiled PDF shows "Seção N - <título>", never "Capítulo N - <título>", regardless of what string was passed as the first argument

#### Scenario: Reference to a section
- **WHEN** an author calls `\refcomp{<anything>}{<label>}` where `<label>` was set inside a `\section`
- **THEN** the compiled PDF shows "Subseção N.N - <título>", distinct from the chapter-level name

#### Scenario: Reference to a subsection
- **WHEN** an author calls `\refcomp{<anything>}{<label>}` where `<label>` was set inside a `\subsection`
- **THEN** the compiled PDF shows "Subsubseção N.N.N - <título>", distinct from the section-level name

#### Scenario: Reference to a subsubsection
- **WHEN** an author calls `\refcomp{<anything>}{<label>}` where `<label>` was set inside a `\subsubsection`
- **THEN** the compiled PDF shows "Parágrafo N.N.N.N - <título>", distinct from the subsection-level name — this is the lowest numbered level in this template (`secnumdepth=3`)

#### Scenario: Reference to a figure, table, or equation
- **WHEN** an author calls `\refcomp{<anything>}{<label>}` where `<label>` was set via a figure, table, or equation label
- **THEN** the compiled PDF shows the correct localized name ("Figura", "Tabela", "Equação") matching what `\reffig`/`\reftable`/`\refeqcomp` already produce today

### Requirement: Starred cross-reference falls back to an explicit literal name
The starred `\refcomp*{<type>}{<label>}` call SHALL print its first argument literally as the division-type name, for labels outside the standard sectioning/float hierarchy where automatic resolution is unavailable or unreliable.

#### Scenario: Reference to a label on a custom, non-hierarchy counter
- **WHEN** an author calls `\refcomp*{<type>}{<label>}` where `<label>` was set via a custom counter without a matching autoref name
- **THEN** the compiled PDF shows `<type>` exactly as written, followed by the reference number and name — matching today's `\refcomp` behavior

### Requirement: Existing figure/table/equation reference wrappers remain unaffected
`\reffigcomp`, `\reftablecomp`, and `\refeqcomp` SHALL continue to produce the same output as before this change, since they call the unstarred `\refcomp` internally and their labels already fall inside the auto-resolvable hierarchy.

#### Scenario: No regression in wrapper output
- **WHEN** an author calls `\reffigcomp{<label>}`, `\reftablecomp{<label>}`, or `\refeqcomp{<label>}` exactly as before this change
- **THEN** the compiled PDF output is unchanged from before this change

