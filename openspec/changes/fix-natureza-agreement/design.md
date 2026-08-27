## Contexto

A natureza dos três tipos de monografia monta o substantivo e o particípio em linhas separadas do
mesmo bloco (`UnifeiICTReport.sty:851-855`, folha de rosto, e `:1732-1736`, folha de aprovação):

```latex
\ifdefstring{\Unifei@doctype}{tcc2}{Trabalho de Conclusão de Curso}{%
    \ifdefstring{\Unifei@doctype}{dissertacao}{Dissertação}{Tese}%
}%
\ apresentada como requisito parcial para obtenção do título de
```

O substantivo varia; o particípio é feminino fixo. Todo TCC2 sai com "Trabalho de Conclusão de Curso
apresentada", nas duas páginas.

**O defeito não está no particípio errado, está na separação.** Substantivo e particípio são uma
concordância só e estão em linhas diferentes, onde nada obriga um a acompanhar o outro. Corrigir a
palavra deixa a estrutura que a produziu.

E a estrutura é pior do que parece. O texto da natureza existe **em dois lugares**, copiado
literalmente entre `\Unifei@NaturezaFolhaRosto` (`:836-857`) e `\Unifei@FolhaAprovacaoCorpo`
(`:1676-1741`) — três textos cada, seis cópias ao todo. Conferido: hoje são idênticos, palavra por
palavra. O comentário que abre o primeiro (`:834-835`) diz:

> Mesmo texto que a folha de aprovação usa, mantido em um só lugar para os dois não divergirem com
> o tempo.

**Isso é falso.** Não está em um só lugar, e é justamente por isso que o defeito precisou ser
corrigido em dois. Um comentário que descreve uma garantia inexistente é pior que comentário
nenhum: a próxima pessoa a mexer aqui vai confiar nele.

### D1 — correção ao `proposal.md`

A proposal afirma que os tipos não-monografia "estão certos por coincidência de gênero, não por
construção". Está errado, e a medição desfaz: nos textos de `estagio`, `generico` e `tcc1` o
substantivo e o particípio estão na **mesma cadeia literal** — "Relatório de estágio supervisionado
apresentado", "Projeto de pesquisa apresentado". Não há como divergirem. Estão certos por
construção, e é exatamente a construção que falta à monografia. Não há o que fazer neles.

## Decisões

### 1. Um macro por tipo, com o substantivo e o particípio juntos

`\Unifei@trabalhoapresentado`, definido no bloco de despacho do tipo (`:203-256`), ao lado de
`\Unifei@grau` e `\Unifei@papel`, que já são exatamente isto — texto que o tipo determina, resolvido
uma vez, no lugar onde o tipo é lido:

```latex
\def\Unifei@trabalhoapresentado{Trabalho de Conclusão de Curso apresentado}  % tcc2
\def\Unifei@trabalhoapresentado{Dissertação apresentada}                     % dissertacao
\def\Unifei@trabalhoapresentado{Tese apresentada}                            % tese
```

O ponto é que a concordância deixa de ser possível de quebrar: as duas palavras estão na mesma
cadeia, como já estão nos outros três tipos. Não é uma tabela de gênero, não é um `\if` a mais —
é uma cadeia literal por tipo, que é o que o resto do bloco já faz.

Entra também na lista de macros documentadas do cabeçalho (`:160-172`), que hoje descreve
`\Unifei@grau`, `\Unifei@papel` e `\Unifei@papelplural`.

### 2. A folha de aprovação passa a chamar o texto, em vez de reescrevê-lo

`\Unifei@NaturezaFolhaRosto` é renomeado para `\Unifei@Natureza` — ele deixa de ser da folha de
rosto quando as duas o usarem — e `\Unifei@FolhaAprovacaoCorpo` passa a chamá-lo.

O macro já seleciona o texto pelo tipo internamente, com os mesmos `\if@unifei@relatorio` /
`\if@unifei@projeto` / `\if@unifei@monografia` que a folha de aprovação usa para escolher os blocos
de registro. Chamado uma vez logo após o cabeçalho, resolve os três casos:

```latex
\Unifei@FolhaAprovacaoCabecalho
\Unifei@FolhaAprovacaoNatureza{\Unifei@Natureza}
\if@unifei@relatorio ... \fi   % só os blocos de registro
```

Hoje cada um dos três ramos emite natureza, `\vfill`, registros, `\vfill`. Içar a natureza para
antes dos ramos produz a mesma sequência de tokens, e some com as três cópias.

**Esta decisão é o que torna a change pequena.** Sem ela a correção é feita em dois lugares e a
próxima também será.

O comentário D4 do `tcc1` (`:1717-1718`), que marca o desvio de declarar grau contra o §4.2.1.1(e)
da 15287, acompanha o texto para o macro compartilhado. Ele é sobre o texto, não sobre a página.

### 3. O comentário falso é corrigido, não apagado

Depois da decisão 2 ele passa a ser verdadeiro, e vale dizer o que passou a garantir e desde
quando. Um comentário que já foi mentira uma vez merece a nota de por que agora não é.

### 4. Os três textos não-monografia não são tocados

Ver D1. Estão certos por construção. Uniformizá-los para "usar o macro também" trocaria três cadeias
corretas por três indireções, sem mudar uma vírgula da saída.

## Alternativas descartadas

- **Trocar `apresentada` por `apresentado` e parar aí.** É o sintoma. Deixa as duas palavras
  separadas, deixa as seis cópias, e obriga a corrigir nos dois sítios — que é como o defeito
  nasceu.
- **Dois macros, `\Unifei@nometrabalho` e `\Unifei@participio`.** Reproduz a separação que causou o
  defeito, com nomes melhores. Duas macros podem divergir; uma cadeia não.
- **Um mecanismo de gênero que flexione o particípio a partir do substantivo.** É `add-role-label-gender`
  aplicado ao lugar errado. Lá o gênero é de uma pessoa, não é derivável e precisa ser declarado.
  Aqui há três valores possíveis, todos conhecidos em tempo de pacote, e a cadeia literal os
  resolve sem mecanismo algum.
- **Reescrever o TCC2 como "Monografia apresentada", para casar com o particípio existente.**
  Descartada: mudaria o nome que o ICT usa para o trabalho, na página que a secretaria confere, para
  poupar uma linha de código.
- **Deduplicar a natureza numa change à parte, e aqui só corrigir a palavra.** Descartada: a
  deduplicação é menor que a correção em dois sítios, e é ela que impede a reincidência. Separá-las
  entregaria primeiro o pedaço que não resolve nada.
