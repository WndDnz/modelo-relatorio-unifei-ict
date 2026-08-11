## Context

Duas normas foram lidas na íntegra para este levantamento: **ABNT NBR 14724:2024** (trabalhos acadêmicos) e **ABNT NBR 15287:2025** (projeto de pesquisa, terceira edição, 18.03.2025). As duas estão em `.refs/`, fora do versionamento.

A comparação estrutural entre elas é o dado central desta change, porque a diferença é maior do que a nomenclatura "TCC1/TCC2" sugere. Os pré-textuais do projeto de pesquisa vão de §4.2.1.1 a §4.2.1.**6** e terminam — folha de rosto, listas, sumário. **Não há folha de aprovação e não há resumo**; não é lacuna de numeração, esses elementos não fazem parte do documento. A capa é **opcional** (§4.1.1), contra obrigatória na 14724. A folha de rosto pede *"tipo de projeto de pesquisa e nome da entidade a que deve ser submetido"* (§4.2.1.1(e)) — sem objetivo e sem grau pretendido, porque no desenho da norma não se pretende grau ainda. E o corpo textual é **prescrito** (§4.2.2): tema, problema, hipóteses quando couberem, objetivos, justificativa, referencial teórico, metodologia, recursos e cronograma.

O que existe no modelo para trabalhar em cima:

- `UnifeiICTReport.sty:18–38` — o bloco de opções do pacote, com `\DeclareOption{neverindent}`, as opções de família tipográfica e um `\DeclareOption*` que acumula o desconhecido em `\UnifeiICTReport@rawopts` para repassar ao babel.
- `UnifeiICTReport.sty:~529` — `\supervisor`, valor único, com booleano `\if@supervisorpresent`.
- `\folhaaprovacao` e os quatro `\Unifei@FolhaAprovacao@<tipo>`, mais `\Unifei@AssinaturaBloco`, que desenha `\rule{7cm}{0.4pt}` por signatário.
- `\makeabstracts`, que emite resumo e abstract incondicionalmente.
- `\bancamembro`, acumulador repetível — já suporta banca de tamanho variável, que é exatamente o que o ICT tem.

## Goals / Non-Goals

**Goals:**

- Tornar o tipo de documento um estado declarado uma vez e consultável, em vez de um parâmetro de um comando.
- Cobrir corretamente os quatro documentos que o ICT gera neste modelo, com os seis valores de seleção.
- Registrar cada afastamento da norma com sua base institucional, já que este repositório é a proposta do modelo oficial do ICT e vai ser a referência de outras pessoas.
- Não quebrar documento algum já escrito contra a interface atual.

**Non-Goals:**

- O artigo científico. No TCC2 ele **substitui integralmente** a monografia, e tem modelo à parte. A dispensa de banca por publicação prévia pertence a ele, não a este modelo — aqui o TCC2 é sempre monografia com banca.
- A Ata de Defesa, que já existe em forma eletrônica e é instrumento da secretaria.
- Gerar o esqueleto textual do TCC1. A estrutura da §4.2.2 é documentada; os capítulos continuam por conta do autor, já que ela não altera a configuração do sumário.
- Ficha catalográfica, errata, dedicatória, agradecimentos, epígrafe e índice — continuam fora, como nas changes anteriores.

## Decisions

**Opção de pacote, não classe nova.**
Considerou-se virar `unifeiict.cls` embrulhando o `book`, o que daria literalmente `\documentclass[tcc1]{unifeiict}` e seria mais limpo para o autor. Rejeitado pelo custo: obrigaria a refatorar todo driver existente, e o ganho é ergonômico, não normativo. `\usepackage[tcc1]{UnifeiICTReport}` resolve com o mecanismo de opções que o `.sty` já tem montado.

**O tipo vai como chave (`tipo=<valor>`), não como palavra solta.**
A primeira implementação usou a forma curta `[tcc1]`, com os seis valores declarados por `\DeclareOption`. Os valores corretos funcionavam, mas um **erro de digitação** continuava caindo no `\DeclareOption*`, que repassa o desconhecido ao babel — e saía como `Package babel Error: Unknown option 'tcc11'`, longe da causa. Verificado por compilação. O pacote não tem como distinguir, ali, um tipo errado de um idioma que ele não conhece: a informação não existe.

Três saídas foram avaliadas: aceitar o erro do babel (deixaria o requisito descumprido); manter lista branca de idiomas (bloquearia idiomas legítimos do babel que o modelo não previu — regressão); ou tornar a intenção explícita com uma chave. A terceira foi escolhida: `tipo=` torna a opção inequivocamente um tipo, o erro passa a ser nosso e nomeia os seis valores, e os idiomas continuam sendo repassados intactos (`[tipo=tese,spanish]` funciona).

A forma curta antiga não fica silenciosamente aceita nem silenciosamente ignorada: os seis valores continuam declarados, mas apenas para recusar com uma mensagem que ensina a forma correta — é o engano mais provável de quem viu um rascunho anterior.

**`tcc2`, `dissertacao` e `tese` selecionam o mesmo layout, mas não são aliases puros.**
Os três produzem monografia, com a mesma diagramação. Diferem em três parâmetros:

| | grau | abstract | área de concentração |
|---|---|---|---|
| `tcc2` | Bacharel | opcional | opcional |
| `dissertacao` | Mestre | obrigatório | obrigatória |
| `tese` | Doutor | obrigatório | obrigatória |

Chamá-los de alias descreve o layout, não o comportamento. A linha de pesquisa é opcional nos três.

**A folha de aprovação é condicional apenas no TCC1.**
No TCC1 a defesa é facultativa, a critério do orientador; sem banca, o texto é analisado individualmente e cada membro informa a nota diretamente ao orientador, e a folha não existe. No TCC2 a dispensa de banca existe, mas está amarrada à forma artigo — que é outro modelo. Neste modelo, portanto, o TCC2 sempre tem banca e sempre tem folha.

**O orientador é membro da banca e não deve ser redeclarado.**
A banca do ICT é orientador + no mínimo dois membros externos. Como `\supervisor` já é declarado para a capa, obrigar um `\bancamembro` repetindo o mesmo nome é uma duplicação que o autor vai errar. O orientador entra na composição a partir do `\supervisor`. O mínimo de dois externos é regra institucional, não da norma; documentar sem impor, para não travar um caso legítimo que ninguém previu.

**Quebra limpa: os valores antigos não sobrevivem como forma depreciada.**
`\folhaaprovacao[disciplina|estagio|tcc|dissertacao]` deixa de aceitar tipo por parâmetro. Considerou-se manter os valores antigos por um ciclo, mas eles têm destinos diferentes e um deles é indefensável: `disciplina` → `generico` é renome puro e aliasável, mas **`tcc` não é mapeável** — ele se divide em `tcc1` e `tcc2`, que são regidos por normas diferentes. Um alias teria de adivinhar entre projeto de pesquisa e monografia, e errar aí não produz erro de compilação: produz um documento inteiro sob a norma errada, silenciosamente. Some-se a isso que a folha de aprovação foi criada no mesmo dia desta change e não tem base instalada real. Um erro explícito nomeando os seis tipos novos ensina a migração; um alias que adivinha esconde o problema.

**Vários professores reaproveitam o mecanismo de pluralização que a capa já tem.**
A capa detecta múltiplos autores procurando `\\` no `\@author` detokenizado e alterna o rótulo entre "Autor" e "Autores". `\supervisor` passa a aceitar a mesma forma, com a mesma detecção, em vez de uma segunda convenção. Consequência desejada: quem declara um professor só não vê diferença nenhuma na capa.

**O rótulo do papel varia por tipo.**
Hoje a capa e a folha de rosto imprimem "Orientador", fixo. Num relatório genérico a pessoa não orienta — é o professor responsável pela disciplina. Como o tipo passa a ser estado consultável, o rótulo passa a derivar dele:

| tipo | rótulo |
|---|---|
| `generico` | Professor / Professores |
| `estagio` | Orientador (+ Supervisor de campo, na folha de aprovação) |
| `tcc1`, `tcc2`, `dissertacao`, `tese` | Orientador (+ Coorientador) |

**Idioma dos artefatos: português, a partir daqui.**
O corpus OpenSpec deste repositório nasceu em inglês — os sete specs principais e os proposals das changes anteriores — enquanto o código, os comentários do `.sty` e o `README.md` sempre foram em português. Como o modelo é institucional brasileiro e as normas que ele implementa são em português, a decisão é escrever os artefatos em português a partir desta change, e migrar os existentes depois, em esforço próprio.

Consequência imediata e transitória: os três requisitos que esta change modifica em `approval-sheet` mudam de nome ao mudar de idioma, e vão declarados em `## RENAMED Requirements` para o sync casar cada um com o que substitui. Depois do arquivamento, `approval-sheet` fica com três requisitos em português e dois ainda em inglês — os que esta change não toca. A mistura é indesejada e some quando a migração acontecer; registrada aqui para não ser confundida com descuido.

## Registro de desvios da norma

Este modelo se afasta da norma em quatro pontos, todos deliberados. Registrados aqui com a base de cada um, para que ninguém "corrija" depois o que está certo de propósito.

**D1 — A folha de aprovação não tem linhas de assinatura, em nenhum tipo.**
A NBR 14724 §4.2.1.3 é explícita no sentido contrário: *"A data de aprovação e as assinaturas dos componentes da banca examinadora devem ser colocadas após a aprovação do trabalho."* A prática das universidades passou a registrar a assinatura apenas na Ata de Defesa, aparentemente desde que as defesas de pós-graduação passaram a ser inteiramente digitais. Verificado contra as teses recentes publicadas no repositório institucional da Unifei: nenhuma apresenta assinaturas na folha de aprovação. A folha passa a ser registro de composição da banca e data.

**D2 — O TCC1 tem capa e resumo.**
A NBR 15287 torna a capa opcional (§4.1.1) e não prevê resumo entre os pré-textuais (§4.2.1.1 a §4.2.1.6). Mantidos por uniformidade entre os modelos do ICT — um aluno que passa do TCC1 ao TCC2 não deve encontrar dois documentos com anatomias diferentes sem motivo.

**D3 — O TCC1 pode ter folha de aprovação.**
A NBR 15287 não prevê o elemento. Como a defesa do TCC1 é facultativa no ICT, quando ela ocorre o elemento é emprestado da prática da 14724.

**D4 — A natureza do TCC1 declara grau pretendido.**
A NBR 15287 §4.2.1.1(e) pede *"tipo de projeto de pesquisa e nome da entidade a que deve ser submetido"*, sem objetivo e sem grau — o projeto, no desenho da norma, é documento autônomo.

O contexto institucional que justifica o afastamento: até o PPC anterior, os dois semestres de TCC contavam como uma etapa única. O PPC de 2023 dividiu em TCC1 (planejamento) e TCC2 (conclusão), justamente para o aluno organizar o trabalho ao longo do ano em vez de concentrar tudo no último semestre e entregar um trabalho ruim. O TCC1 ficou, com isso, um híbrido: **estrutura de projeto de pesquisa, finalidade de monografia** — é requisito parcial para o título, e só o cumprimento das duas etapas titula o Bacharel. A natureza reflete essa finalidade, não a autonomia que a 15287 pressupõe.

## Risks / Trade-offs

- **Opções não declaradas vazam para o babel.** → Risco concreto, não hipotético, dado o `\DeclareOption*` atual. Declarar os seis explicitamente e verificar por compilação que um tipo inválido produz erro do próprio pacote, nomeando os valores aceitos, e não um erro de idioma.
- **Documentos já escritos usam `\folhaaprovacao[disciplina]` e afins.** → A interface muda de parâmetro de comando para opção de pacote. Decidir se os valores antigos continuam aceitos no comando como forma depreciada, ou se a quebra é assumida — o modelo é novo e a base instalada é pequena, mas a decisão deve ser explícita e não acidental.
- **`\supervisor` com múltiplos valores colide com a capa.** → A capa já formata o orientador em bloco próprio, e o `\if@supervisorpresent` é booleano. Aceitar vários professores exige decidir como eles aparecem na capa, não só na folha — e a capa não deve mudar de aparência para quem tem um professor só.
- **Metadado obrigatório por tipo precisa falhar cedo.** → Área de concentração é obrigatória em dissertação e tese. Sem ela, a folha sairia silenciosamente incompleta. O modelo já tem o padrão de errar explicitamente (tipo desconhecido de `\folhaaprovacao`); aplicar o mesmo aqui.
- **A `\makeabstracts` é chamada pelo driver, não pelo tipo.** → Tornar o abstract condicional significa que o comando passa a decidir sozinho o que emitir; um autor que hoje conta com os dois resumos não deve perder o abstract por acidente ao migrar.

## Open Questions

Nenhuma. As duas que existiam foram resolvidas e estão registradas em Decisions: a quebra limpa dos valores antigos e a apresentação de vários professores.
