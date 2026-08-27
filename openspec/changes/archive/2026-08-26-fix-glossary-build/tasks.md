## 1. Fazer o ciclo de compilação gerar os glossários

- [x] 1.1 Acrescentar ao `.latexmkrc` as duas `add_cus_dep` e o gancho `run_makeglossaries`, na forma testada em `design.md` §4: `fileparse` para extrair o caminho e passá-lo em `-d`, sem codificar `build` na regra.
- [x] 1.2 Acrescentar `nomain` às opções de `glossaries` em `UnifeiICTReport.sty:350`. Sem isso o `makeglossaries` avisa `File 'manual.glo' is empty` em toda compilação, e o pacote continua oferecendo um glossário que não documenta.
- [x] 1.3 Acrescentar a `$clean_ext` os auxiliares de glossário: `acn acr alg slo sls slg ist`. Conferir contra uma compilação limpa que nenhum outro sobra em `build/`.

## 2. Guardar a lista vazia

- [x] 2.1 Escrever no `.sty` a guarda em volta de `\printglossary`: sem entrada usada daquele tipo, nada é emitido — nem página, nem título, nem entrada de sumário — e sai um `\PackageWarning` nomeando a lista pulada.

  A guarda **não** pode ser do lado do latexmk: medido em `design.md` §5, apagar o `.acr` não remove a página. Ela não vem do arquivo gerado.

  O texto do aviso segue o mesmo molde que `add-empty-list-guard` usar nas listas de ilustração — é a mesma pergunta feita ao autor, e responder diferente em cada lista ensinaria uma regra que não vale.

## 3. Verificar lendo a página

- [x] 3.1 Compilar `manual.tex` do zero e **ler a página 8** — a que hoje sai inteiramente em branco. Confirmar que traz a lista de abreviaturas e a de símbolos, com os itens efetivamente citados no texto, e que ambas constam do sumário.
- [x] 3.2 Compilar um documento que declare os dois glossários e **não cite nenhum**. Confirmar contagem de páginas idêntica à do mesmo documento sem as chamadas de `\printglossary`, e o aviso no log. O número de referência está em `design.md` §5: 2 páginas contra 3.
- [x] 3.3 Descomentar os dois `\printglossary` num dos seis arquivos de partida, acrescentar uma sigla e compilar. É o caminho que `add-type-skeletons` instrui o autor a seguir, e o que entregava a página em branco.
- [x] 3.4 Rodar `latexmk -c` e confirmar que os auxiliares de glossário saem de `build/`.

## 4. Documentação

- [x] 4.1 Revisar `Capitulos/cap6/cap6.tex:127`, que hoje avisa que `\printglossary` sem sigla citada produz página órfã. Depois da tarefa 2.1 o comportamento é outro — nada é emitido e o log avisa — e o texto foi escrito sem saber que a causa real era o passo de compilação ausente.
- [x] 4.2 Acrescentar o **glossário (§4.2.3.2)** à seção "O que este modelo não oferece" do capítulo 3 (`Capitulos/cap3/cap3.tex:188-197`), ao lado de errata, lombada e índice. Decorre da tarefa 1.2: com `nomain`, o elemento pós-textual deixa de estar disponível, e a Regra de Platina exige que a ausência seja declarada.

  Registrar ali que é ausência com change própria já registrada, `add-glossary-backmatter`, para que a lista não sugira decisão definitiva.
- [x] 4.3 Dizer no capítulo 2, junto das instruções de compilação, que os glossários dependem do `latexmk`: quem compilar chamando `xelatex` à mão, ou por editor com cadeia própria, não terá as listas. Hoje o capítulo promete a compilação de um comando só e não diz o que se perde fora dela.

## 5. Ao arquivar

- [x] 5.1 Confirmar que a capability `abbreviation-symbol-lists` foi criada em `openspec/specs/` com os três cenários do delta.
- [x] 5.2 Conferir se `add-empty-list-guard` já decidiu o texto do aviso e se os dois coincidem. Se esta change entrar primeiro, ela fixa o molde; se entrar depois, ela o segue.

## Registro de aplicação

O `add_cus_dep` com `fileparse` funcionou como o `design.md` §4 previu, sem ajuste: `.acn` e `.slo` viram `.acr` e `.sls` dentro de `build/`, e o `latexmk` resolve as passadas sozinho. Com `nomain`, o aviso `File 'manual.glo' is empty` desapareceu do log.

A guarda do glossário vazio entrou por um ponto que o desenho não nomeava: **`\@printgloss@checkexists@noignored`**, do próprio `glossaries`. É onde o `\printglossary` já chegou depois de o `\setkeys` ter resolvido `\@glo@type`, e onde o corpo inteiro da emissão passa como argumento. Isso evitou reimplementar o keyval do pacote só para descobrir o tipo, e faz a guarda valer para qualquer forma de chamada — `\printglossary[type=...]`, `\printacronyms`, `\printsymbols`.

O critério contado é **entrada citada, não entrada declarada**: o total de `\ifglsused` verdadeiros por tipo vai ao `.aux` no fim de uma passada e é lido na seguinte, pelo mesmo motivo das listas de ilustração — quando `\printglossary` roda, nos pré-textuais, nenhuma entrada foi usada ainda. Está dito assim no manual e no comentário dos esqueletos, porque é a distinção que o autor precisa entender para não estranhar a lista ausente.

Tarefa 5.2 resolvida na própria aplicação: o texto do aviso é **um só macro**, `\Unifei@AvisaListaPulada`, usado pelas listas de ilustração e pelos glossários. Não há dois textos a manter alinhados.

Correção à tarefa 3.1: ela pedia confirmar que as duas listas **constam do sumário**. Não constam — e não devem. Este modelo não põe elemento pré-textual algum no sumário, nem as listas de figuras e tabelas, nem os resumos, conforme a NBR 6027. A expectativa da tarefa estava errada; o comportamento está certo e é uniforme.

Verificação, lendo as páginas:

- `manual.tex` compilado do zero: a **página 8**, que saía inteiramente em branco, traz a lista de abreviaturas e siglas com CTAN e MMC — as duas efetivamente citadas no texto — e a página seguinte traz a lista de símbolos.
- Documento que declara os dois glossários e não cita nenhum: mesma contagem de páginas do documento sem as chamadas, e dois avisos no log, um por tipo.
- `modelo-generico` com `\makeglossaries`, um `\newacronym` e um `\gls` no texto: 9 páginas contra 8, com a lista impressa — o caminho que os arquivos de partida instruem, e o que entregava a página em branco.
- `latexmk -c` remove `acn acr alg slo sls slg ist` de `build/`.
- Os seis arquivos de partida mantêm a paginação.

**5.1, registro:** criada com os três cenários do delta intactos — siglas citadas, documento sem
sigla alguma, símbolos e siglas juntos. O `Purpose` veio do CLI em inglês e foi reescrito em
português.

**5.2, registro:** `add-empty-list-guard` entrou primeiro e fixou o molde; esta o segue sem
esforço, porque a guarda do glossário chama o mesmo `\Unifei@AvisaListaPulada`.
