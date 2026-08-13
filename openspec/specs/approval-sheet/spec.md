# approval-sheet Specification

## Purpose

Provides the folha de aprovação required by ABNT NBR 14724:2024 §4.2.1.3 — a single command whose form derives from the document type declared when the package is loaded, covering the documents this template serves: course reports, internship reports, TCC1 research projects, TCC2 monographs, master's dissertations and doctoral theses. The sheet records who approves the work and when; signatures live in the Ata de Defesa, not on the sheet.

## Requirements

### Requirement: A folha de aprovação é emitida conforme o tipo do documento
A folha de aprovação SHALL derivar sua forma do tipo declarado no carregamento do pacote, sem receber o tipo como parâmetro próprio, e SHALL não ser emitida quando o tipo do documento admite ausência de banca e nenhuma foi declarada.

#### Scenario: Forma derivada do tipo

- **WHEN** o autor invoca a folha de aprovação num documento cujo tipo já foi declarado
- **THEN** a folha correspondente àquele tipo é emitida, sem que o autor repita a informação

#### Scenario: TCC1 sem banca

- **WHEN** o tipo é TCC1 e nenhuma banca foi declarada
- **THEN** nenhuma folha de aprovação é emitida e nenhuma página em branco fica em seu lugar — no TCC1 a defesa é facultativa, e sem ela o texto é avaliado individualmente, com a nota informada diretamente ao orientador

#### Scenario: TCC1 com banca

- **WHEN** o tipo é TCC1 e uma banca foi declarada
- **THEN** a folha é emitida, ainda que a NBR 15287 não preveja o elemento — trata-se da adaptação institucional registrada como D3 em design.md

#### Scenario: Demais tipos

- **WHEN** o tipo é relatório genérico, relatório de estágio, TCC2, dissertação ou tese
- **THEN** a folha é sempre emitida; nesses tipos a banca ou os signatários não são facultativos

#### Scenario: Tipo desconhecido

- **WHEN** o documento declara um tipo que o modelo não admite
- **THEN** a falha ocorre no carregamento do pacote, nomeando os tipos aceitos, e não no ponto em que a folha seria emitida

### Requirement: A folha registra a aprovação, sem espaço para assinatura
A folha SHALL apresentar o nome do autor, o título e o subtítulo quando houver, a natureza, a data de aprovação e, para cada componente, seu nome, titulação e instituição. Ela SHALL NOT apresentar linhas de assinatura.

A NBR 14724 §4.2.1.3 determina que as assinaturas dos componentes da banca sejam colocadas na folha após a aprovação. Este modelo se afasta disso deliberadamente: a assinatura passou a ser registrada apenas na Ata de Defesa, prática consolidada nas universidades desde que as defesas passaram a ser inteiramente digitais, e verificada contra as teses recentes publicadas no repositório institucional da Unifei, nenhuma das quais traz assinaturas na folha. Ver D1 em design.md.

#### Scenario: Composição sem linha de assinatura

- **WHEN** a folha é renderizada com componentes declarados
- **THEN** cada componente aparece com nome, titulação e instituição, e nenhuma linha, traço ou espaço reservado para assinatura é desenhado

#### Scenario: Data de aprovação

- **WHEN** a data de aprovação foi declarada
- **THEN** ela aparece na folha; sem declaração, a linha não aparece, em vez de deixar um campo vazio

#### Scenario: Conteúdo herdado da capa

- **WHEN** o documento já declarou título, subtítulo, autor e orientador para a capa e a folha de rosto
- **THEN** a folha de aprovação reaproveita essas declarações, sem exigir que sejam repetidas

#### Scenario: Mais de um autor

- **WHEN** o documento declara mais de um autor
- **THEN** todos aparecem na folha de aprovação, do mesmo modo que a capa e a folha de rosto já os apresentam

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

### Requirement: A composição da folha corresponde ao tipo do documento
Cada tipo SHALL determinar quem consta da folha, de modo que o tipo seja uma seleção com consequência e não um rótulo.

#### Scenario: Relatório genérico

- **WHEN** o tipo é relatório genérico
- **THEN** constam o professor ou os professores responsáveis pela disciplina — o modelo aceita mais de um, para as disciplinas compartilhadas — e a natureza declara a aprovação na disciplina como objetivo, caso que o §4.2.1.1.1(e) contempla

#### Scenario: Relatório de estágio

- **WHEN** o tipo é relatório de estágio
- **THEN** constam três partes: o aluno estagiário, o professor orientador e o supervisor de campo

#### Scenario: Monografia e projeto com banca

- **WHEN** o tipo é TCC1 com banca, TCC2, dissertação ou tese
- **THEN** consta a banca examinadora, composta pelo orientador e pelos membros externos declarados

#### Scenario: O orientador não é redeclarado

- **WHEN** o documento declara o orientador para a capa e declara os membros externos da banca
- **THEN** o orientador aparece na composição da banca a partir daquela declaração, sem que o autor precise declará-lo uma segunda vez como membro

#### Scenario: Banca de tamanho variável

- **WHEN** o autor declara três, cinco ou sete membros
- **THEN** todos aparecem, na ordem declarada — a banca do ICT é orientador mais no mínimo dois membros externos, sem número fixo, e o mesmo vale na pós-graduação

#### Scenario: Componentes ainda não conhecidos

- **WHEN** o autor ainda não conhece os nomes e declara componentes em branco
- **THEN** a folha é emitida com os blocos correspondentes vazios, sem erro nem aviso, já que a folha é preparada antes da defesa

#### Scenario: Arranjo dos membros não é fixado pela norma

- **WHEN** um layout dispõe os membros na página
- **THEN** tanto o empilhamento quanto a disposição lado a lado satisfazem esta capability, já que a norma prescreve a informação e não a sua disposição
