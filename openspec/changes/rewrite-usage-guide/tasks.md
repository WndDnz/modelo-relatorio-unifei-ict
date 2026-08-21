## 0. Antes de começar

- [ ] 0.1 Confirmar que `add-type-skeletons` já foi aplicada. O manual referencia os seis arquivos de partida como exemplo da organização em arquivo único, e a tarefa 5.4 remete a eles quem quiser ver as capas dos outros tipos. Sem eles, essas passagens ficam sem referente.
- [ ] 0.2 Levantar o inventário do que o pacote oferece ao autor, lendo `UnifeiICTReport.sty` — todo comando, ambiente, opção e metadado público, ignorando os prefixados `\Unifei@` e `\@`. Esse inventário é o critério de completude do manual e a evidência da tarefa 6.1. Sem ele, "documentar tudo" não é verificável.

## 1. Reorganização

- [ ] 1.1 Renomear `modelo-relatorio.tex` para `manual.tex`, com `git mv` para preservar histórico. O nome é o que separa o documento que se lê dos seis que se copiam (design.md, decisão 1).
- [ ] 1.2 Criar a árvore dos sete capítulos em `Capitulos/`, substituindo `cap1`/`cap2`/`cap3`. Manter a convenção de uma pasta por capítulo — é ela que o manual apresenta como organização recomendada, então precisa continuar sendo o que o manual de fato faz.
- [ ] 1.3 Mover o conteúdo de ilustrações, tabelas e equações (`cap2` §2.5–2.6) para o capítulo 5 **preservando-o**. É a parte boa do texto atual; mover não é pretexto para refazer. Conferir por diff que só mudaram cabeçalhos de seção e referências cruzadas.
- [ ] 1.4 Distribuir o restante do `cap2` atual: ambiente e organização de arquivos → capítulo 2; divisões, rótulos, `\refcomp`, citações → capítulo 4; abreviaturas, siglas e símbolos → capítulo 6.
- [ ] 1.5 Aposentar o conteúdo fictício de `cap1` e `cap3` — o objetivo geral que declara ser o próprio modelo, a conclusão de um trabalho inexistente. O que ali ensina a **escrever** uma introdução tem lugar: vai para o capítulo 3, junto da estrutura textual do documento.

## 2. Capítulos 1, 2 e 4

- [ ] 2.1 Documentar os seis tipos e como escolher, no capítulo 1: o que cada um é, que norma o rege, e a consequência de escolher errado. NBR 14724:2024 para `generico`, `estagio`, `tcc2`, `dissertacao` e `tese`; NBR 15287:2025 para `tcc1`.
- [ ] 2.2 No capítulo 1, dizer qual arquivo de partida copiar para cada tipo, e que o manual não é para ser copiado. É a primeira coisa que um leitor novo precisa saber.
- [ ] 2.3 No capítulo 2, apresentar as duas formas de organizar os arquivos apontando para os artefatos reais: este manual, organizado em `Capitulos/` com `\subimport`, e os arquivos de partida, completos em um arquivo só. Demonstrar por existência, não por descrição.
- [ ] 2.4 Explicar o **rebaixamento de níveis** de forma destacada, no capítulo 4: internamente o modelo segue o padrão da classe `book` e o autor escreve `\chapter`, `\section`, `\subsection`, `\subsubsection`; na saída, cada um sai um degrau abaixo — Seção, Subseção, Subsubseção, Parágrafo — porque a NBR 14724:2024 §4.2.2 não admite a divisão do trabalho em capítulos. Dizer as duas coisas juntas: **o comando que se digita** e **o nome que se imprime**. O bloco corrigido em `fix-guide-errors` já faz isso bem e serve de base. CRÍTICO: é a maior distância entre o que o autor escreve e o que ele lê no PDF, e a única em todo o modelo que exige tradução mental.
- [ ] 2.5 Deixar claro, na mesma passagem, que o rebaixamento **não é desvio da norma**: é como o modelo a cumpre usando uma classe que fala outro vocabulário. Distinguir dos desvios deliberados D1–D4, que são outra coisa — sem isso o leitor conclui que o modelo diverge onde ele obedece.

## 3. Capítulo 3, que é onde está a dívida

- [ ] 3.1 Documentar a ordem dos elementos pré-textuais e a divisão `\frontmatter` / `\mainmatter` / `\backmatter`.
- [ ] 3.2 Documentar capa e folha de rosto: título, subtítulo (escrito **sem** os dois-pontos, que o modelo insere), múltiplos autores, múltiplos professores em `\supervisor`, coorientador, e o rótulo do papel que deriva do tipo.
- [ ] 3.3 Documentar a folha de aprovação: `\folhaaprovacao` sem argumento, a composição por tipo, `\bancamembro` só para os membros externos (o orientador já entra por `\supervisor`), `\aprovacaodata`, `\notaaprovacao`, e o fato de ela não ser emitida no `tcc1` sem banca.
- [ ] 3.4 Declarar, ao documentar a folha, que a **ausência de linhas de assinatura é deliberada** — desvio D1, registrado em `add-document-types`. É o desvio mais visível ao leitor, e sem a explicação ele parece defeito e alguém "conserta".
- [ ] 3.5 Documentar `\areaconcentracao` e `\linhapesquisa`, com a obrigatoriedade que varia por tipo e a mensagem de erro que o modelo emite quando a área falta em `dissertacao` ou `tese`.
- [ ] 3.6 Documentar os resumos: `\abstract`, `\keywords`, `\abstractseclang`, `\keywordsseclang`, `\makeabstracts`. O abstract é obrigatório nos **três** tipos de monografia — `tcc2` inclusive, desde `require-abstract-tcc2` — e opcional nos demais; o `tcc1` fica de fora por ser regido pela NBR 15287:2025, que não prevê resumo.
- [ ] 3.7 Declarar os elementos que a NBR 14724:2024 lista e o pacote **não oferece**: dedicatória, agradecimentos, epígrafe, errata, lombada e índice. Documentar a ausência, não silenciar (design.md, decisão 6) — quem escreve uma dissertação precisa saber disso antes de começar.
- [ ] 3.8 **Descrever, não desenhar.** O manual compila como `generico` e mostra uma capa e uma folha de aprovação, enquanto este capítulo documenta seis e cinco. Apresentar o que muda por tipo em prosa e tabela, e remeter aos arquivos de partida — quem quiser ver a capa de tese compila `modelo-tese.tex`. CRÍTICO: não desenhar as outras capas à mão para ilustrar. Uma capa desenhada é uma segunda implementação do layout: compila limpo e diverge da real na primeira change que toque a capa (design.md, decisão 2). A galeria resolve isso depois, com saída real.

## 4. Capítulos 6 e 7

- [ ] 4.1 Documentar apêndices e anexos: `\apendices`, `\apendice`, `\anexos`, `\anexo`, e o critério de autoria que os separa — apêndice é do próprio autor, anexo é de terceiro. O driver atual já demonstra isso bem; aproveitar.
- [ ] 4.2 Documentar `\printbibliography`, as listas e os glossários, incluindo por que uma lista vazia não deve ser chamada — é a razão pela qual os arquivos de partida trazem essas chamadas comentadas.
- [ ] 4.3 Documentar em forma longa o que os arquivos de partida trazem como instrução curta: por que o `referencias.bib` deste repositório é **fictício**, como criar o próprio arquivo de referências e como declará-lo. Ver design.md, decisão 7 — não é duplicação do README, e sim o porquê que o comentário do esqueleto não tem espaço para dar.
- [ ] 4.4 Escrever o capítulo 7, curto: o que fazer em seguida e onde reportar problema. Conferir que o aviso de que `referencias.bib` é fictício sobreviveu à reescrita — ele hoje mora no meio do `cap2`.

## 5. README

- [ ] 5.1 Reduzir o README a: o que é o modelo, os seis tipos em uma linha cada, qual arquivo copiar, como compilar, e o apontamento para o manual.
- [ ] 5.2 Remover do README o que passou ao PDF — tabela de tipos detalhada, metadados de capa e folha de rosto, folha de aprovação, resumo de macros. Verificar que nenhum assunto ficou tratado em detalhe nos dois lugares. A duplicação já divergiu uma vez: a obrigatoriedade do abstract no `tcc2` teve de ser corrigida em dois pontos do README, e o segundo quase passou.

## 6. Verificação

- [ ] 6.1 Conferir o inventário de 0.2 contra o manual: todo comando público documentado, com forma de chamada, efeito e obrigatoriedade por tipo quando ela variar. Listar no fechamento desta tarefa o que ficou de fora e por quê — "tudo documentado" sem a lista não é verificação.
- [ ] 6.2 Conferir que nenhuma passagem atribui exigência à norma errada, e que toda norma citada no corpo tem entrada em `referencias.bib`.
- [ ] 6.3 Compilar `manual.tex` do zero e ler o PDF inteiro rasterizado. É o artefato principal desta change e o único jeito de saber que os sete capítulos se leem como um documento, e não como três textos costurados.
- [ ] 6.4 Conferir o sumário do manual contra a estrutura prevista em design.md: a estrutura do manual é o exemplo da organização em pastas, então ela precisa estar defensável como estrutura de trabalho, e não só como índice.
- [ ] 6.5 Confirmar que os seis arquivos de partida continuam compilando, e que nenhum deles foi tocado por esta change. Eles pertencem a `add-type-skeletons`; alterá-los aqui é sinal de que uma decisão vazou de uma change para a outra.

## 7. Ao arquivar

- [ ] 7.1 Sincronizar o delta `## ADDED` para `openspec/specs/usage-guide/spec.md`, que **já existe** — criado por `add-type-skeletons`. Os cinco requisitos novos se somam ao que governa os arquivos de partida, sem substituí-lo. `openspec archive` acrescenta os cinco ao final e preserva a ordem — ver `openspec/config.yaml`, `operations.archive`, para o que fica de mão depois dele.
- [ ] 7.2 Conferir que o requisito de `add-type-skeletons` sobreviveu intacto ao sync, e que a capability terminou com seis requisitos.
