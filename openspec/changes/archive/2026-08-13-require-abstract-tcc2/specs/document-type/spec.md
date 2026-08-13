## MODIFIED Requirements

### Requirement: Os três tipos de monografia compartilham o layout mas não o comportamento
TCC2, dissertação e tese SHALL produzir a mesma diagramação de monografia, diferindo no grau pretendido e na obrigatoriedade de área de concentração. A obrigatoriedade do resumo em língua estrangeira SHALL ser a mesma nos três, por serem regidos pela ABNT NBR 14724:2024 sob o mesmo regime.

#### Scenario: Grau pretendido

- **WHEN** o tipo é TCC2, dissertação ou tese
- **THEN** a natureza declara, respectivamente, Bacharel, Mestre ou Doutor

#### Scenario: Área de concentração conforme o tipo

- **WHEN** o tipo é dissertação ou tese
- **THEN** a área de concentração é exigida, e sua ausência interrompe a compilação com mensagem nomeando o metadado que falta, em vez de produzir uma folha silenciosamente incompleta

#### Scenario: Área de concentração no TCC2

- **WHEN** o tipo é TCC2
- **THEN** a área de concentração é aceita mas não exigida, aparecendo apenas quando declarada — o caso em que o trabalho integra um projeto maior

#### Scenario: Linha de pesquisa

- **WHEN** qualquer tipo de monografia declara linha de pesquisa
- **THEN** ela aparece na natureza; sem declaração, nada aparece, em nenhum dos três

### Requirement: O resumo é obrigatório e o abstract depende do tipo

Todo documento SHALL ter resumo na língua do texto. O resumo em língua estrangeira SHALL ser obrigatório nos três tipos de monografia — TCC2, dissertação e tese —, que a ABNT NBR 14724:2024 rege sob o mesmo regime, e opcional nos demais tipos.

#### Scenario: Resumo sempre presente

- **WHEN** o documento é de qualquer tipo
- **THEN** o resumo na língua do texto é emitido

#### Scenario: Abstract exigido

- **WHEN** o tipo é TCC2, dissertação ou tese e o abstract não foi declarado
- **THEN** a compilação falha nomeando o que falta, conforme o §4.2.1.8, que torna o resumo em língua estrangeira obrigatório

#### Scenario: Abstract dispensado

- **WHEN** o tipo é relatório genérico, relatório de estágio ou TCC1, e o abstract não foi declarado
- **THEN** o documento compila sem ele, sem aviso, e nenhuma página em branco é produzida em seu lugar

#### Scenario: Projeto de pesquisa não é exceção aberta

- **WHEN** o tipo é TCC1 e o abstract não foi declarado
- **THEN** a dispensa decorre de a NBR 15287:2025 não prever resumo entre os elementos pré-textuais do projeto de pesquisa, e não de uma flexibilização da NBR 14724:2024
