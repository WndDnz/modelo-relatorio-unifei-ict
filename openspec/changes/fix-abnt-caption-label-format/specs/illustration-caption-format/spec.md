## Purpose

Governs the typographic presentation of figure and table captions: the separator between label and title, the horizontal extent of the caption relative to the illustration it describes, and the format of the matching entries in the lists of illustrations and tables — per ABNT NBR 14724:2024 §5.8, §4.2.1.9 and §4.2.1.10.

This capability covers caption *format*. Caption *position* relative to the float content is governed separately by `figure-caption-compliance`.

## ADDED Requirements

### Requirement: Caption label is separated from the title by a travessão
Figure and table captions SHALL present the designative word, the arabic order number, a travessão, and then the title — never a colon.

#### Scenario: Figure caption

- **WHEN** a figure carries the caption text "Figura de exemplo" and is the first figure in the document
- **THEN** the compiled PDF renders `Figura 1 – Figura de exemplo`

#### Scenario: Table caption

- **WHEN** a table carries the caption text "Tabela de exemplo" and is the first table in the document
- **THEN** the compiled PDF renders `Tabela 1 – Tabela de exemplo`

#### Scenario: Separator is defined once, centrally

- **WHEN** a new float type is later added to the template
- **THEN** it inherits the travessão separator from the document-wide caption configuration without restating it

### Requirement: Caption, content and source share the illustration's margins
When the author declares the illustration's width, the caption text, the illustration itself and the `\fonte{}` note SHALL occupy exactly that width and share the same left and right edges, per §5.8 ("Tipo, número de ordem, título, fonte, legenda e notas devem acompanhar as margens da ilustração").

#### Scenario: Narrow illustration with declared width

- **WHEN** an author opens `figuraabnt` declaring a width of `0.5\textwidth` and places a graphic of that width in the body, followed by `\fonte{...}`
- **THEN** the caption wraps within `0.5\textwidth`, and the caption's left edge, the graphic's left edge and the source note's left edge all coincide

#### Scenario: Width not declared

- **WHEN** an author opens `figuraabnt` or `tabelaabnt` without declaring a width
- **THEN** the caption is set across the text block and `\fonte{}` aligns to the last measured content width, exactly as before this change — no existing document changes layout for this reason alone

#### Scenario: Content wider than the declared width

- **WHEN** the declared width is narrower than the content actually placed in the body
- **THEN** the document still compiles and the caption honours the declared width; the mismatch is the author's to resolve, and the template makes no attempt to detect or correct it

### Requirement: List entries name the illustration type and use a travessão
Entries in the list of illustrations and the list of tables SHALL be composed of the designative word, the order number, a travessão, the title, and the page number, per §4.2.1.9 and §4.2.1.10.

#### Scenario: List of figures entry

- **WHEN** the document contains one figure captioned "Figura de exemplo" on page 20 and prints the list of figures
- **THEN** the entry reads `Figura 1 – Figura de exemplo` followed by the leader dots and `20`

#### Scenario: List of tables entry

- **WHEN** the document contains one table captioned "Tabela de exemplo" on page 20 and prints the list of tables
- **THEN** the entry reads `Tabela 1 – Tabela de exemplo` followed by the leader dots and `20`

#### Scenario: Long label does not collide with the title

- **WHEN** a list entry's label is long enough that the default `\numberline` box would overflow — for example `Figura 10 –`
- **THEN** the title still starts after the label with normal spacing, with no overprinting, because the entry's number box is wide enough to hold word, number and travessão

#### Scenario: Multi-line titles stay aligned

- **WHEN** a list entry's title is long enough to wrap
- **THEN** the second and subsequent lines align under the first letter of the title, not under the designative word
