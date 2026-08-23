## Why

`\listoffigures`, `\listoftables` e as listas geradas por `\novotipoilustracao` — `\listofquadros`, `\listofgraficos` — imprimem o título e chamam `\@starttoc` sem verificar se há o que listar (`UnifeiICTReport.sty:1605–1622`, e o bloco reaproveitado em `:1116`). Sem uma ilustração sequer, sai uma página com "LISTA DE ILUSTRAÇÕES" no alto e nada abaixo.

A NBR 14724:2024 trata a lista de ilustrações (§4.2.1.9) e a lista de tabelas (§4.2.1.10) como elementos **opcionais**, elaborados conforme a ordem em que os itens aparecem no texto. Uma página de título sem itens não é uma lista curta: é um elemento que não deveria ter sido emitido.

O defeito compila limpo — é o modo de falha característico deste repositório. Quem o encontra é o autor que abre o PDF pela primeira vez, e a essa altura ele não tem como saber se a culpa é dele ou do modelo.

`add-type-skeletons` contornou isso por comentário: os seis arquivos de partida trazem as quatro chamadas comentadas, com a explicação ao lado. O contorno protege quem começa de um esqueleto e **não protege ninguém mais** — em particular o autor de um trabalho real que ainda não inseriu ilustrações, ou que as retirou na revisão final.

## What Changes

Guarda de lista vazia nas quatro chamadas: quando o documento não tem item algum daquele tipo, a lista não é emitida — nem título, nem página, nem entrada no sumário.

Três das decisões que esta seção adiava ao design foram fechadas por medição, em documentos de teste isolados. Ficam registradas aqui porque não são preferência, são o que a máquina faz:

- **A guarda não pode pular o `\@starttoc`.** Ele faz duas coisas: dá `\@input` no auxiliar da rodada anterior *e* abre o stream de escrita (`\tf@lof`) que alimenta a rodada seguinte. `\addcontentsline` descarta em silêncio quando o stream não está aberto. Medido, em documento que **tem** uma figura: sem `\@starttoc`, o `.lof` continua ausente depois da primeira e da segunda passada; com ele, sai com 94 bytes já na primeira. A guarda ingênua trava a lista desligada para sempre.
- **E não precisa pular.** `\@starttoc` sozinho, sobre um auxiliar sem `\contentsline`, não custa página nenhuma: o mesmo documento sai com uma página com a chamada e uma página sem ela. O custo inteiro está no `\cleardoublepage` e no título, que o modelo emite antes e sem condição. A guarda envolve esses; o `\@starttoc` fica fora dela.
- **"Arquivo vazio" nunca é verdade.** O `book.cls` escreve um `\addvspace {10\p@ }` no `.lof` por capítulo. Um documento com um capítulo e nenhuma figura já tem `.lof` de 20 bytes; com uma figura, tem os mesmos 20 mais a linha de `\contentsline`. Testar emptiness dá falso positivo em qualquer documento com uma divisão sequer, e o teste correto por arquivo exigiria procurar `\contentsline` — parsing. Sai mais barato pelo contador: `\counterwithout{figure}{chapter}` e `{table}` (`:455-456`) e `within=none` nos tipos gerados (`:1131`) garantem que **nenhum dos quatro contadores zera**, então `\value{...}` no fim do documento é o total, o mesmo teste serve aos quatro sem caso especial, e a flag vai no `.aux`, que o latexmk já rerroda sozinho.

A decidir no design, e não aqui:

- **Silêncio ou aviso.** Não emitir e calar corre o risco oposto: o autor que esperava a lista não descobre por que ela sumiu. Um `\PackageWarning` nomeando a lista pulada parece o meio-termo certo, mas é decisão do design.
- ~~**Onde a guarda mora.**~~ Resolvido, e por leitura do `newfloat`, não por decisão. Duas premissas caíram no caminho. A primeira, que estava na proposta original: as quatro listas **não** compartilham o bloco de estilo em `:1116` — essa é linha de comentário, dentro do bloco de documentação de `\novotipoilustracao`. A segunda, que eu próprio escrevi ao derrubar a primeira: que seriam dois mecanismos independentes, e que uma guarda cobriria só metade. Também falsa.

  `\listofquadros` expande para `\@nameuse{listofquadro}`, e `newfloat@list@of@` (`newfloat.sty:138-148`) faz, dentro de um grupo: troca `\listfigurename` pelo nome do tipo, redireciona `\@starttoc` para a extensão do tipo, roda o gancho `newfloat@listof<tipo>@hook` — e então **chama `\listoffigures`**, que é o `\renewcommand` do modelo.

  Ou seja: as quatro listas passam pelo mesmo código, e a guarda escrita uma vez em `:1605` cobre todas. O que elas precisam é saber qual contador testar, e o `newfloat` expõe `\PrepareListOf{<tipo>}{<código>}` exatamente para isso. Ver `design.md` §3.
- **`$aux_dir = 'build'`.** Os auxiliares não ficam ao lado do `.tex`. Se a detecção fosse por leitura de arquivo, o `\openin` teria de resolver o caminho da pasta de saída — risco que a detecção por contador não corre. É um argumento a mais pelo contador, e vale confirmá-lo antes de fechar o design.

## Capabilities

### Modified Capabilities

- `illustration-types`: hospeda a lista por tipo (§4.2.1.9) e é a candidata natural. `\listoftables` (§4.2.1.10) hoje não tem capability que a governe — resolver ao desenhar, sem criar capability nova só para uma linha.

## Fora de escopo

- **Os arquivos de partida.** Continuam com as chamadas comentadas depois desta change; o comentário passa a ser cortesia e deixa de ser proteção. Se valerá descomentá-los é decisão de outra change, e depende de a guarda emitir aviso ou não.
- **`\tableofcontents`**, que nunca está vazio num documento com uma divisão sequer.
- **Os glossários**. A investigação foi feita: não falta guarda, falta o passo de compilação — o `makeglossaries` nunca roda, e os dois `\printglossary` do manual produzem uma página inteiramente em branco. Registrado como `fix-glossary-build`.

## Impact

- `UnifeiICTReport.sty`, no bloco das listas.
- Nenhum documento existente muda de saída, **exceto** os que hoje emitem página de título vazia — que é o defeito.
- Dívida registrada por `add-type-skeletons`, tarefa 4.2.
