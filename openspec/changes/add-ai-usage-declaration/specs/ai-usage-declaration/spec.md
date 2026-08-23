## ADDED Requirements

### Requirement: A declaração de uso de inteligência artificial é um elemento opcional do modelo

O modelo SHALL oferecer comando próprio para a Declaração de uso de Inteligência Artificial, emitida como página própria, com título e posição definidos pelo modelo.

O elemento SHALL ser opcional em todos os tipos de documento, e SHALL NOT produzir página, título ou entrada de sumário quando não declarado.

A documentação SHALL dizer explicitamente que o elemento não é previsto por norma ABNT, para que o autor não o tome por exigência normativa nem por garantia de conformidade.

#### Scenario: Autor declara o uso de ferramentas de IA

- **WHEN** o autor declara a declaração no preâmbulo
- **THEN** a página é emitida na posição que o modelo define, com título próprio

#### Scenario: Autor não declara nada

- **WHEN** o comando não é usado
- **THEN** o documento compila sem a página e sem deixar espaço em branco em seu lugar

#### Scenario: O manual não promete conformidade

- **WHEN** o manual documenta o elemento
- **THEN** ele registra que nenhuma norma ABNT o prevê, e que o formato é escolha do modelo
