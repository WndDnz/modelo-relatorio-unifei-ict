## 1. A guarda

- [x] 1.1 Registrar, no fim do documento, se houve item de cada tipo, gravando a informação no `.aux`. O teste é `\value{<contador>}`: `\counterwithout{figure}{chapter}` e `{table}` (`:455-456`) e `within=none` (`:1131`) garantem que nenhum dos quatro contadores zera, então o valor no fim do documento é o total.

  **Não** ler o arquivo auxiliar para decidir. Ver `design.md` §2 e a alternativa descartada: um documento com um capítulo e nenhuma figura já tem `.lof` de 20 bytes, com o `\addvspace` que o `book.cls` grava por capítulo.
- [x] 1.2 Envolver com a guarda, em `\listoffigures` (`:1605`) e `\listoftables` (`:1615`), **só** o `\cleardoublepage`, o `\thispagestyle`, o título e o `\clearpage` final. O `\@starttoc` fica **fora** da guarda, sempre executado.

  Pular o `\@starttoc` fecha o stream de escrita e tranca a lista desligada para sempre — medido em `design.md`, alternativa descartada. E não é preciso: sozinho, sobre auxiliar sem `\contentsline`, ele não custa página.
- [x] 1.3 Emitir `\PackageWarning` nomeando a lista pulada.
- [x] 1.4 Dar à guarda o contador certo em cada tipo gerado, com `\PrepareListOf{<tipo>}{...}` dentro de `\novotipoilustracao` (`:1131`). `figure` e `table` ficam como padrão nos dois `\renewcommand`.

  Uma guarda só cobre as quatro listas: `\listofquadros` e `\listofgraficos` delegam a `\listoffigures`. Ver `design.md` §3 — **não** reimplementar as duas.

## 2. Verificar lendo a página

- [x] 2.1 Documento com um capítulo e nenhuma figura, chamando `\listoffigures`: nenhuma página, nenhum título, nenhuma entrada de sumário, e o aviso no log.
- [x] 2.2 O mesmo documento com uma figura: a lista sai, com a entrada certa. Confirmar que **duas** passadas bastam e que o latexmk converge — a guarda muda a contagem de páginas entre passadas, e é aí que oscilação apareceria.
- [x] 2.3 Repetir 2.1 e 2.2 para `\listoftables`, `\listofquadros` e `\listofgraficos`. As duas últimas são o teste de que a tarefa 1.4 funcionou.
- [x] 2.4 Compilar `manual.tex`, que tem figuras, tabelas e nenhum quadro nem gráfico. As duas listas chamadas continuam saindo; as duas comentadas continuam sem sair. Nenhuma mudança de saída onde há itens.

## 3. Documentação

- [x] 3.1 Documentar no manual que lista sem item não é emitida e que o log avisa. O capítulo 6 já fala de página órfã de glossário; alinhar os dois textos, porque a regra passa a ser a mesma.
- [x] 3.2 Decidir se os seis arquivos de partida passam a trazer as quatro chamadas **descomentadas**. O comentário existia como proteção; com a guarda, vira cortesia. Descomentar é o que faz o autor descobrir a lista quando ela passa a ter conteúdo — sem a guarda, seria o que lhe entregava a página em branco.

  A decisão é desta change agora que a guarda existe; a proposta a deixava para outra por não saber se haveria aviso.

## 4. Ao arquivar

- [ ] 4.1 Sincronizar o delta de `illustration-types` e resolver onde `\listoftables` (§4.2.1.10) fica governado — hoje nenhuma capability a cobre.
- [ ] 4.2 Conferir que o texto do aviso coincide com o de `fix-glossary-build`. Quem entrar primeiro fixa o molde.

## Registro de aplicação

A leitura do `newfloat` se confirmou na prática: uma guarda em `\listoffigures` cobre as quatro listas. `\novotipoilustracao` ganhou uma linha de `\PrepareListOf` que, dentro do grupo da delegação, diz qual contador aquele tipo testa. `\listoftables` passa `table` literal, porque tem `\renewcommand` próprio.

Duas coisas que o desenho não previa e que a implementação exigiu:

- **O `\AtEndDocument` precisa de um `\clearpage` antes de gravar os totais.** `\AtEndDocument` roda *antes* do `\clearpage` do `\enddocument`, e float ainda pendente não teve a `\caption` executada — o contador estaria abaixo do total num documento cuja última ilustração foi adiada. Descarregar ali é o mesmo trabalho que o `\enddocument` faria em seguida e não muda a saída.
- **Sem informação no `.aux`, a lista sai.** Primeira passada de documento novo não tem como saber; na dúvida emite-se e a passada seguinte corrige. O latexmk rerroda sozinho porque pular a lista muda a paginação — verificado: converge, e uma segunda chamada já responde "up-to-date", sem oscilação.

**Decisão da tarefa 3.2: os arquivos de partida seguem com as quatro chamadas comentadas.** O que muda é o motivo, e ele está reescrito no comentário ao lado delas. Não é mais para evitar página em branco — a guarda resolveu isso. É para que a primeira compilação de um trabalho recém-copiado não venha com quatro avisos sobre listas que ninguém ainda pediu. Descomentá-las por padrão contradiria a própria justificativa do aviso, que é "toda chamada presente foi escrita por alguém", e ensinaria o autor a ignorar aviso deste pacote logo no primeiro contato — caro num modelo cujos outros avisos importam, como o de fonte ausente.

Verificação, lendo as páginas:

- Documento com um capítulo e nenhuma ilustração, chamando as quatro listas: uma página só, nenhum título de lista, e os quatro avisos no log, um por lista.
- O mesmo documento com uma figura, um gráfico, um quadro e uma tabela: as quatro listas saem, cada uma com a sua entrada e o número de página certo, e **zero** avisos.
- `manual.tex`, que tem figuras e tabelas e chama só essas duas listas: saída idêntica à de antes da change, conferida por comparação do texto extraído contra a compilação do commit anterior. Os seis arquivos de partida mantêm a paginação.

Nota de sequência: o texto do manual e o comentário dos esqueletos dizem, por ora, que os glossários **ainda não** têm essa guarda — o que é verdade neste commit. `fix-glossary-build`, a próxima change desta série, atualiza os dois quando passar a valer o mesmo critério, e é lá que a tarefa 4.2 de alinhar o texto dos dois avisos se resolve.
