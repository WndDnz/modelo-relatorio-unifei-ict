## 1. `neverindent` sai

- [x] 1.1 Substituir `:18` por um `\DeclareOption{neverindent}` que emite `\PackageError` nomeando a remoção e dizendo que a opção nunca teve efeito — em vez do `\@neverindenttrue` que hoje quebra a compilação com sequência de controle indefinida.
- [x] 1.2 Retirar `neverindent` da lista de exclusão do detector de idioma (`:253`), mantendo `roman` e `sans`.

  Sem isto a remoção não é remoção: o nome continua sendo engolido antes de chegar ao `\DeclareOption`, e a opção fica silenciosa em vez de errar. Ver `design.md` §4.
- [x] 1.3 Deixar `\RequirePackage{indentfirst}` (`:447`) como está. Trabalhos ABNT são indentados, e nenhum elemento das normas pede supressão de recuo de primeira linha — inclusive a citação longa, que resolve o próprio recuo com `\noindent` interno.

## 2. `roman` e `sans` passam a funcionar

- [x] 2.1 Dar valor inicial a `\if@roman` (`:21`) correspondente ao comportamento atual: serifada no corpo. Hoje a flag nasce falsa por omissão, e o padrão de fato do documento é o oposto disso.
- [x] 2.2 Fazer a família do corpo derivar da flag.
- [x] 2.3 Fazer `:466` consultar `\if@roman` em vez de fixar `labelfont={bf,sf},textfont={sf}`. Corpo e legenda passam a ser famílias opostas por construção.

  É esta tarefa que dá conteúdo às opções. Sem ela, `roman`/`sans` trocariam metade do documento e deixariam a legenda parada.
- [x] 2.4 **Não** mexer no mecanismo de `:492` e `:620-645`. Ele decide *qual* fonte sem serifa existe na máquina, com fallback e aviso; a opção decide *onde* a sem serifa é usada. Camadas diferentes. Deixar comentário no código dizendo isso, porque a proximidade convida à fusão.

## 3. Verificar lendo a página

- [x] 3.1 Compilar com `[tipo=generico]`, `[tipo=generico,roman]` e `[tipo=generico,sans]`. Ler as três páginas: as duas primeiras têm de ser idênticas, a terceira invertida no corpo **e** na legenda.

  Hoje as três saem idênticas — é assim que o defeito foi descoberto. Comparar também com `pdffonts`: hoje as três embutem o mesmo conjunto.
- [x] 3.2 Compilar com `[tipo=generico,neverindent]` e confirmar que a mensagem de erro explica a remoção, em vez do `! Undefined control sequence` de hoje.
- [x] 3.3 Compilar com um idioma explícito e uma das opções juntos — `[tipo=generico,english,sans]` — e confirmar que o detector de idioma continua acertando. É o que `:253` protege.

## 4. Documentação

- [x] 4.1 Documentar `roman` e `sans` no capítulo 3, junto de `tipo=`, com o que cada uma faz no corpo **e** na legenda.
- [x] 4.2 **Exemplificar.** Pela Regra de Platina, exemplo é parte do requisito. Exemplificar inversão tipográfica num manual que é ele próprio compilado significa mostrar as duas saídas, não descrevê-las — e o manual compila com uma opção só.

  Resolver na hora: um trecho curto composto à mão com as famílias trocadas, uma figura, ou o exemplo remetendo a compilar um esqueleto com a opção. O que **não** serve é descrever a inversão em prosa e chamar isso de exemplo.
- [x] 4.3 Declarar a remoção de `neverindent` onde o manual lista o que o modelo não oferece (`cap3.tex:188-197`), ou junto das opções — decidir qual lugar diz melhor que a opção existiu e foi retirada.
- [x] 4.4 Fechar a dívida de `rewrite-usage-guide`: a tarefa 6.1 daquela change apontou para cá as três opções que ficaram sem documentar. Conferir que nenhuma das três continua fora do manual.

## 5. Ao arquivar

- [ ] 5.1 Criar a capability `package-options` em `openspec/specs/` a partir do delta.
- [ ] 5.2 Conferir que `document-type` continua sendo a dona de `tipo=`, sem sobreposição com a capability nova.

## Registro de aplicação

Três coisas saíram diferentes do planejado, todas apuradas por medição antes de editar:

- **A lista de exclusão de `:253` era código morto**, e não o mecanismo que o `design.md` §4 supunha. `roman`, `sans` e `neverindent` são declaradas com `\DeclareOption`, então `\ProcessOptions` as consome com o código próprio delas e nunca chama o `\DeclareOption*` que alimenta `\UnifeiICTReport@rawopts`. Medido: com `[tipo=generico,sans]` a lista sai vazia. A tarefa 1.2 foi cumprida removendo o bloco inteiro, e não só o nome `neverindent`.
- **A tarefa 2.1 não precisou de edição.** `\if@roman` já nascia verdadeira, por `\ExecuteOptions{roman}` imediatamente antes de `\ProcessOptions`. O `design.md` dizia que a flag nascia falsa por omissão; nasce certa.
- **`tipo=` é documentado no capítulo 1**, na seção "Seis tipos de documento", e não no capítulo 3 como as tarefas 4.1 e 4.3 diziam. As opções novas entraram ao lado dele, em `sec:opcoes-fonte`, com a remoção de `neverindent` em subseção própria. A seção "O que este modelo não oferece" do capítulo 3 não foi tocada: ela lista elementos de norma ausentes, e `neverindent` é opção retirada, que se explica junto das opções que ficaram.

Verificação da tarefa 3.1, lendo a página: as saídas de `[tipo=generico]` e `[tipo=generico,roman]` são bit a bit idênticas ao rasterizar; `sans` difere. `pdffonts` confirma a inversão nas duas camadas — em `roman`, corpo Heuristica e legenda IBM Plex Sans; em `sans`, corpo IBM Plex Sans e legenda Heuristica.
