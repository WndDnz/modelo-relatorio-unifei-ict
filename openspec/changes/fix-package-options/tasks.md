## 1. `neverindent` sai

- [ ] 1.1 Substituir `:18` por um `\DeclareOption{neverindent}` que emite `\PackageError` nomeando a remoção e dizendo que a opção nunca teve efeito — em vez do `\@neverindenttrue` que hoje quebra a compilação com sequência de controle indefinida.
- [ ] 1.2 Retirar `neverindent` da lista de exclusão do detector de idioma (`:253`), mantendo `roman` e `sans`.

  Sem isto a remoção não é remoção: o nome continua sendo engolido antes de chegar ao `\DeclareOption`, e a opção fica silenciosa em vez de errar. Ver `design.md` §4.
- [ ] 1.3 Deixar `\RequirePackage{indentfirst}` (`:447`) como está. Trabalhos ABNT são indentados, e nenhum elemento das normas pede supressão de recuo de primeira linha — inclusive a citação longa, que resolve o próprio recuo com `\noindent` interno.

## 2. `roman` e `sans` passam a funcionar

- [ ] 2.1 Dar valor inicial a `\if@roman` (`:21`) correspondente ao comportamento atual: serifada no corpo. Hoje a flag nasce falsa por omissão, e o padrão de fato do documento é o oposto disso.
- [ ] 2.2 Fazer a família do corpo derivar da flag.
- [ ] 2.3 Fazer `:466` consultar `\if@roman` em vez de fixar `labelfont={bf,sf},textfont={sf}`. Corpo e legenda passam a ser famílias opostas por construção.

  É esta tarefa que dá conteúdo às opções. Sem ela, `roman`/`sans` trocariam metade do documento e deixariam a legenda parada.
- [ ] 2.4 **Não** mexer no mecanismo de `:492` e `:620-645`. Ele decide *qual* fonte sem serifa existe na máquina, com fallback e aviso; a opção decide *onde* a sem serifa é usada. Camadas diferentes. Deixar comentário no código dizendo isso, porque a proximidade convida à fusão.

## 3. Verificar lendo a página

- [ ] 3.1 Compilar com `[tipo=generico]`, `[tipo=generico,roman]` e `[tipo=generico,sans]`. Ler as três páginas: as duas primeiras têm de ser idênticas, a terceira invertida no corpo **e** na legenda.

  Hoje as três saem idênticas — é assim que o defeito foi descoberto. Comparar também com `pdffonts`: hoje as três embutem o mesmo conjunto.
- [ ] 3.2 Compilar com `[tipo=generico,neverindent]` e confirmar que a mensagem de erro explica a remoção, em vez do `! Undefined control sequence` de hoje.
- [ ] 3.3 Compilar com um idioma explícito e uma das opções juntos — `[tipo=generico,english,sans]` — e confirmar que o detector de idioma continua acertando. É o que `:253` protege.

## 4. Documentação

- [ ] 4.1 Documentar `roman` e `sans` no capítulo 3, junto de `tipo=`, com o que cada uma faz no corpo **e** na legenda.
- [ ] 4.2 **Exemplificar.** Pela Regra de Platina, exemplo é parte do requisito. Exemplificar inversão tipográfica num manual que é ele próprio compilado significa mostrar as duas saídas, não descrevê-las — e o manual compila com uma opção só.

  Resolver na hora: um trecho curto composto à mão com as famílias trocadas, uma figura, ou o exemplo remetendo a compilar um esqueleto com a opção. O que **não** serve é descrever a inversão em prosa e chamar isso de exemplo.
- [ ] 4.3 Declarar a remoção de `neverindent` onde o manual lista o que o modelo não oferece (`cap3.tex:188-197`), ou junto das opções — decidir qual lugar diz melhor que a opção existiu e foi retirada.
- [ ] 4.4 Fechar a dívida de `rewrite-usage-guide`: a tarefa 6.1 daquela change apontou para cá as três opções que ficaram sem documentar. Conferir que nenhuma das três continua fora do manual.

## 5. Ao arquivar

- [ ] 5.1 Criar a capability `package-options` em `openspec/specs/` a partir do delta.
- [ ] 5.2 Conferir que `document-type` continua sendo a dona de `tipo=`, sem sobreposição com a capability nova.
