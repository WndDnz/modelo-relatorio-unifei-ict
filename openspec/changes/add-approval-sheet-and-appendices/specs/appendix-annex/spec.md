## Purpose

Provides post-textual appendices and annexes per ABNT NBR 14724:2024 §4.2.3.3 and §4.2.3.4 — identified by consecutive capital letters, centered, typographically matched to the primary section, paginated continuously with the main text, and cross-referenceable by their own names.

The norm distinguishes the two by authorship: an apêndice is written by the author to complement their argument (§3.4); an anexo is a document not written by the author, serving as grounding, proof or illustration (§3.3).

## ADDED Requirements

### Requirement: Appendices and annexes are identified by consecutive capital letters
Each appendix SHALL be headed by the word APÊNDICE followed by a capital letter, a travessão and its title; each annex likewise with the word ANEXO. Letters SHALL advance consecutively within each group, and SHALL double once the alphabet is exhausted.

#### Scenario: First appendix

- **WHEN** the author opens the first appendix with the title "Questionário aplicado"
- **THEN** the heading reads `APÊNDICE A — Questionário aplicado`

#### Scenario: Independent sequences

- **WHEN** a document contains two appendices and two annexes
- **THEN** the appendices are lettered A and B, and the annexes are also lettered A and B — the two groups do not share a sequence

#### Scenario: Alphabet exhausted

- **WHEN** a group contains more than twenty-six entries
- **THEN** the twenty-seventh is identified `AA`, per §4.2.3.3

#### Scenario: No numeric indicative

- **WHEN** any appendix or annex heading is rendered
- **THEN** it carries no section number, and the letter is part of the heading text rather than a section indicative — per §5.2.3, which lists both among the titles without numeric indicative

### Requirement: Headings are centered and typographically match the primary section
Appendix and annex headings SHALL use the same typographic emphasis as the document's primary section, per §4.2.3.3, while being centered per §5.2.3 — differing from the primary section's own alignment, which is governed by the numbering rules of §5.2.2.

#### Scenario: Emphasis matches

- **WHEN** an appendix heading is rendered in a document whose primary sections are set in the institutional font, in the institutional blue, bold, uppercase
- **THEN** the appendix heading carries that same treatment

#### Scenario: Alignment differs

- **WHEN** an appendix heading and a primary-section heading appear in the same document
- **THEN** the primary section is aligned left following its numeric indicative, and the appendix heading is centered

### Requirement: Pagination continues the main text
Appendix and annex pages SHALL continue the page numbering of the main text without restarting or switching numbering style, per §5.3.

#### Scenario: Page numbers continue

- **WHEN** the main text ends on page 30 and an appendix follows
- **THEN** the appendix's first page is numbered 31, in the same arabic numbering and the same position on the page

### Requirement: Appendices and annexes appear in the sumário
The groups SHALL be listed in the sumário so a reader can find them, without acquiring a section number in the process.

#### Scenario: Sumário entries

- **WHEN** a document contains appendices and annexes and prints its sumário
- **THEN** the sumário lists them after the references, with no section number

### Requirement: Cross-references name the element correctly
A cross-reference to a label inside an appendix or annex SHALL resolve to "Apêndice" or "Anexo" respectively, not to the name used for primary sections in the main body.

#### Scenario: Reference to an appendix

- **WHEN** the author labels an appendix and cross-references it with the template's automatic cross-reference command
- **THEN** the reference reads `Apêndice A` and not `Seção A`

#### Scenario: Main-body references unaffected

- **WHEN** the same document cross-references a primary section of the main body
- **THEN** that reference still reads "Seção", with the appendix naming applying only from the point the appendices begin

#### Scenario: Floats inside appendices

- **WHEN** a figure or table appears inside an appendix
- **THEN** it continues the document's figure or table sequence and remains cross-referenceable and listable exactly as one in the main body
