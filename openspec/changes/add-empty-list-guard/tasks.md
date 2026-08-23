## 1. A guarda

- [ ] 1.1 Registrar, no fim do documento, se houve item de cada tipo, gravando a informação no `.aux`. O teste é `\value{<contador>}`: `\counterwithout{figure}{chapter}` e `{table}` (`:455-456`) e `within=none` (`:1131`) garantem que nenhum dos quatro contadores zera, então o valor no fim do documento é o total.

  **Não** ler o arquivo auxiliar para decidir. Ver `design.md` §2 e a alternativa descartada: um documento com um capítulo e nenhuma figura já tem `.lof` de 20 bytes, com o `\addvspace` que o `book.cls` grava por capítulo.
- [ ] 1.2 Envolver com a guarda, em `\listoffigures` (`:1605`) e `\listoftables` (`:1615`), **só** o `\cleardoublepage`, o `\thispagestyle`, o título e o `\clearpage` final. O `\@starttoc` fica **fora** da guarda, sempre executado.

  Pular o `\@starttoc` fecha o stream de escrita e tranca a lista desligada para sempre — medido em `design.md`, alternativa descartada. E não é preciso: sozinho, sobre auxiliar sem `\contentsline`, ele não custa página.
- [ ] 1.3 Emitir `\PackageWarning` nomeando a lista pulada.
- [ ] 1.4 Dar à guarda o contador certo em cada tipo gerado, com `\PrepareListOf{<tipo>}{...}` dentro de `\novotipoilustracao` (`:1131`). `figure` e `table` ficam como padrão nos dois `\renewcommand`.

  Uma guarda só cobre as quatro listas: `\listofquadros` e `\listofgraficos` delegam a `\listoffigures`. Ver `design.md` §3 — **não** reimplementar as duas.

## 2. Verificar lendo a página

- [ ] 2.1 Documento com um capítulo e nenhuma figura, chamando `\listoffigures`: nenhuma página, nenhum título, nenhuma entrada de sumário, e o aviso no log.
- [ ] 2.2 O mesmo documento com uma figura: a lista sai, com a entrada certa. Confirmar que **duas** passadas bastam e que o latexmk converge — a guarda muda a contagem de páginas entre passadas, e é aí que oscilação apareceria.
- [ ] 2.3 Repetir 2.1 e 2.2 para `\listoftables`, `\listofquadros` e `\listofgraficos`. As duas últimas são o teste de que a tarefa 1.4 funcionou.
- [ ] 2.4 Compilar `manual.tex`, que tem figuras, tabelas e nenhum quadro nem gráfico. As duas listas chamadas continuam saindo; as duas comentadas continuam sem sair. Nenhuma mudança de saída onde há itens.

## 3. Documentação

- [ ] 3.1 Documentar no manual que lista sem item não é emitida e que o log avisa. O capítulo 6 já fala de página órfã de glossário; alinhar os dois textos, porque a regra passa a ser a mesma.
- [ ] 3.2 Decidir se os seis arquivos de partida passam a trazer as quatro chamadas **descomentadas**. O comentário existia como proteção; com a guarda, vira cortesia. Descomentar é o que faz o autor descobrir a lista quando ela passa a ter conteúdo — sem a guarda, seria o que lhe entregava a página em branco.

  A decisão é desta change agora que a guarda existe; a proposta a deixava para outra por não saber se haveria aviso.

## 4. Ao arquivar

- [ ] 4.1 Sincronizar o delta de `illustration-types` e resolver onde `\listoftables` (§4.2.1.10) fica governado — hoje nenhuma capability a cobre.
- [ ] 4.2 Conferir que o texto do aviso coincide com o de `fix-glossary-build`. Quem entrar primeiro fixa o molde.
