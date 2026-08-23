## Why

`UnifeiICTReport.sty:790-801` define seis metadados de instituição, cada um com padrão embutido:

    \institution    Universidade Federal de Itajubá
    \faculty        Instituto de Ciências Tecnológicas
    \course         Engenharia de Computação
    \location       Itabira
    \state          Minas Gerais
    \stateacronym   MG

Nenhum dos seis é declarado por nenhum dos seis arquivos de partida, nem mencionado no README, nem no guia. O autor não tem como saber que existem.

Cinco dos padrões estão certos — o ICT é o campus de Itabira da Unifei. `\course` não: "Engenharia de Computação" é um curso entre vários do instituto. A NBR 14724:2024 §4.2.1.1.1 lista o nome da instituição entre os elementos da capa, e o modelo a imprime a partir desses comandos.

**É o padrão certo que esconde o defeito.** Uma capa com o curso errado é plausível para qualquer leitor e correta só para parte deles; nada falha, nada avisa. Lido da página 1 de `build/modelo-tese.pdf`, que não declara metadado de instituição algum:

    UNIVERSIDADE FEDERAL DE ITAJUBÁ
    Seu Nome Completo
    TÍTULO DA SUA TESE
    ITABIRA 2026

O tipo de defeito é o característico deste repositório — compila limpo, sai plausível, e quem descobre é a banca.

## What Changes

Nos seis arquivos de partida:

- `\course` passa a vir **declarado e preenchido com valor de exemplo**, como os demais metadados que o autor precisa trocar;
- `\institution`, `\faculty`, `\location`, `\state` e `\stateacronym` vêm **comentados com o padrão ao lado**, para que o autor de outro campus ou de outra instituição saiba que pode trocá-los, e o do ICT saiba que não precisa.

O critério que separa os dois grupos é o que o padrão faz com o autor típico: `\course` está errado para a maioria, os outros estão certos para todos os que este modelo atende.

**`\stateacronym` estava morto, e esta change o liga.** Estava declarado em `:800-801` e **não era impresso em lugar nenhum** — nem na capa, nem na folha de rosto, nem na data; a única coisa que usava o estado era `:1317`, com `\@state` por extenso. O manual já o documentava, em `Capitulos/cap3/cap3.tex:57`, com "Sigla do estado. Padrão: MG": o modelo prometia um botão desligado, e a promessa estava publicada.

Passa a ser impresso na **capa**, ao lado da cidade; a folha de rosto continua com o estado por extenso. Ver `design.md`. Isso o devolve ao grupo dos cinco comentados com o padrão ao lado — comentá-lo deixa de ser instruir o autor a mexer em botão morto.

## Capabilities

### Modified Capabilities

- `usage-guide`: o requisito dos arquivos de partida ganha o caso do metadado que tem padrão embutido. Hoje ele fala de metadado **exigido** e de metadado **opcional**; um metadado com padrão não é nem um nem outro — não falha quando ausente, e por isso escapa da regra.

## Fora de escopo

- **Documentar os seis no manual.** É a tarefa 3.2 de `rewrite-usage-guide`, já emendada para incluí-los. Esta change trata do ponto de partida; aquela, do porquê.
- **Mudar os padrões do `.sty`.** Estão certos para o ICT, que é quem este modelo atende. Trocar `\course` por vazio faria a capa sair incompleta em vez de errada, o que é outra decisão e outra change.
- **O `manual.tex`.** Ele demonstra, não parte de lugar nenhum.

## Impact

- Os seis `modelo-<tipo>.tex`. Nenhuma alteração em `UnifeiICTReport.sty`.
- A **folha de rosto** dos seis passa a imprimir o curso de exemplo em vez de "Engenharia de Computação" — mudança de saída, a verificar lendo a página, e não o log. A **capa não muda**: `\@course` é impresso só em `:1235`, dentro do bloco da folha de rosto; a capa (`:1201-1213`) imprime apenas `\@institution` e `\@location`. O mesmo vale para `\@faculty`, que só aparece em `:1233`.
