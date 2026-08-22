## 0. Antes de começar

- [x] 0.1 Confirmar que `add-type-skeletons` já foi aplicada. O manual referencia os seis arquivos de partida como exemplo da organização em arquivo único, e a tarefa 5.4 remete a eles quem quiser ver as capas dos outros tipos. Sem eles, essas passagens ficam sem referente.

  **Resultado.** Aplicada e arquivada em 2026-08-21, em `changes/archive/2026-08-21-add-type-skeletons/`. Os seis arquivos estão versionados e compilam; `openspec/specs/usage-guide/spec.md` existe, com o requisito dos arquivos de partida.
- [x] 0.2 Levantar o inventário do que o pacote oferece ao autor, lendo `UnifeiICTReport.sty` — todo comando, ambiente, opção e metadado público, ignorando os prefixados `\Unifei@` e `\@`. Esse inventário é o critério de completude do manual e a evidência da tarefa 6.1. Sem ele, "documentar tudo" não é verificável.

  CRÍTICO: **expandir as chamadas de `\novotipoilustracao` antes de contar.** `quadroabnt`, `\refquadro`, `\refquadrocomp`, `\listofquadros` e os quatro equivalentes de `grafico` não existem como definição no `.sty` — são montados por `\csname` dentro do gerador. Um inventário lido das definições não vê nenhum dos oito, e dois deles, `\refquadrocomp` e `\refgraficocomp`, não são citados hoje em parte alguma do repositório.

  **Escrever o critério de fronteira junto do inventário, e não deixá-lo implícito.** "Ignorar os prefixados `\Unifei@` e `\@`" não separa o que se pretende: 65 comandos passam nesse filtro, e cerca de quinze não são do pacote para documentar — `\hrule`, `\HRule`, `\headrulewidth`, `\baselinestretch`, `\csname`, `\conditionalvspace`, `\theanexosec`, `\theapendicesec`, `\glossarysection` e sete `\...autorefname`, que são configuração do `hyperref`. Sem o critério escrito, a tarefa 6.1 vira julgamento não registrado.
  **Resultado — critério de fronteira.** Entra no manual o que o autor **digita no próprio arquivo**, preâmbulo ou corpo. Quem definiu o comando não decide nada: `\maketitle`, `\tableofcontents` e `\frontmatter` são do LaTeX e entram; `\headrulewidth` é redefinido pelo pacote e não entra. Ficam de fora, nomeadamente:

  1. os internos prefixados `\Unifei@` e `\@` — 70 comandos;
  2. parâmetros de layout que o pacote ajusta para si: `\HRule`, `\hrule`, `\headrulewidth`, `\baselinestretch`, `\conditionalvspace`, `\csname`;
  3. nomes de referência cruzada do `hyperref`, consumidos por `\autoref` e nunca digitados: `\chapterautorefname`, `\sectionautorefname`, `\subsectionautorefname`, `\subsubsectionautorefname`, `\apendicesecautorefname`, `\anexosecautorefname`;
  4. formas impressas de contador: `\theanexosec`, `\theapendicesec`;
  5. auxiliares de composição do próprio pacote: `\glossarysection`, `\unifeifont`, `\unifeismallcaps` — disponíveis, mas não parte da superfície documentada.

  **Resultado — inventário.** Dez grupos:

  - **Opções de pacote (4).** `tipo=` com seis valores; `neverindent`; `roman`; `sans`.
  - **Capa e folha de rosto (16).** `\title`, `\subtitle`, `\fulltitle`, `\author`, `\subject`, `\supervisor`, `\cosupervisor`, `\empresasupervisor`, `\areaconcentracao`, `\linhapesquisa`, `\institution`, `\faculty`, `\course`, `\location`, `\state`, `\stateacronym`.
  - **Folha de aprovação (4).** `\folhaaprovacao`, `\bancamembro`, `\aprovacaodata`, `\notaaprovacao`.
  - **Resumos (5).** `\abstract`, `\keywords`, `\abstractseclang`, `\keywordsseclang`, `\makeabstracts`.
  - **Estrutura (7).** `\frontmatter`, `\mainmatter`, `\backmatter`, `\maketitle`, `\tableofcontents`, `\listoffigures`, `\listoftables`.
  - **Ilustrações (7).** ambientes `figuraabnt`, `tabelaabnt`, `quadroabnt`, `graficoabnt`; `\fonte`; `\novotipoilustracao`; `\includegraphics`, que o pacote redefine.
  - **Referência cruzada (11).** `\refcomp`, `\reffig`, `\reffigcomp`, `\reftable`, `\reftablecomp`, `\refeq`, `\refeqcomp`, `\refquadro`, `\refquadrocomp`, `\refgrafico`, `\refgraficocomp`.
  - **Pós-textuais (4).** `\apendices`, `\apendice`, `\anexos`, `\anexo`.
  - **Nomes personalizáveis (4).** `\figuresourcename`, `\eqname`, `\acronymlistname`, `\symbolslistname`.
  - **Gerados por tipo novo (4 por tipo).** `\novotipoilustracao{<c>}{<Palavra>}{<amb>}` produz o ambiente `<amb>`, `\ref<c>`, `\ref<c>comp` e `\listof<c>s`.

  **Correção de premissa.** O enunciado desta tarefa mandava levantar o inventário "lendo `UnifeiICTReport.sty`". Ler não basta em dois pontos, e os dois foram descobertos comparando com a saída:

  - **Os ambientes não existem como definição.** `figuraabnt` e `tabelaabnt` saem de `\Unifei@DeclareABNTEnv` (`:1084–1096`), e os de tipo, de `\novotipoilustracao`. Nenhum aparece num `\newenvironment`. Um `grep` por definições devolve **zero ambientes públicos** — e o modelo tem quatro.
  - **Três opções de pacote não estavam em lugar nenhum do radar.** `neverindent` (`:18`), `roman` (`:22`) e `sans` (`:23`), além do `tipo=`. Nenhuma é citada no README, no guia ou nos arquivos de partida.

  **Resultado — lacuna medida.** Treze itens do inventário não são citados hoje em parte alguma do repositório: os seis metadados de instituição, `\eqname`, `\figuresourcename`, `\refquadrocomp`, `\refgraficocomp`, e as opções `neverindent`, `roman` e `sans`. É o piso do que o capítulo 3 e os demais têm de cobrir, e a lista contra a qual a tarefa 6.1 fecha.


## 1. Reorganização

- [x] 1.1 Renomear `modelo-relatorio.tex` para `manual.tex`, com `git mv` para preservar histórico. O nome é o que separa o documento que se lê dos seis que se copiam (design.md, decisão 1).

- [x] 1.1a Tirar do preâmbulo do manual a instrução que é de arquivo de partida. Hoje `modelo-relatorio.tex:5–19` traz a tabela dos seis tipos e a linha "Troque o valor abaixo para mudar de tipo" — instrução de quem vai copiar, que os seis esqueletos já dão cada um no próprio cabeçalho, e que no manual contradiz a tarefa 2.2. No lugar, um cabeçalho que diga o que o arquivo é e que apontar para os arquivos de partida é papel do capítulo 1. O `tipo=generico` já está declarado (`:19`) e permanece — é a decisão 1 do design, e não precisa de mudança.
- [x] 1.2 Criar a árvore dos sete capítulos em `Capitulos/`, substituindo `cap1`/`cap2`/`cap3`. Manter a convenção de uma pasta por capítulo — é ela que o manual apresenta como organização recomendada, então precisa continuar sendo o que o manual de fato faz.
- [x] 1.3 Mover o conteúdo de ilustrações, tabelas e equações (`cap2` §2.5–2.6) para o capítulo 5 **preservando-o**. É a parte boa do texto atual; mover não é pretexto para refazer. Conferir por diff que só mudaram cabeçalhos de seção e referências cruzadas.

  **Resultado.** Recorte conferido por script: as 405 linhas não-vazias do `cap2.tex` a partir da 17 estão todas em algum dos quatro capítulos herdeiros, e nenhum dos 12 cabeçalhos de seção se perdeu. O capítulo 5 recebeu o bloco de figuras/tabelas/equações **sem uma alteração sequer** — nem cabeçalho: as antigas `\section` continuam `\section`, agora sob um `\chapter` novo.

  **Nota de método.** A primeira tentativa de recorte perdeu o primeiro `\section` dos capítulos 2 e 4, e a segunda leu o `cap2.tex` que a primeira já havia sobrescrito, produzindo capítulos de 5 e 9 linhas. O script final lê o blob do git, não o arquivo em disco. Um script que escreve na própria fonte não pode ser rodado duas vezes.
- [x] 1.4 Distribuir o restante do `cap2` atual: ambiente e organização de arquivos → capítulo 2; divisões, rótulos, `\refcomp`, citações → capítulo 4; abreviaturas, siglas e símbolos → capítulo 6.
- [x] 1.5 Aposentar o conteúdo fictício de `cap1` e `cap3` — o objetivo geral que declara ser o próprio modelo, a conclusão de um trabalho inexistente. O que ali ensina a **escrever** uma introdução tem lugar: vai para o capítulo 3, junto da estrutura textual do documento.

## 2. Capítulos 1, 2 e 4

- [x] 2.1 Documentar os seis tipos e como escolher, no capítulo 1: o que cada um é, que norma o rege, e a consequência de escolher errado. NBR 14724:2024 para `generico`, `estagio`, `tcc2`, `dissertacao` e `tese`; NBR 15287:2025 para `tcc1`.
- [x] 2.2 No capítulo 1, dizer qual arquivo de partida copiar para cada tipo, e que o manual não é para ser copiado. É a primeira coisa que um leitor novo precisa saber.
- [x] 2.3 No capítulo 2, apresentar as duas formas de organizar os arquivos apontando para os artefatos reais: este manual, organizado em `Capitulos/` com `\subimport`, e os arquivos de partida, completos em um arquivo só. Demonstrar por existência, não por descrição.

  **Resultado.** A antiga §2.2 virou "Duas formas de organizar os arquivos", com uma subseção para cada e uma terceira sobre migrar de uma para a outra. Cada forma aponta para o artefato que a demonstra: `modelo-generico.tex` para o arquivo único, este manual para a organização em `Capitulos/`. O `\subimport` ganhou a explicação que faltava --- por que ele, e não `\input`: caminhos relativos passam a valer a partir da pasta do capítulo, que é a razão de existir do subdiretório por capítulo.

  O parágrafo sobre o arquivo principal saiu da §2.1, onde duplicava o assunto, e deu lugar à instrução de compilação, que não estava em lugar nenhum do capítulo.

- [x] 2.4 Explicar o **rebaixamento de níveis** de forma destacada, no capítulo 4: internamente o modelo segue o padrão da classe `book` e o autor escreve `\chapter`, `\section`, `\subsection`, `\subsubsection`; na saída, cada um sai um degrau abaixo — Seção, Subseção, Subsubseção, Parágrafo — porque a NBR 14724:2024 §4.2.2 não admite a divisão do trabalho em capítulos. Dizer as duas coisas juntas: **o comando que se digita** e **o nome que se imprime**. O bloco corrigido em `fix-guide-errors` já faz isso bem e serve de base. CRÍTICO: é a maior distância entre o que o autor escreve e o que ele lê no PDF, e a única em todo o modelo que exige tradução mental.

  **Resultado.** O rebaixamento saiu de dentro da seção de estruturação, onde vinha depois de quatro parágrafos de conselho genérico, e virou a **primeira seção do capítulo**. Ganhou tabela de correspondência --- comando digitado, nome impresso, prefixo de rótulo --- em vez da lista de quatro itens, e a lista de diretrizes seguinte agora remete a ela em vez de repetir o mapeamento.

- [x] 2.5 Deixar claro, na mesma passagem, que o rebaixamento **não é desvio da norma**: é como o modelo a cumpre usando uma classe que fala outro vocabulário. Distinguir dos desvios deliberados D1–D4, que são outra coisa — sem isso o leitor conclui que o modelo diverge onde ele obedece.

## 3. Capítulo 3, que é onde está a dívida


  **Resultado.** Subseção própria, "Isto não é desvio da norma", logo abaixo da tabela. A distinção está posta pelo critério que a separa e não por asserção: desvio muda o que sai no papel, rebaixamento muda só o que se digita. Remete à folha de aprovação sem assinaturas (D1) como o exemplo do que é desvio de verdade.

- [x] 3.1 Documentar a ordem dos elementos pré-textuais e a divisão `\frontmatter` / `\mainmatter` / `\backmatter`.
- [x] 3.2 Documentar capa e folha de rosto: título, subtítulo (escrito **sem** os dois-pontos, que o modelo insere), múltiplos autores, múltiplos professores em `\supervisor`, coorientador, e o rótulo do papel que deriva do tipo.

  Incluir os seis metadados de instituição — `\institution`, `\faculty`, `\course`, `\location`, `\state` e `\stateacronym` (`UnifeiICTReport.sty:790–801`) —, hoje **não documentados em lugar algum** e não declarados por nenhum dos seis arquivos de partida. CRÍTICO: todos têm padrão embutido, e os do campus estão certos (Unifei, ICT, Itabira, MG); `\course` está fixo em "Engenharia de Computação", que é um curso entre vários do ICT. O padrão certo é o que esconde o defeito — a capa sai plausível para qualquer leitor e correta só para parte deles. Verificado por `pdftotext` na página 1 de `build/modelo-tese.pdf`, que imprime "ITABIRA 2026" sem que o arquivo declare coisa alguma.

  **Resultado.** Os dezesseis metadados de capa e folha de rosto entraram numa tabela, com os seis de instituição e seus padrões explícitos, e o `\course` destacado em prosa como a exceção que sai errada para a maioria.
- [x] 3.3 Documentar a folha de aprovação: `\folhaaprovacao` sem argumento, a composição por tipo, `\bancamembro` só para os membros externos (o orientador já entra por `\supervisor`), `\aprovacaodata`, `\notaaprovacao`, e o fato de ela não ser emitida no `tcc1` sem banca.
- [x] 3.4 Declarar, ao documentar a folha, que a **ausência de linhas de assinatura é deliberada** — desvio D1, registrado em `add-document-types`. É o desvio mais visível ao leitor, e sem a explicação ele parece defeito e alguém "conserta".
- [x] 3.5 Documentar `\areaconcentracao` e `\linhapesquisa`, com a obrigatoriedade que varia por tipo e a mensagem de erro que o modelo emite quando a área falta em `dissertacao` ou `tese`.
- [x] 3.6 Documentar os resumos: `\abstract`, `\keywords`, `\abstractseclang`, `\keywordsseclang`, `\makeabstracts`. O abstract é obrigatório nos **três** tipos de monografia — `tcc2` inclusive, desde `require-abstract-tcc2` — e opcional nos demais; o `tcc1` fica de fora por ser regido pela NBR 15287:2025, que não prevê resumo.
- [x] 3.7 Declarar os elementos que a NBR 14724:2024 lista e o pacote **não oferece**: dedicatória, agradecimentos, epígrafe, errata, lombada e índice. Documentar a ausência, não silenciar (design.md, decisão 6) — quem escreve uma dissertação precisa saber disso antes de começar.
- [x] 3.8 **Descrever, não desenhar.** O manual compila como `generico` e mostra uma capa e uma folha de aprovação, enquanto este capítulo documenta seis e cinco. Apresentar o que muda por tipo em prosa e tabela, e remeter aos arquivos de partida — quem quiser ver a capa de tese compila `modelo-tese.tex`. CRÍTICO: não desenhar as outras capas à mão para ilustrar. Uma capa desenhada é uma segunda implementação do layout: compila limpo e diverge da real na primeira change que toque a capa (design.md, decisão 2). A galeria resolve isso depois, com saída real.

## 4. Capítulos 6 e 7

- [x] 4.1 Documentar apêndices e anexos: `\apendices`, `\apendice`, `\anexos`, `\anexo`, e o critério de autoria que os separa — apêndice é do próprio autor, anexo é de terceiro. O driver atual já demonstra isso bem; aproveitar.
- [x] 4.2 Documentar `\printbibliography`, as listas e os glossários, incluindo por que uma lista vazia não deve ser chamada — é a razão pela qual os arquivos de partida trazem essas chamadas comentadas.
- [x] 4.3 Documentar em forma longa o que os arquivos de partida trazem como instrução curta: por que o `referencias.bib` deste repositório é **fictício**, como criar o próprio arquivo de referências e como declará-lo. Ver design.md, decisão 7 — não é duplicação do README, e sim o porquê que o comentário do esqueleto não tem espaço para dar.
- [x] 4.4 Escrever o capítulo 7, curto: o que fazer em seguida e onde reportar problema. Conferir que o aviso de que `referencias.bib` é fictício sobreviveu à reescrita — ele hoje mora no meio do `cap2`.

## 5. README

- [x] 5.1 Reduzir o README a: o que é o modelo, os seis tipos em uma linha cada, qual arquivo copiar, como compilar, e o apontamento para o manual.

  **Resultado.** 223 → 92 linhas. Ficou: o que é o modelo, a tabela dos seis arquivos de partida com uma linha cada, a linha do `\usepackage`, requisitos, como compilar, a estrutura do repositório e solução de problemas. As referências a `modelo-relatorio.tex`, que não existe mais, sumiram junto — eram nove.

- [x] 5.2 Remover do README o que passou ao PDF — tabela de tipos detalhada, metadados de capa e folha de rosto, folha de aprovação, resumo de macros. Verificar que nenhum assunto ficou tratado em detalhe nos dois lugares. A duplicação já divergiu uma vez: a obrigatoriedade do abstract no `tcc2` teve de ser corrigida em dois pontos do README, e o segundo quase passou.

## 6. Verificação


  **Resultado.** Saíram do README: a tabela de governança por tipo, os dezesseis metadados de capa e folha de rosto, a folha de aprovação inteira (incluindo a explicação do D1), a estrutura textual do `tcc1` segundo a NBR 15287, e o resumo de macros — cerca de 130 linhas, todas com tratamento equivalente ou melhor no PDF.

  **Assuntos que aparecem nos dois, e por quê.** Três, todos em registro diferente, conforme a decisão 3 do design: os seis tipos (uma linha cada no README, capítulo 1 inteiro no manual), como compilar (o comando no README, o porquê das passadas no capítulo 2) e o `referencias.bib` fictício (uma linha de aviso no README, subseção com o motivo no capítulo 6). Nenhum tratamento detalhado ficou duplicado.

- [x] 6.1 Conferir o inventário de 0.2 contra o manual: todo comando público documentado, com forma de chamada, efeito e obrigatoriedade por tipo quando ela variar. Listar no fechamento desta tarefa o que ficou de fora e por quê, **citando o critério de fronteira escrito em 0.2** em vez de justificar caso a caso — "tudo documentado" sem a lista não é verificação, e a lista sem o critério é quinze justificativas soltas.

  **Resultado.** 61 dos 64 itens do inventário estão citados no manual, conferidos por script que aceita as três formas de citação em uso — `\comando`, `\texttt{\textbackslash comando}` e `\begin{ambiente}`.

  Nove lacunas foram encontradas e fechadas nesta verificação: a linha literal do `\usepackage[tipo=...]` (o capítulo 1 falava do tipo sem nunca mostrar como declará-lo), `\refquadrocomp` e `\refgraficocomp` (capítulo 5, junto dos tipos que os geram), `\figuresourcename` e `\eqname` (nova §5.3) e `\acronymlistname` e `\symbolslistname` (fim do capítulo 6).

  **Os três que ficaram de fora, e não por critério de fronteira:** as opções `neverindent`, `roman` e `sans`. Não estão documentadas porque **não funcionam** — `neverindent` interrompe a compilação com sequência de controle indefinida, e `roman`/`sans` alternam uma flag que o pacote nunca consulta. Verificado por compilação. Registrado como a change `fix-package-options`; documentá-las antes disso seria documentar um defeito.

  Fora do inventário, pelo critério escrito em 0.2 e sem exceção caso a caso: os 70 internos `\Unifei@`/`\@`, os seis parâmetros de layout, os seis `...autorefname` do hyperref, os dois `\the...sec` e os três auxiliares de composição.

- [x] 6.2 Conferir que nenhuma passagem atribui exigência à norma errada, e que toda norma citada no corpo tem entrada em `referencias.bib`.

  **Resultado.** As cinco normas citadas no corpo — 14724:2024, 15287:2025, 10520:2023, 6023:2018 e 6028:2021 — têm entrada em `referencias.bib`. A 15287 foi acrescentada nesta change: o capítulo 1 passou a citá-la e ela não existia.

  Os sete `§` citados no manual (§4.2.2, §4.2.1.9, §5.8, §5.9) conferem com as capabilities já aceitas em `openspec/specs/`. Nenhuma exigência atribuída à norma errada.

  **Correção nas referências.** Quatro entradas de norma traziam o subtítulo com capitalização inventada, e a da 14724 estava incompleta — dizia "Trabalhos Acadêmicos — Apresentação", faltando "Informação e documentação —". Corrigidas contra a folha de rosto das próprias normas. Um modelo sobre a ABNT com referência da ABNT errada é o pior lugar possível para esse defeito.

- [x] 6.3 Compilar `manual.tex` do zero e ler o PDF inteiro rasterizado. É o artefato principal desta change e o único jeito de saber que os sete capítulos se leem como um documento, e não como três textos costurados.

  **Resultado.** Compilado do zero (`rm -rf build`), `exit 0`, 45 páginas, **zero** referências ou citações indefinidas e **zero** `Overfull \hbox`. As 45 páginas foram rasterizadas e lidas.

  Quatro defeitos que a leitura pegou e o log não pegava:

  1. **A URL do repositório saía fora da margem**, no capítulo 7 — 142pt, com o `xdvipdfmx` avisando "Annotation out of page boundary". Passou para bloco centrado próprio.
  2. **Sete `Overfull \hbox`**, todos por nome de comando em monoespaçado no fim de linha, que não hifeniza. Resolvidos com `\emergencystretch` de 3em no preâmbulo do manual — usado só em último caso, então as demais linhas não afrouxaram — mais reescrita de três parágrafos onde 3em não bastava.
  3. **O capítulo 6 dizia que a lista vazia sai com o título "LISTA DE ILUSTRAÇÕES".** Sai com "LISTA DE FIGURAS": é o que a página 6 do PDF imprime. Corrigido, e o item que descreve o `\listoffigures` passou a dizer o título impresso, além do nome normativo.
  4. **O resumo e o abstract do próprio manual ainda eram o texto de exemplo** — "modelo de resumo para o relatório técnico-científico". Reescritos para descrever o manual.

  **Um quinto defeito, achado depois, ao tirar o `\supervisor` da capa.** Sem professor declarado, a folha de aprovação imprime o rótulo "Professor da disciplina" **sozinho, sem nome acima**. A guarda `\if@supervisorpresent` existe (`:808`) e é consultada pela folha de rosto (`:1279`), mas não pela folha de aprovação, em nenhum dos três pontos (`:1450`, `:1461`, `:1497`). Registrado como `fix-supervisor-guard-approval-sheet`. Até ele entrar, `manual.tex` declara `\supervisor` com o nome de quem mantém o modelo, e o preâmbulo diz por quê.

  **A página 8 continua em branco**, e não é defeito desta change: os dois `\printglossary` não imprimem nada porque o `makeglossaries` nunca roda no ciclo do `latexmk`. Registrado como `fix-glossary-build`.

- [x] 6.4 Conferir o sumário do manual contra a estrutura prevista em design.md: a estrutura do manual é o exemplo da organização em pastas, então ela precisa estar defensável como estrutura de trabalho, e não só como índice.

  **Resultado.** Os sete capítulos do sumário são exatamente os sete da tabela do design, na mesma ordem e com a mesma origem. Só o título do sétimo mudou — "Por onde seguir" em vez de "Conclusão", que num manual seria estranho; o design pedia "novo, curto", e ele tem duas páginas.

  Contra a decisão 5, que exige que a estrutura seja defensável como estrutura de trabalho e não só como índice de manual: profundidade máxima de quatro níveis, usada uma única vez (4.2.1.1), um assunto por capítulo e nenhum capítulo com uma seção só. É uma estrutura que um aluno pode copiar.

- [x] 6.5 Confirmar que os seis arquivos de partida continuam compilando, e que nenhum deles foi tocado por esta change. Eles pertencem a `add-type-skeletons`; alterá-los aqui é sinal de que uma decisão vazou de uma change para a outra.

## 7. Ao arquivar


  **Resultado.** Os seis compilam com `exit 0` — `generico`, `estagio` e `tcc1` com 8 páginas; `tcc2`, `dissertacao` e `tese` com 11.

  **Um foi tocado, por decisão sua.** `modelo-generico.tex` recebeu o exemplo de múltiplos autores que saiu da capa do manual, como comentário acima do `\author`. É a única alteração, e nenhuma decisão desta change vazou para `add-type-skeletons`: o comentário que já estava ali dizia "Mais de um autor: separe os nomes com `\`" e passou a mostrar a linha completa.

- [ ] 7.1 Sincronizar o delta `## ADDED` para `openspec/specs/usage-guide/spec.md`, que **já existe** — criado por `add-type-skeletons`. Os cinco requisitos novos se somam ao que governa os arquivos de partida, sem substituí-lo. `openspec archive` acrescenta os cinco ao final e preserva a ordem — ver `openspec/config.yaml`, `operations.archive`, para o que fica de mão depois dele.
- [ ] 7.2 Conferir que o requisito de `add-type-skeletons` sobreviveu intacto ao sync, e que a capability terminou com seis requisitos.
