# illustration-types Specification

## Purpose

Makes the designative word a property of each illustration rather than a hardcoded "Figura", per ABNT NBR 14724:2024 §5.8, with an independent numbering sequence and an optional dedicated list per type (§4.2.1.9) — and holds the boundary between illustration (§5.8) and table (§5.9).

## Requirements

### Requirement: Each illustration carries its own designative word
An illustration SHALL be captioned with the designative word for its type, followed by its order number, a travessão and its title — never with a generic word standing in for a specific one.

#### Scenario: Quadro

- **WHEN** an author creates an illustration of type Quadro with the title "Estrutura de trabalhos acadêmicos"
- **THEN** the caption reads `Quadro 1 – Estrutura de trabalhos acadêmicos`

#### Scenario: Gráfico

- **WHEN** an author creates an illustration of type Gráfico with the title "Quantidade de alunos por curso"
- **THEN** the caption reads `Gráfico 1 – Quantidade de alunos por curso`

#### Scenario: Figura remains available and unchanged

- **WHEN** an author uses the existing figure environment as written before this change
- **THEN** it behaves exactly as it did, captioned "Figura", with no source edit required

#### Scenario: Type not shipped with the template

- **WHEN** a document needs a designative word the template does not ship — Fluxograma, Organograma, Mapa, among the others §5.8 names
- **THEN** the author can declare that type in their own document preamble and use it like the built-in ones, without modifying the package

#### Scenario: The declaration command is callable by an author

- **WHEN** the author writes the type declaration in a plain document preamble, as the template's own documentation instructs
- **THEN** it compiles without the author wrapping it in `\makeatletter`/`\makeatother` — the command's name carries no `@`, since a document preamble does not treat `@` as a letter and the declaration would otherwise fail with "Undefined control sequence"

### Requirement: Each type numbers independently
Every illustration type SHALL maintain its own arabic order sequence, counted by order of occurrence in the text.

#### Scenario: Independent sequences

- **WHEN** a document contains, in order, a Figura, a Quadro, a Figura and a Gráfico
- **THEN** they are numbered Figura 1, Quadro 1, Figura 2, Gráfico 1

#### Scenario: Numbering does not restart per section

- **WHEN** illustrations of any type appear across several primary sections
- **THEN** each type's sequence continues across the whole document, consistent with the template's existing continuous numbering for figures, tables and equations

### Requirement: Each type can have its own list
The template SHALL allow a dedicated list per illustration type, per §4.2.1.9's recommendation of "lista própria para cada tipo de ilustração", with entries formatted like the existing lists.

#### Scenario: Dedicated list

- **WHEN** a document contains quadros and prints the list of quadros
- **THEN** the list is headed LISTA DE QUADROS and its entries read `Quadro 1 – Título …… 20`, styled like the existing lists of figures and tables

#### Scenario: Lists are optional

- **WHEN** a document contains illustrations of a type but does not print that type's list
- **THEN** it compiles cleanly with no warning, consistent with how the existing optional lists behave

#### Scenario: Type present with no list printed

- **WHEN** a document uses a type for which no list is printed anywhere
- **THEN** no empty list page is produced

### Requirement: Tables are not illustrations
The table environment SHALL remain a separate category from the illustration mechanism, governed by §5.9 and the IBGE tabular rules, listed in its own list per §4.2.1.10.

#### Scenario: Table stays separate

- **WHEN** an author creates a table
- **THEN** it is captioned "Tabela", numbered in the table sequence, and listed in the list of tables — never in a list of illustrations

#### Scenario: Structured textual content is a quadro

- **WHEN** content is structured in rows and columns but its central information is textual rather than numeric
- **THEN** the template's documentation directs the author to the Quadro type, since a quadro is an illustration under §5.8 while a tabela under §5.9 is the non-discursive presentation of information whose numeric datum is the central information

### Requirement: Cross-references name the type
A cross-reference to an illustration SHALL resolve to that illustration's designative word.

#### Scenario: Reference to a quadro

- **WHEN** the author cross-references a labelled Quadro
- **THEN** the reference reads `Quadro 1`, not `Figura 1`

#### Scenario: Existing reference commands keep working

- **WHEN** a document uses the template's existing figure and table cross-reference commands
- **THEN** they resolve exactly as before this change
