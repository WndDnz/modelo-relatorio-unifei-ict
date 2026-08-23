## ADDED Requirements

### Requirement: Os elementos opcionais previstos pela norma têm comando próprio

Cada elemento opcional que a NBR 14724:2024 prevê e que o modelo declare oferecer SHALL ter comando próprio, com a formatação que a norma exige para ele e a posição correta na ordem dos elementos.

Elemento não declarado SHALL NOT produzir página, título ou entrada de sumário.

O manual SHALL documentar e exemplificar cada comando acrescentado, e SHALL declarar como ausente todo elemento da norma que continue sem implementação.

#### Scenario: Autor declara dedicatória, agradecimentos e epígrafe

- **WHEN** os três são declarados no preâmbulo
- **THEN** os três saem impressos, cada um na posição que a norma lhe dá, sem entrada numerada de sumário

#### Scenario: Autor não declara nenhum deles

- **WHEN** nenhum elemento opcional é declarado
- **THEN** o documento compila e nenhuma página em branco é emitida no lugar deles

#### Scenario: A lista de ausências do manual acompanha o que foi implementado

- **WHEN** um elemento passa a ser oferecido
- **THEN** ele sai da seção "O que este modelo não oferece" e entra documentado, com exemplo
