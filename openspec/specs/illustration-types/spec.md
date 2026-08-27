# illustration-types Specification

## Purpose

Faz da palavra designativa uma propriedade de cada ilustração, em vez do "Figura" fixo, conforme a ABNT NBR 14724:2024 §5.8, com sequência de numeração independente e lista própria por tipo (§4.2.1.9) — e guarda a fronteira entre ilustração (§5.8) e tabela (§5.9).

Governa também a **emissão** da lista de tabelas (§4.2.1.10): a lista de tabelas é o mesmo mecanismo das listas de ilustração, atendida pela mesma delegação do `newfloat` e pela mesma guarda de lista vazia, e separá-la numa capability própria dividiria em duas o que o código e a norma tratam junto. O formato da legenda de tabela não é daqui — é de `illustration-caption-format`.

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

### Requirement: Lista opcional sem itens não é emitida

Lista de elementos que a NBR 14724:2024 trata como elemento opcional — lista de ilustrações (§4.2.1.9), lista de tabelas (§4.2.1.10) e as listas por tipo de ilustração (§5.8) — SHALL deixar de ser emitida quando não houver item algum a listar. Não emitir significa não imprimir título, não consumir página e não gerar entrada no sumário.

A ausência de itens SHALL ser detectada pelo próprio pacote, e não delegada ao autor sob a forma de uma chamada que ele precise lembrar de comentar.

#### Scenario: Documento sem nenhuma ilustração do tipo

- **WHEN** o documento chama a lista de um tipo de ilustração e nenhum elemento daquele tipo existe no texto
- **THEN** nenhuma página é emitida para aquela lista, e o sumário não a menciona

#### Scenario: Ilustrações retiradas na revisão

- **WHEN** um documento que tinha ilustrações passa a não ter nenhuma, sem que a chamada da lista seja removida
- **THEN** a lista deixa de ser emitida na compilação seguinte, sem exigir edição do arquivo do autor

#### Scenario: Lista com pelo menos um item

- **WHEN** existe ao menos um elemento a listar
- **THEN** a lista é emitida como hoje, sem alteração de estilo, de cabeçalho ou de posição
