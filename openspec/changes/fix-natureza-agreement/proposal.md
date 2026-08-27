## Why

A natureza dos três tipos de monografia é montada assim (`UnifeiICTReport.sty:851-855`, folha de
rosto, e `:1732-1736`, folha de aprovação):

```latex
\ifdefstring{\Unifei@doctype}{tcc2}{Trabalho de Conclusão de Curso}{%
    \ifdefstring{\Unifei@doctype}{dissertacao}{Dissertação}{Tese}%
}%
\ apresentada como requisito parcial para obtenção do título de
```

O substantivo varia por tipo; o particípio não. "Apresentada" concorda com *Dissertação* e com
*Tese*, e discorda de *Trabalho de Conclusão de Curso*, que é masculino. Todo TCC2 gerado por este
modelo sai com "Trabalho de Conclusão de Curso apresentada", na folha de rosto **e** na folha de
aprovação — as duas páginas que a secretaria confere.

Foi encontrado lendo a página 2 de `modelo-tcc2.pdf` durante o arquivamento de
`fix-quote-line-spacing`, cuja tarefa 4.2 mandava medir o espacejamento da natureza. O
espacejamento estava certo; a concordância, não.

O TCC2 é, de longe, o tipo mais usado no ICT. O defeito é de um adjetivo, e aparece em cem por
cento dos documentos do tipo mais comum.

## What Changes

O particípio passa a acompanhar o substantivo, nos dois pontos de emissão.

A implementação provável é uma macro por tipo que carregue substantivo e particípio juntos, para
que os dois não voltem a divergir — hoje eles estão em linhas diferentes do mesmo bloco, que é
exatamente como divergiram. Os tipos que não são monografia ficam como estão: em `estagio`, `generico` e
`tcc1` o substantivo e o particípio já estão na mesma cadeia literal — "Relatório de estágio
supervisionado apresentado", "Projeto de pesquisa apresentado" — e não têm como divergir. Estão
certos por construção, e é essa construção que falta à monografia (`design.md` D1 registra a
correção: a primeira versão desta proposal dizia "por coincidência de gênero", e estava errada).

## Capabilities

### Modified Capabilities

- `document-type`: é a dona da natureza, que o seu `Purpose` já nomeia como um dos elementos que o
  tipo governa. O requisito dos três tipos de monografia — que hoje os separa por grau
  pretendido e área de concentração — ganha a exigência de que o texto da natureza concorde com o
  nome que o tipo determina.

## Fora de escopo

- **A flexão de gênero dos rótulos de papel**, que é de `add-role-label-gender`. Ali o gênero é o
  de uma pessoa e precisa ser declarado; aqui é o do substantivo que o próprio modelo escolheu, e é
  determinado pelo tipo.

## Impact

- `UnifeiICTReport.sty`, em dois pontos: a natureza da folha de rosto e a da folha de aprovação.
- Nenhum arquivo de autor muda, e nenhum comando público muda — é correção de texto gerado.
- A verificação é ler a folha de rosto e a folha de aprovação de `modelo-tcc2`, e confirmar que as
  de `modelo-dissertacao` e `modelo-tese` não regrediram.
