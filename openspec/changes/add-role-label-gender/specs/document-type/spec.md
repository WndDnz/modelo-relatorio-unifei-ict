## ADDED Requirements

### Requirement: Rótulo de pessoa gerado pelo modelo flexiona em gênero

Todo rótulo que o modelo gera para identificar uma pessoa — orientador, coorientador, professor responsável, orientador acadêmico, supervisor de campo, aluno estagiário e autor — SHALL flexionar em gênero conforme o documento declarar para aquela pessoa.

O modelo SHALL NOT inferir o gênero a partir do nome, do título acadêmico ou de qualquer outro texto livre declarado pelo autor.

A declaração de gênero SHALL ser opcional, e a sua ausência SHALL produzir a saída que o modelo produzia antes desta capacidade existir.

Quando um mesmo metadado trouxer mais de uma pessoa, o gênero SHALL ser declarável por pessoa, e o rótulo individual de cada uma SHALL corresponder ao que foi declarado para ela.

#### Scenario: Papel exercido por mulher

- **WHEN** o documento declara que a pessoa em um papel é mulher
- **THEN** o rótulo sai no feminino em todos os pontos em que aquele papel aparece — capa, folha de rosto e folha de aprovação —, sem que o autor precise declarar o gênero uma vez por página

#### Scenario: Gênero não declarado

- **WHEN** o documento não declara o gênero de quem exerce o papel
- **THEN** o rótulo sai no masculino, e o documento é idêntico ao que o modelo produzia antes de a flexão existir

#### Scenario: Duas pessoas de gêneros diferentes no mesmo metadado

- **WHEN** um metadado que admite vários nomes traz uma mulher e um homem
- **THEN** cada bloco individual recebe o rótulo no gênero declarado para aquela pessoa, e o rótulo coletivo, que é um só para o grupo, vai ao masculino plural

#### Scenario: Nome sem gênero correspondente declarado

- **WHEN** o documento declara mais nomes do que gêneros
- **THEN** os nomes excedentes recebem o rótulo masculino, sem erro nem aviso — declarar o gênero permanece opcional

#### Scenario: Titulação escrita pelo autor

- **WHEN** o autor escreve ele próprio a titulação de um membro de banca
- **THEN** o modelo a imprime como escrita, sem tentar flexioná-la, por não ser rótulo gerado
