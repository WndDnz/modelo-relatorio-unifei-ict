## Purpose

Provides the folha de aprovação required by ABNT NBR 14724:2024 §4.2.1.3 — a single command whose layout is selected by work type, covering the range of documents this template serves: course reports, internship reports, undergraduate final projects and master's dissertations.

## ADDED Requirements

### Requirement: A single command renders the approval sheet, selected by work type
The template SHALL provide one command that emits the folha de aprovação, taking the work type as a parameter and defaulting to the course-report type when none is given.

#### Scenario: Default type

- **WHEN** an author invokes the approval-sheet command with no type argument
- **THEN** the course-report layout is rendered, since that is the most common use of this template

#### Scenario: Explicit type

- **WHEN** an author invokes the command naming one of the supported types — course report, internship report, undergraduate final project, master's dissertation
- **THEN** the layout for that type is rendered, with the fields and signature blocks that type requires

#### Scenario: Unknown type

- **WHEN** an author names a type the template does not support
- **THEN** the build fails with a message naming the command and listing the supported types, rather than silently rendering the default

#### Scenario: Command not invoked

- **WHEN** a document does not invoke the command at all
- **THEN** no approval sheet is emitted and the document compiles exactly as before this capability existed

### Requirement: The sheet carries the content the norm requires
The rendered sheet SHALL present the author's name, the work's title and its subtitle when one exists, the natureza, the approval date, and for each approving party their name, titulação, institution and a signature rule — per §4.2.1.3.

#### Scenario: Content drawn from existing metadata

- **WHEN** the document has already declared title, subtitle, author and supervisor for the cover and title page
- **THEN** the approval sheet reuses those declarations rather than requiring them to be restated

#### Scenario: Multiple authors

- **WHEN** the document declares more than one author
- **THEN** all authors appear on the approval sheet, consistent with how the cover and title page already present them

#### Scenario: Examining board

- **WHEN** the work type is one that is defended before a board and the author has declared its members
- **THEN** each member appears with a signature rule, their name, their titulação and their institution

#### Scenario: Board members not yet known

- **WHEN** the author has not declared board members for a type that expects them
- **THEN** the sheet still renders with the correct number of blank signature blocks, since §4.2.1.3 requires the date and signatures to be filled in after approval — a sheet printed for signing is the normal case, not an error

### Requirement: A subtitle is subordinated to the title by a colon
When the work has a subtitle, the sheet SHALL present it preceded by a colon, marking its subordination to the title, per §4.1.1 alínea d) — "subtítulo: se houver, deve ser precedido de dois-pontos, evidenciando a sua subordinação ao título". The colon SHALL be supplied by the template, not typed by the author.

The norm states this rule explicitly for the capa; §4.2.1.1.1(c) and §4.2.1.3 list only "subtítulo, se houver", without restating the punctuation. The template applies it wherever title and subtitle appear together, since the colon is the mark of the subordination itself rather than an ornament of the cover — consistent with the published UFV models and with NBR 6023, which separates title from subtitle by a colon in references.

#### Scenario: Work with a subtitle

- **WHEN** the document declares both a title and a subtitle
- **THEN** the sheet presents them joined by a colon, and the author does not type that colon into either declaration

#### Scenario: Work without a subtitle

- **WHEN** the document declares no subtitle
- **THEN** the title appears alone, with no trailing colon

#### Scenario: Title and subtitle form one continuous block

- **WHEN** title and subtitle are rendered together
- **THEN** they flow as a single continuous block with no paragraph break and no change of type size between them, distinguished by weight alone — the title in bold, the subtitle not

#### Scenario: Letter case is the cover's, not the whole document's

- **WHEN** the sheet renders the title block
- **THEN** it uses normal case, while the capa and folha de rosto render the same composition in upper case

### Requirement: Typography follows the norm's rules for this element
The sheet SHALL be rendered without a title and without a numeric indicative per §5.2.4, with the natureza set in single spacing and aligned from the middle of the text block to the right margin per §5.2.

#### Scenario: Natureza block

- **WHEN** the sheet is rendered
- **THEN** the natureza occupies the right half of the text block, set in single spacing, while the rest of the page follows the document's normal spacing

#### Scenario: No heading

- **WHEN** the sheet is rendered
- **THEN** no heading, section number or table-of-contents entry is produced for it

#### Scenario: Placement

- **WHEN** the sheet is rendered in a document that also has a title page
- **THEN** it appears immediately after the title page and before any dedication, acknowledgements or abstract, per §4.2.1.3 and the pre-textual order of §4.2.1

### Requirement: Layout varies by work type
Each supported work type SHALL determine which fields appear and who signs, so that a type is a meaningful selection rather than a cosmetic label.

#### Scenario: Course report

- **WHEN** the course-report type is selected
- **THEN** the sheet presents the discipline, the responsible professor and a signature rule, and the natureza names approval in the discipline as its objetivo — the case §4.2.1.1.1(e) contemplates

#### Scenario: Internship report

- **WHEN** the internship-report type is selected
- **THEN** the sheet additionally accommodates the company supervisor alongside the academic supervisor

#### Scenario: Final project and dissertation

- **WHEN** the undergraduate-final-project or master's-dissertation type is selected
- **THEN** the sheet presents an examining board with one signature block per member, each with name, titulação and institution

#### Scenario: Arrangement of board members is not fixed by the norm

- **WHEN** a layout arranges board members on the page
- **THEN** either a stacked or a side-by-side arrangement satisfies this capability, since the norm prescribes the information but not its disposition
