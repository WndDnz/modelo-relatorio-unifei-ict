## Why

`\listoffigures`, `\listoftables` e as listas geradas por `\novotipoilustracao` — `\listofquadros`, `\listofgraficos` — imprimem o título e chamam `\@starttoc` sem verificar se há o que listar (`UnifeiICTReport.sty:1605–1622`, e o bloco reaproveitado em `:1116`). Sem uma ilustração sequer, sai uma página com "LISTA DE ILUSTRAÇÕES" no alto e nada abaixo.

A NBR 14724:2024 trata a lista de ilustrações (§4.2.1.9) e a lista de tabelas (§4.2.1.10) como elementos **opcionais**, elaborados conforme a ordem em que os itens aparecem no texto. Uma página de título sem itens não é uma lista curta: é um elemento que não deveria ter sido emitido.

O defeito compila limpo — é o modo de falha característico deste repositório. Quem o encontra é o autor que abre o PDF pela primeira vez, e a essa altura ele não tem como saber se a culpa é dele ou do modelo.

`add-type-skeletons` contornou isso por comentário: os seis arquivos de partida trazem as quatro chamadas comentadas, com a explicação ao lado. O contorno protege quem começa de um esqueleto e **não protege ninguém mais** — em particular o autor de um trabalho real que ainda não inseriu ilustrações, ou que as retirou na revisão final.

## What Changes

Guarda de lista vazia nas quatro chamadas: quando o arquivo auxiliar correspondente (`.lof`, `.lot`, o do tipo) não tem entrada alguma, a lista não é emitida — nem título, nem página, nem entrada no sumário.

A decidir no design, e não aqui:

- **Silêncio ou aviso.** Não emitir e calar corre o risco oposto: o autor que esperava a lista não descobre por que ela sumiu. Um `\PackageWarning` nomeando a lista pulada parece o meio-termo certo, mas é decisão do design.
- **Onde a guarda mora.** As quatro listas compartilham o bloco de estilo (`:1116`); a guarda deve ser escrita uma vez, no mesmo lugar, e não copiada quatro vezes.
- **Como detectar a lista vazia.** O `.lof` só existe depois da primeira passada, e a decisão precisa sobreviver ao ciclo de compilação do latexmk sem oscilar entre passadas.

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
