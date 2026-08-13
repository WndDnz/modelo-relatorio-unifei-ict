## Purpose

Torna o tipo de documento um estado declarado uma vez, por opção de pacote, que governa o modelo inteiro: qual norma rege o trabalho, qual a natureza, se há folha de aprovação, quantos resumos existem e quais metadados são exigidos.

Cobre os quatro documentos que este modelo gera — relatório genérico, relatório de estágio, TCC1 (projeto de pesquisa, ABNT NBR 15287:2025) e monografia (ABNT NBR 14724:2024) — selecionados por seis valores.

## ADDED Requirements

### Requirement: O tipo de documento é declarado uma vez, como opção de pacote
O modelo SHALL aceitar o tipo de documento como opção no carregamento do pacote, e esse tipo SHALL ser o estado consultado por todos os elementos que dependem dele, em vez de ser repassado a cada comando.

#### Scenario: Tipo declarado

- **WHEN** o autor carrega o pacote informando um dos tipos admitidos
- **THEN** todos os elementos que dependem do tipo — natureza, folha de aprovação, resumos, metadados exigidos — passam a se comportar conforme aquele tipo, sem que o autor os informe de novo

#### Scenario: Tipo omitido

- **WHEN** o autor carrega o pacote sem informar tipo algum
- **THEN** o relatório genérico é adotado, por ser o uso mais comum deste modelo, e o documento compila como um relatório

#### Scenario: Tipo desconhecido

- **WHEN** o autor informa um valor que não é um dos tipos admitidos
- **THEN** a compilação falha com mensagem do próprio pacote, nomeando os valores aceitos — e não com um erro de idioma vindo do babel, para onde as opções desconhecidas do pacote são encaminhadas

#### Scenario: O tipo é informado como chave

- **WHEN** o autor declara o tipo no carregamento do pacote
- **THEN** ele o faz numa forma que identifica a opção como sendo o tipo do documento, e não como uma palavra solta — sem isso um valor digitado errado seria indistinguível de um idioma destinado ao babel, e falharia como erro de idioma

#### Scenario: Idiomas continuam sendo repassados

- **WHEN** o autor declara o tipo e também um idioma no mesmo carregamento do pacote
- **THEN** o idioma chega ao babel normalmente, sem que a validação do tipo interfira

#### Scenario: Forma antiga sem chave

- **WHEN** o autor informa um tipo válido como palavra solta, sem a chave
- **THEN** a compilação falha indicando a forma correta com aquele mesmo valor, em vez de aceitar duas grafias ou de deixar a opção vazar para o babel

### Requirement: Cada tipo declara a norma que o rege
O modelo SHALL associar cada tipo à norma correspondente, de modo que a base normativa de um documento seja determinável a partir do tipo declarado.

#### Scenario: Projeto de pesquisa

- **WHEN** o tipo é TCC1
- **THEN** o documento é regido pela ABNT NBR 15287:2025, com as adaptações institucionais registradas em design.md

#### Scenario: Monografia

- **WHEN** o tipo é TCC2, dissertação ou tese
- **THEN** o documento é regido pela ABNT NBR 14724:2024

#### Scenario: Relatórios

- **WHEN** o tipo é relatório genérico ou relatório de estágio
- **THEN** o documento é regido pela ABNT NBR 14724:2024 no que couber, conforme o §1 Escopo, que estende a norma aos trabalhos acadêmicos e similares, intra e extraclasse

### Requirement: Os três tipos de monografia compartilham o layout mas não o comportamento
TCC2, dissertação e tese SHALL produzir a mesma diagramação de monografia, diferindo no grau pretendido e na obrigatoriedade de abstract e de área de concentração.

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

### Requirement: O rótulo do papel do professor deriva do tipo
O rótulo que acompanha o professor na capa e na folha de rosto SHALL corresponder ao papel que ele exerce naquele tipo de documento, em vez de ser fixo.

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

### Requirement: A forma antiga de selecionar o tipo é recusada
Selecionar o tipo por parâmetro da folha de aprovação SHALL falhar, ensinando a forma nova, em vez de compilar sob interpretação adivinhada.

#### Scenario: Valor antigo mapeável

- **WHEN** o autor escreve a folha de aprovação passando um valor antigo que corresponde a um tipo atual
- **THEN** a compilação falha nomeando a nova forma de declarar o tipo e os valores admitidos

#### Scenario: Valor antigo ambíguo

- **WHEN** o autor passa o valor antigo que designava genericamente o trabalho de conclusão de curso
- **THEN** a compilação falha, porque aquele valor se divide em dois tipos regidos por normas diferentes e escolher um deles produziria um documento inteiro sob a norma errada, sem erro visível

### Requirement: O resumo é obrigatório e o abstract depende do tipo
Todo documento SHALL ter resumo na língua do texto. O resumo em língua estrangeira SHALL ser obrigatório em dissertação e tese, e opcional nos demais tipos.

#### Scenario: Resumo sempre presente

- **WHEN** o documento é de qualquer tipo
- **THEN** o resumo na língua do texto é emitido

#### Scenario: Abstract exigido

- **WHEN** o tipo é dissertação ou tese e o abstract não foi declarado
- **THEN** a compilação falha nomeando o que falta, conforme o §4.2.1.8, que torna o resumo em língua estrangeira obrigatório

#### Scenario: Abstract dispensado

- **WHEN** o tipo é relatório genérico, relatório de estágio, TCC1 ou TCC2, e o abstract não foi declarado
- **THEN** o documento compila sem ele, sem aviso, e nenhuma página em branco é produzida em seu lugar

### Requirement: A estrutura textual do projeto de pesquisa é documentada, não gerada
Para o TCC1 o modelo SHALL documentar a estrutura que a NBR 15287 §4.2.2 prescreve, sem criar arquivos nem impor divisões de seção.

#### Scenario: Orientação ao autor

- **WHEN** um autor escreve um TCC1
- **THEN** a documentação do modelo apresenta os elementos que a norma prescreve para a parte textual — tema, problema, hipóteses quando couberem, objetivos, justificativa, referencial teórico, metodologia, recursos e cronograma

#### Scenario: Sem esqueleto imposto

- **WHEN** o tipo é TCC1
- **THEN** o modelo não gera capítulos nem altera a configuração do sumário, que continua refletindo as seções que o autor efetivamente escrever
