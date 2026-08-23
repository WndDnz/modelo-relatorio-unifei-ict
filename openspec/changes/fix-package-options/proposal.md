## Why

O pacote declara quatro opções. Uma funciona. Das outras três, duas não fazem nada e a terceira quebra a compilação.

**`neverindent` interrompe o build.** A linha 18 executa `\@neverindenttrue`, e não existe `\newif\if@neverindent` em lugar algum do arquivo:

```
UnifeiICTReport.sty:18
  \DeclareOption{neverindent}{\@neverindenttrue}
```

Verificado: `\usepackage[tipo=generico,neverindent]{UnifeiICTReport}` para com `! Undefined control sequence. \ds@neverindent ->\@neverindenttrue`, no `\ProcessOptions` da linha 133. Quem passar a opção não recebe um aviso — recebe um documento que não compila.

**`roman` e `sans` não fazem nada.** As duas alternam a flag `\if@roman` (`:21–23`), e essa flag **nunca é consultada**: as três ocorrências no arquivo são a declaração e as duas opções que a acionam. A escolha de família tipográfica é decidida em outro lugar, por `\if@unifei@sansset` (`:620`), que não tem relação com elas.

Verificado por compilação: `[tipo=generico,roman]` e `[tipo=generico,sans]` produzem texto idêntico ao do documento sem opção alguma, e embutem exatamente o mesmo conjunto de fontes — Exo2 Regular e Bold, Heuristica Regular e Bold, nos três casos.

O defeito veio à tona ao fechar a tarefa 6.1 de `rewrite-usage-guide`, que exige documentar todo comando público: as três opções não são citadas no README, no manual nem nos arquivos de partida, e a razão de não serem é agora clara. Não há o que documentar. Uma opção que existe, é aceita pelo `\DeclareOption` e não faz nada é pior que uma opção ausente: quem a encontrar no `.sty` vai usá-la e concluir que o efeito prometido é sutil demais para notar.

## What Changes

As três opções passam a ter comportamento definido, e o destino não é o mesmo para as três: `roman` e `sans` passam a fazer o que o nome promete; `neverindent` deixa de ser declarada. Ver `design.md`.

A decidir no design, e não aqui:

- ~~**Implementar ou remover.**~~ Decidido: `roman`/`sans` implementadas, `neverindent` removida. O `design.md` traz o critério e a evidência normativa.
- **Como a inversão de legenda se amarra à flag.** Hoje `:466` fixa `labelfont={bf,sf},textfont={sf}` literalmente, sem consultar `\if@roman`. Passar a consultá-la é o núcleo da implementação, e a forma — condicional no `\captionsetup`, ou dois `\captionsetup` sob `\if` — fica para o design detalhado.
- **Se removidas, como falhar.** A previsão que estava aqui — opção não declarada vira idioma, e quem passa `sans` recebe um erro de babel confuso — **não se confirma**, porque há um terceiro sítio. O detector de idioma mantém uma lista de exclusão com os três nomes:

  ```
  :253  \edef\@skipA{roman}\edef\@skipB{sans}\edef\@skipC{neverindent}%
  ```

  Removidos os `\DeclareOption` e deixada essa lista, as três continuam engolidas em silêncio, tão silenciosamente quanto hoje — nem efeito, nem erro. Os três sítios têm de cair juntos, e a decisão continua de pé na forma certa: se removidas, um `\DeclareOption` que emite `\PackageError` nomeando a remoção é mais honesto que qualquer silêncio.
- ~~**Se implementadas, qual é a saída certa.**~~ Resolvido para `neverindent` pela via oposta: nenhum elemento das normas pede supressão de recuo de primeira linha, então não há saída certa a implementar. Ver `design.md`.

## Capabilities

### Added Capabilities

- `package-options`: as opções de carregamento do pacote não têm capability. `document-type` governa o `tipo=`, que é a única que funciona, e é o precedente do que se espera das demais: valor inválido para com erro do próprio pacote, nomeando os valores aceitos.

## Fora de escopo

- **`tipo=`**, que funciona e é de `document-type`.
- **O mecanismo de fontes** (`:492`, `:620`), que está correto e faz o *fallback* prometido.
- **O manual.** Enquanto as três opções não tiverem comportamento definido, documentá-las é documentar um defeito. `rewrite-usage-guide` fecha a tarefa 6.1 apontando para esta change, e não escrevendo prosa sobre elas.

## Impact

- `UnifeiICTReport.sty`, nas linhas 18, 21–23 e 253 — esta última é a lista de exclusão do detector de idioma, que nomeia as três e sem a qual a remoção não é remoção.
- Nenhum documento deste repositório passa qualquer uma das três, então nada em uso muda de saída.
- Documento de terceiro que passe `roman` ou `sans` hoje compila e ignora a opção; depois desta change obtém o efeito. Quem passar `neverindent` obtém um erro que explica, em vez do `! Undefined control sequence` de hoje.
- `:466` deixa de ser literal: a família da legenda passa a derivar da família do corpo.
