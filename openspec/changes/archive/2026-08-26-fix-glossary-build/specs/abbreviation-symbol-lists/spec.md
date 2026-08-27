## ADDED Requirements

### Requirement: Lista de abreviaturas e de símbolos declarada é impressa

Sigla declarada e citada no texto SHALL aparecer na lista de abreviaturas e siglas (NBR 14724:2024 §4.2.1.7), e símbolo declarado e citado SHALL aparecer na lista de símbolos (§4.2.1.8), quando o documento chamar a lista correspondente.

O ciclo de compilação documentado pelo modelo SHALL executar por si só todos os passos necessários para isso. Não SHALL ser exigido do autor nenhum comando manual além do que o manual descreve como forma de compilar.

Chamada de lista que não produz conteúdo SHALL NOT emitir página em branco.

#### Scenario: Documento com siglas citadas no texto

- **WHEN** o autor declara siglas, cita-as no texto e chama a lista de abreviaturas
- **THEN** a lista sai impressa com as siglas e suas expansões, na compilação normal do modelo

#### Scenario: Documento sem sigla alguma

- **WHEN** a chamada da lista existe mas nenhuma sigla foi citada no texto
- **THEN** a compilação termina sem erro e nenhuma página em branco é emitida no lugar da lista

#### Scenario: Símbolos e siglas no mesmo documento

- **WHEN** o documento declara siglas e símbolos e chama as duas listas
- **THEN** cada lista sai com os seus próprios itens, sem que uma sobrescreva ou absorva a outra
