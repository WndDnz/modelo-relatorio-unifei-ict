# package-options Specification

## Purpose

Governa o contrato das opções que o pacote aceita no `\usepackage`: toda opção declarada produz efeito observável na saída, nenhuma quebra a compilação por defeito da própria declaração, e opção retirada falha com erro do pacote em vez de escorregar para o babel como nome de idioma. Cobre as opções de família tipográfica (`roman`, `sans`); a seleção do tipo de documento por `tipo=` pertence a `document-type`.

## Requirements

### Requirement: Opção declarada tem efeito ou não é declarada

Toda opção que o pacote aceitar no `\usepackage` SHALL produzir um efeito observável na saída, ou SHALL deixar de ser declarada.

Nenhuma opção declarada SHALL interromper a compilação por defeito da própria declaração.

Opção retirada SHALL falhar com erro do próprio pacote, nomeando a retirada, e SHALL NOT ser repassada silenciosamente ao babel como nome de idioma.

#### Scenario: Opção aceita e sem efeito

- **WHEN** o autor passa uma opção que o pacote declara
- **THEN** a saída difere de forma observável da saída sem a opção

#### Scenario: Opção que hoje quebra o build

- **WHEN** o autor passa `neverindent`
- **THEN** a compilação não é interrompida por sequência de controle indefinida dentro do pacote

#### Scenario: Opção retirada

- **WHEN** o autor passa uma opção que o pacote deixou de oferecer
- **THEN** a compilação para com mensagem do pacote nomeando a opção e o que a substituiu, e não com um erro de idioma do babel
