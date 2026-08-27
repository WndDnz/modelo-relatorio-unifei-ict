## Why

O manual compila com `exit 0`, sem um aviso sequer, e a página 8 do PDF sai **inteiramente em branco** — onde deveriam estar a lista de abreviaturas e siglas (NBR 14724:2024 §4.2.1.7) e a lista de símbolos (§4.2.1.8).

A causa não é o pacote `glossaries` nem o `.sty`. É o `.latexmkrc`, que não configura regra alguma para o `makeglossaries`:

```
$pdf_mode = 5;
$xelatex = 'xelatex ... %O %S';
$out_dir = 'build';
$aux_dir = 'build';
$clean_ext = 'bbl run.xml synctex.gz';
```

O XeLaTeX faz a sua parte: `build/manual.acn` e `build/manual.slo` existem e trazem entradas reais — CTAN, MMC, \ensuremath{\pi}. Falta o passo que as transforma em `.acr` e `.sls`, e sem esses dois arquivos cada `\printglossary` não imprime nada: nem os itens, nem o título, nem a entrada de sumário. Uma página em branco, e nenhum rastro.

O defeito é pior que a página órfã que `add-empty-list-guard` trata. Lá sai um título sem itens, e o autor ao menos vê que algo está errado. Aqui não sai nada, e quem escreveu `\gls{ctan}` no texto vê a sigla expandir normalmente na página — o que confirma, falsamente, que o mecanismo está funcionando.

Nos seis arquivos de partida os dois `\printglossary` vêm comentados, então nenhum deles exibe o sintoma hoje. A proteção é acidental: descomentá-los, que é exatamente o que `add-type-skeletons` instrui a fazer quando o trabalho passa a ter siglas, entrega a página em branco.

`add-empty-list-guard` deixou os glossários fora de escopo, dizendo que o mecanismo é do pacote `glossaries` e tem guarda própria a investigar à parte. A investigação está feita, e a resposta é outra: não falta guarda, falta o passo de compilação.

## What Changes

O ciclo de compilação passa a gerar os glossários. O `.latexmkrc` ganha a regra do `makeglossaries` para os três alvos que este modelo usa — o principal (`.glo`→`.gls`), o de siglas (`.acn`→`.acr`) e o de símbolos (`.slo`→`.sls`) — honrando `$aux_dir`, já que os auxiliares não ficam ao lado do `.tex`.

A decidir no design, e não aqui:

- ~~**`makeglossaries` ou `makeglossaries-lite`.**~~ Decidido por evidência: `makeglossaries`. O argumento que estava aqui — que a escolha decidiria se o modelo compila numa instalação mínima, prometida pelo capítulo 2 — era falso nas duas pontas. O capítulo 2 promete o oposto (`cap2.tex:11`: "instalação local completa do LaTeX"), e o `-lite` **recusa a opção `-d`**, sem a qual não se alcança `$aux_dir = 'build'`. Ver `design.md`.
- **Como declarar as três regras sem repetir três vezes.** O `glossaries` nomeia os alvos por convenção; o `.latexmkrc` pode derivá-los ou listá-los.
- **O que fazer quando não há entrada alguma.** Medido, e em duas rodadas — a segunda corrigiu a primeira. Sem `\gls` no texto o `.acn` **é** escrito, vazio; o `makeglossaries` avisa `File is empty` e sai com código 0, de modo que a regra do latexmk não quebra; e o `.acr` resultante tem sete bytes, contendo `\null`. A primeira leitura atribuiu a página em branco a esse `\null`. **Está errado.** Medido no modelo real, com a `.sty` carregada: apagar o `.acr` e o `.sls` não muda a contagem de páginas. Qualquer número de `\printglossary` sem entrada custa **uma** página em branco, sem título e sem número — uma só, não uma por chamada:

  ```
  0 chamadas ............ 2 páginas
  1 chamada  ............ 3 páginas
  2 chamadas ............ 3 páginas
  2 chamadas, sem .acr .. 3 páginas
  ```

  A consequência é de projeto: **nenhuma ação do lado do latexmk remove essa página**, porque ela não vem do arquivo gerado. A guarda tem de ser em LaTeX, em volta do `\printglossary`.

- **A guarda do glossário vazio passa a ser desta change.** `add-empty-list-guard` pôs os glossários fora do seu escopo dizendo que não faltava guarda, faltava o passo de compilação. Está certo sobre o sintoma de hoje e é insuficiente: depois que o passo entrar, a página em branco **continua**, com causa nova — o `\null` de um `.acr` vazio, no lugar do `.acr` ausente. É o defeito de `add-empty-list-guard` num mecanismo que não é o do `.sty`, e hoje nenhuma das duas changes o cobre.
- **`$clean_ext`**, que hoje não lista os auxiliares de glossário e vai deixá-los para trás.

## Capabilities

### Added Capabilities

- `abbreviation-symbol-lists`: a lista de abreviaturas e siglas (§4.2.1.7) e a lista de símbolos (§4.2.1.8) não têm capability que as governe. Esta change cria uma, com o requisito mínimo de que o que o autor declara apareça no PDF.

## Fora de escopo

- **`UnifeiICTReport.sty`**, que está correto: declara os glossários e os imprime como deve.
- **A guarda de lista vazia das ilustrações**, que é de `add-empty-list-guard` e trata `\listoffigures`, `\listoftables` e as listas de `\novotipoilustracao`. O caso análogo dos glossários é desta change, pela razão acima: o mecanismo é do pacote `glossaries`, não do bloco compartilhado em `UnifeiICTReport.sty:1116`, e as duas guardas não podem morar no mesmo lugar.
- **A prosa do manual.** O capítulo 6 hoje avisa que `\printglossary` sem sigla alguma produz página órfã. Depois desta change esse aviso continua correto como comportamento previsto, mas o texto foi escrito sem saber que a causa real era outra; revisá-lo é tarefa desta change, no fim.

## Impact

- `.latexmkrc`.
- `build/manual.pdf` ganha o conteúdo da página 8.
- Documento que declare glossário e não use entrada alguma deixa de gastar uma página em branco numerada por `\printglossary`. Todo documento que descomentar os `\printglossary` passa a imprimir o que declarou.
- Quem compila fora do `latexmk` — direto pelo `xelatex`, ou por um editor com cadeia própria — continua sem os glossários. O manual precisa dizer isso.
