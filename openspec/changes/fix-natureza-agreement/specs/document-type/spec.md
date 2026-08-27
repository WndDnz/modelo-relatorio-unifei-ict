## MODIFIED Requirements

### Requirement: Os três tipos de monografia compartilham o layout mas não o comportamento
TCC2, dissertação e tese SHALL produzir a mesma diagramação de monografia, diferindo no grau pretendido e na obrigatoriedade de área de concentração. A obrigatoriedade do resumo em língua estrangeira SHALL ser a mesma nos três, por serem regidos pela ABNT NBR 14724:2024 sob o mesmo regime.

O texto da natureza SHALL concordar gramaticalmente com o nome do trabalho que o próprio tipo determina, sem depender de coincidência de gênero entre os tipos.

#### Scenario: Grau pretendido

- **WHEN** o tipo é TCC2, dissertação ou tese
- **THEN** a natureza declara, respectivamente, Bacharel, Mestre ou Doutor

#### Scenario: Concordância com o nome do trabalho

- **WHEN** a natureza nomeia o trabalho conforme o tipo — "Trabalho de Conclusão de Curso", "Dissertação" ou "Tese"
- **THEN** o particípio e os demais termos que se refiram a ele concordam em gênero e número, tanto na folha de rosto quanto na folha de aprovação

#### Scenario: Área de concentração conforme o tipo

- **WHEN** o tipo é dissertação ou tese
- **THEN** a área de concentração é exigida, e sua ausência interrompe a compilação com mensagem nomeando o metadado que falta, em vez de produzir uma folha silenciosamente incompleta

#### Scenario: Área de concentração no TCC2

- **WHEN** o tipo é TCC2
- **THEN** a área de concentração é aceita mas não exigida, aparecendo apenas quando declarada — o caso em que o trabalho integra um projeto maior

#### Scenario: Linha de pesquisa

- **WHEN** qualquer tipo de monografia declara linha de pesquisa
- **THEN** ela aparece na natureza; sem declaração, nada aparece, em nenhum dos três
