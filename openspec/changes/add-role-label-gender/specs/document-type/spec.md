## MODIFIED Requirements

### Requirement: O rótulo do papel do professor deriva do tipo
O rótulo que acompanha o professor na capa e na folha de rosto SHALL corresponder ao papel que ele
exerce naquele tipo de documento, em vez de ser fixo.

O rótulo SHALL flexionar em gênero conforme o que o documento declarar para aquela pessoa, e o
modelo SHALL NOT inferir o gênero a partir do nome.

#### Scenario: Relatório genérico

- **WHEN** o tipo é relatório genérico
- **THEN** o rótulo identifica o professor responsável pela disciplina, e não um orientador — no relatório de disciplina não há orientação, há responsabilidade docente

#### Scenario: Demais tipos

- **WHEN** o tipo é relatório de estágio, TCC1, TCC2, dissertação ou tese
- **THEN** o rótulo identifica o orientador, acrescido do coorientador quando declarado

#### Scenario: Mais de um professor

- **WHEN** o documento declara mais de um professor, no formato que a capa já usa para vários autores
- **THEN** todos aparecem e o rótulo vai para o plural, do mesmo modo que "Autor" vira "Autores"

#### Scenario: Um professor só

- **WHEN** o documento declara um único professor
- **THEN** a capa é idêntica à que o modelo produzia antes desta capability existir — o suporte a vários não altera o caso comum

#### Scenario: Papel exercido por mulher

- **WHEN** o documento declara que a pessoa no papel é mulher
- **THEN** o rótulo sai no feminino em todos os pontos em que aparece — capa, folha de rosto e folha de aprovação —, sem que o autor precise declarar o gênero uma vez por página

#### Scenario: Gênero não declarado

- **WHEN** o documento não declara o gênero de quem exerce o papel
- **THEN** o modelo resolve o rótulo por regra registrada e verificável, e nunca por inspeção do nome da pessoa
