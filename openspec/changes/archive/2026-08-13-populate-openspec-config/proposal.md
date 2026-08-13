## Why

`openspec/config.yaml` está inteiramente comentado: sete changes já foram propostas, implementadas e arquivadas sem que `context:` ou `rules:` tenham sido preenchidos uma única vez. O arquivo é o mecanismo pelo qual o projeto informa quem redige os artefatos — e ele nunca informou nada.

O custo disso é visível no histórico. As mesmas coisas foram redescobertas a cada change:

- **Qual norma rege.** Seis normas ABNT diferentes governam partes distintas do modelo (14724, 15287, 6023, 10520, 6027, 6034). Mais de uma change atribuiu comportamento à norma errada — a change `fix-guide-errors`, irmã desta, existe porque o guia atribui as citações em texto à NBR 6023, que rege referências.
- **Compilação limpa não prova saída correta.** É o modo de falha recorrente do projeto, e o mais caro: `\LaTeX\,` engole a vírgula, `--` não vira travessão sob XeLaTeX, código não-expansível dentro de `\the<contador>` corrompe o `.aux`. Nada disso emite aviso. Toda vez, a verificação por rasterização do PDF teve de ser reargumentada em vez de ser pressuposta.
- **O idioma dos artefatos.** Mudou para português em 2026-08-10; seis specs em inglês ainda aguardam migração. Sem registro, cada change nova precisa inferir o idioma do que está ao redor.
- **Desvios deliberados da norma.** A change `add-document-types` registrou D1–D4 em `design.md` e espelhou cada um em comentário no `.sty`, exatamente para que ninguém "corrija" depois o que está errado de propósito. Essa prática é boa e não está escrita em lugar nenhum — sobrevive por memória.

Nada disso é dedutível do código, e é justamente o que `context:` e `rules:` existem para carregar.

## What Changes

- `context:` passa a declarar: o que o projeto é (modelo LaTeX/XeLaTeX ABNT do ICT/Unifei, servindo seis tipos de documento), as normas que o regem e o que cada uma cobre, o idioma dos artefatos, a ausência do CLI `openspec` nesta máquina, e a regra de que os PDFs das normas em `.refs/` **nunca** são versionados — são normas pagas, com marca d'água de terceiro, num repositório público.
- `rules.proposal:` passa a exigir que a proposta nomeie a norma que rege o comportamento em questão, e que registre desvios deliberados em vez de os deixar implícitos.
- `rules.design:` passa a exigir que cada desvio seja numerado (D1, D2, …), com o texto da norma citado, e espelhado em comentário no ponto correspondente do `.sty`.
- `rules.tasks:` passa a exigir que toda tarefa que altera a saída do documento carregue sua própria verificação, e que a verificação **leia a página compilada** — não o log.
- `operations.apply:` e `operations.archive:` ganham a orientação de conduzir o fluxo à mão, sem o CLI, e de conferir renomes de requisito pela posição.

## Capabilities

Nenhuma. `config.yaml` configura o fluxo de trabalho; não descreve comportamento do modelo.

## Impact

- `openspec/config.yaml`, que hoje é só boilerplate comentado.
- Efeito sobre toda change futura: o conteúdo é injetado na redação dos artefatos. As três changes já em fila (`fix-guide-errors`, a reescrita do manual, `cover-and-title`) se beneficiam se esta for aplicada antes delas — daí ela vir cedo na ordem.
- Sem efeito sobre qualquer arquivo `.tex`, `.sty` ou `.bib`.
