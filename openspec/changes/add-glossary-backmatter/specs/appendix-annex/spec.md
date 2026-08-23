## ADDED Requirements

### Requirement: O glossário é oferecido como elemento pós-textual

O modelo SHALL oferecer comando próprio para o glossário (NBR 14724:2024 §4.2.3.2), emitido entre os elementos pós-textuais, com verbetes em ordem alfabética.

O glossário SHALL ser opcional: documento que não declare verbete algum SHALL compilar sem ele, sem emitir título nem página em branco em seu lugar.

#### Scenario: Documento com verbetes declarados

- **WHEN** o autor declara verbetes e chama o comando de glossário no `ackmatter`
- **THEN** o glossário sai impresso, em ordem alfabética, com título e entrada no sumário

#### Scenario: Verbetes com acentuação

- **WHEN** os verbetes começam por letras acentuadas ou cedilha
- **THEN** eles aparecem na posição alfabética que a ordenação do português determina, e não agrupados ao final

#### Scenario: Documento sem verbete algum

- **WHEN** nenhum verbete é declarado
- **THEN** o documento compila e nenhum título de glossário nem página em branco é emitido
