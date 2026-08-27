# direct-citation Specification

## Purpose

Governa a apresentação da citação direta no texto, sob a ABNT NBR 10520:2023 — em primeiro lugar o destaque da citação longa, que o §7.1.1 manda recuar, reduzir de corpo, compor em espaço simples e deixar sem aspas. É a primeira capability deste repositório a reger a 10520; a 6023, das referências, é de `bibliography-accuracy`, e o espacejamento do corpo do texto não é daqui.

## Requirements

### Requirement: A citação direta longa é composta em espaço simples

A citação direta com mais de três linhas SHALL ser composta em espaço simples entre as linhas, independentemente do espacejamento adotado no corpo do texto (NBR 10520:2023 §7.1.1; NBR 14724:2024 §5.2).

O bloco SHALL manter os demais destaques que a norma exige: recuo padronizado em relação à margem esquerda, letra de tamanho menor que a do texto e ausência de aspas.

#### Scenario: Documento com espacejamento 1,5 no corpo

- **WHEN** o corpo do texto está em espaço 1,5 e o autor insere uma citação direta com mais de três linhas
- **THEN** o bloco citado sai em espaço simples, enquanto o texto ao redor permanece em 1,5

#### Scenario: Os quatro destaques do §7.1.1 coexistem

- **WHEN** a citação longa é composta
- **THEN** ela sai recuada da margem esquerda, em letra menor, em espaço simples e sem aspas — os quatro ao mesmo tempo, e não três deles
