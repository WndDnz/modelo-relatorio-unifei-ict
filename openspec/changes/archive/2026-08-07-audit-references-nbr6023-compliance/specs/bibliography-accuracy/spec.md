## Purpose

Ensures the template's example `referencias.bib` renders correctly under NBR 6023:2018 — institutional authors as complete entity names, and ABNT self-references pointing at each norm's currently valid edition — since this file is copied as a working pattern by report authors.

## ADDED Requirements

### Requirement: Institutional author names render as a single unbroken entity
Any `.bib` entry whose `author` (or equivalent responsibility field) is an organization, government body, or other corporate entity SHALL have that name wrapped so biber's name-list parser treats it as one atomic unit, producing a compiled citation and bibliography entry that shows the complete entity name — never a fragment produced by splitting the name into given/family/prefix parts.

#### Scenario: Institutional author with an internal preposition
- **WHEN** an entry's author is an institution whose name contains an internal preposition (e.g., "Instituto de Pesquisa X", "Instituto Nacional de Estatística")
- **THEN** the compiled bibliography and any in-text citation of that entry show the complete institution name, not a fragment split at the preposition

#### Scenario: Multi-word institutional author without a preposition
- **WHEN** an entry's author is a multi-word institution name (e.g., "Governo do Brasil", "Equipe de Desenvolvimento do Sistema Y")
- **THEN** the compiled bibliography and any in-text citation show the complete name in original word order, not inverted as if it were a personal "Surname, Given" name

### Requirement: ABNT self-references cite the currently valid edition
Any `.bib` entry that represents an ABNT norm used elsewhere in this template's own documentation or citation examples SHALL cite that norm's currently valid edition year, and SHALL follow the same field pattern (`author = {{Associação Brasileira de Normas Técnicas}}`, not `institution`) as the other ABNT norm entries in the same file, so the pattern is consistent for anyone copying it.

#### Scenario: Superseded edition year
- **WHEN** the file contains an entry for a norm that has been revised since the entry was written
- **THEN** the entry's year and citation key reflect the current edition, not the superseded one

#### Scenario: Consistent field pattern across sibling ABNT entries
- **WHEN** the file contains more than one ABNT norm entry (e.g., NBR 6023, NBR 6028, NBR 14724)
- **THEN** all of them use the same field (`author`, double-braced) to express the ABNT institutional authorship, rather than mixing `author` and `institution` across entries
