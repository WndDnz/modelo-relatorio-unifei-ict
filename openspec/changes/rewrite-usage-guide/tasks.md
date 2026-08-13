## 0. Antes de começar

- [ ] 0.1 Confirmar que `fix-guide-errors` já foi aplicada. Esta change herda o texto do capítulo 5 quase intacto; herdá-lo antes da correção reintroduz a norma errada nas citações e o vocabulário de divisões contraditório, agora em arquivo novo, onde ninguém procura por eles.
- [ ] 0.2 Levantar o inventário do que o pacote oferece ao autor, lendo `UnifeiICTReport.sty` — todo comando, ambiente, opção e metadado público, ignorando os prefixados `\Unifei@` e `\@`. Esse inventário é o critério de completude do manual e a evidência da tarefa 6.1. Sem ele, "documentar tudo" não é verificável.

## 1. Esqueletos

- [ ] 1.1 Criar `modelo-generico.tex`, `modelo-estagio.tex`, `modelo-tcc1.tex`, `modelo-tcc2.tex`, `modelo-dissertacao.tex`, `modelo-tese.tex`, cada um com `tipo=` já declarado e sem nenhum `\subimport` — o esqueleto é a demonstração do documento em arquivo único (design.md, decisão 3).
- [ ] 1.2 Em cada esqueleto, trazer **preenchidos com valor de exemplo** os metadados que aquele tipo exige, e **comentados com explicação ao lado** os opcionais. Área de concentração é exigida em `dissertacao` e `tese` e opcional em `tcc2`; abstract varia por tipo; banca não existe no `generico`. Consultar `openspec/specs/document-type/spec.md` para a matriz, não a memória.
- [ ] 1.3 Comentar `\listoffigures`, `\listoftables`, `\listofquadros`, `\listofgraficos` e os `\printglossary` em todos os esqueletos, com a explicação ao lado. CRÍTICO: `UnifeiICTReport.sty:1595–1605` não tem guarda para lista vazia — descomentado, um esqueleto sem figuras emite página de título seguida de nada, na primeira compilação do aluno.
- [ ] 1.4 Decidir o que os esqueletos fazem com siglas e símbolos, que hoje vêm de `Preambulo/lista-*.tex` via `\subimport` (design.md, questão em aberto). Aplicar a mesma lógica da decisão 3: ou declaração inline de uma sigla de exemplo, ou nenhuma — não um import.
- [ ] 1.5 Escrever no corpo de cada esqueleto o esboço mínimo de seções, direto no arquivo, para que ele sirva de ponto de partida e demonstre a forma de arquivo único. No `tcc1`, seguir a estrutura textual que a NBR 15287:2025 §4.2.2 prescreve, que `document-type` documenta mas não gera.
- [ ] 1.6 Verificar cada um dos seis por compilação limpa (`latexmk -C` antes) e **lendo as páginas rasterizadas**: capa correta para o tipo, natureza correta, folha de aprovação na forma do tipo, nenhuma página de título vazia. Seis PDFs, seis leituras — é o requisito "compila sem edição" sendo de fato exercido.
- [ ] 1.7 Confirmar por execução que `latexmk modelo-*.tex manual.tex` constrói tudo em `build/` sem conflito de auxiliares (design.md, questões resolvidas). Verificar, não deduzir dos nomes.

## 2. Manual: reorganização

- [ ] 2.1 Renomear `modelo-relatorio.tex` para `manual.tex`, com `git mv` para preservar histórico. O nome é o que separa o documento que se lê dos seis que se copiam (design.md, decisão 2).
- [ ] 2.2 Criar a árvore dos sete capítulos em `Capitulos/`, substituindo `cap1`/`cap2`/`cap3`. Manter a convenção de uma pasta por capítulo — é ela que o manual apresenta como organização recomendada, então precisa continuar sendo o que o manual de fato faz.
- [ ] 2.3 Mover o conteúdo de ilustrações, tabelas e equações (`cap2` §2.5–2.6) para o capítulo 5 **preservando-o**. É a parte boa do texto atual; mover não é pretexto para refazer. Conferir por diff que só mudaram cabeçalhos de seção e referências cruzadas.
- [ ] 2.4 Distribuir o restante do `cap2` atual: ambiente e organização de arquivos → capítulo 2; divisões, rótulos, `\refcomp`, citações → capítulo 4; abreviaturas, siglas e símbolos → capítulo 6.
- [ ] 2.5 Aposentar o conteúdo fictício de `cap1` e `cap3` — o objetivo geral que declara ser o próprio modelo, a conclusão de um trabalho inexistente. O que ali ensina a **escrever** uma introdução tem lugar: vai para o capítulo 3, junto da estrutura textual do documento.

## 3. Manual: o capítulo 3, que é onde está a dívida

- [ ] 3.1 Documentar os seis tipos e como escolher, no capítulo 1: o que cada um é, que norma o rege, e a consequência de escolher errado. NBR 14724:2024 para `generico`, `estagio`, `tcc2`, `dissertacao` e `tese`; NBR 15287:2025 para `tcc1`.
- [ ] 3.2 Documentar a ordem dos elementos pré-textuais e a divisão `\frontmatter` / `\mainmatter` / `\backmatter`.
- [ ] 3.3 Documentar capa e folha de rosto: título, subtítulo (escrito **sem** os dois-pontos, que o modelo insere), múltiplos autores, múltiplos professores em `\supervisor`, coorientador, e o rótulo do papel que deriva do tipo.
- [ ] 3.4 Documentar a folha de aprovação: `\folhaaprovacao` sem argumento, a composição por tipo, `\bancamembro` só para os membros externos (o orientador já entra por `\supervisor`), `\aprovacaodata`, `\notaaprovacao`, e o fato de ela não ser emitida no `tcc1` sem banca.
- [ ] 3.5 Declarar, ao documentar a folha, que a **ausência de linhas de assinatura é deliberada** — desvio D1, registrado em `add-document-types`. É o desvio mais visível ao leitor, e sem a explicação ele parece defeito e alguém "conserta".
- [ ] 3.6 Documentar `\areaconcentracao` e `\linhapesquisa`, com a obrigatoriedade que varia por tipo e a mensagem de erro que o modelo emite quando a área falta em `dissertacao` ou `tese`.
- [ ] 3.7 Documentar os resumos: `\abstract`, `\keywords`, `\abstractseclang`, `\keywordsseclang`, `\makeabstracts`, e em que tipos o abstract é exigido.
- [ ] 3.8 Explicar o **rebaixamento de níveis** de forma destacada, no capítulo 4: internamente o modelo segue o padrão da classe `book` e o autor escreve `\chapter`, `\section`, `\subsection`, `\subsubsection`; na saída, cada um sai um degrau abaixo — Seção, Subseção, Subsubseção, Parágrafo — porque a NBR 14724:2024 §4.2.2 não admite a divisão do trabalho em capítulos. Dizer as duas coisas juntas e explicitamente: **o comando que se digita** e **o nome que se imprime**. O comentário de `UnifeiICTReport.sty:286–301` já explica isso bem; aproveitá-lo como base da prosa. CRÍTICO: é a maior distância entre o que o autor escreve e o que ele lê no PDF, e a única em todo o modelo que exige tradução mental — quem não entender vai escrever "conforme o capítulo anterior" sobre algo que o documento chama de Seção.
- [ ] 3.9 Deixar claro, na mesma passagem, que o rebaixamento **não é desvio da norma**: é como o modelo a cumpre usando uma classe que fala outro vocabulário. Distinguir isto dos desvios deliberados D1–D4, que são outra coisa.
- [ ] 3.10 Declarar os elementos que a NBR 14724:2024 lista e o pacote **não oferece**: dedicatória, agradecimentos, epígrafe, errata, lombada e índice. Documentar a ausência, não silenciar (design.md, decisão 7) — quem escreve uma dissertação precisa saber disso antes de começar.

## 4. Manual: capítulo 6 e fechamento

- [ ] 4.1 Documentar apêndices e anexos: `\apendices`, `\apendice`, `\anexos`, `\anexo`, e o critério de autoria que os separa — apêndice é do próprio autor, anexo é de terceiro. O `modelo-relatorio.tex` atual já demonstra isso bem; aproveitar.
- [ ] 4.2 Documentar `\printbibliography`, as listas e os glossários, incluindo por que uma lista vazia não deve ser chamada.
- [ ] 4.3 Escrever o capítulo 7, curto: o que fazer em seguida, onde reportar problema, e o aviso de que `referencias.bib` é fictício — conferir que esse aviso sobreviveu à reescrita, porque ele hoje mora no meio do `cap2`.

## 5. README

- [ ] 5.1 Reduzir o README a: o que é o modelo, os seis tipos em uma linha cada, qual arquivo copiar, como compilar, e o apontamento para o manual.
- [ ] 5.2 Remover do README o que passou ao PDF — tabela de tipos detalhada, metadados de capa e folha de rosto, folha de aprovação, resumo de macros. Verificar que nenhum assunto ficou tratado em detalhe nos dois lugares; é a duplicação que já divergiu uma vez.

## 6. Verificação

- [ ] 6.1 Conferir o inventário de 0.2 contra o manual: todo comando público documentado, com forma de chamada, efeito e obrigatoriedade por tipo quando ela variar. Listar no fechamento desta tarefa o que ficou de fora e por quê — "tudo documentado" sem a lista não é verificação.
- [ ] 6.2 Conferir que nenhuma passagem atribui exigência à norma errada, e que toda norma citada no corpo tem entrada em `referencias.bib`.
- [ ] 6.3 Compilar `manual.tex` do zero e ler o PDF inteiro rasterizado. É o artefato principal desta change e o único jeito de saber que os sete capítulos se leem como um documento, e não como três textos costurados.
- [ ] 6.4 Conferir o sumário do manual contra a estrutura prevista em design.md: a estrutura do manual é o exemplo da organização em pastas, então ela precisa estar defensável como estrutura de trabalho, não só como índice.

## 7. Ao arquivar

- [ ] 7.1 `usage-guide` é capability nova: o sync cria `openspec/specs/usage-guide/spec.md` a partir do delta `## ADDED`, convertendo o cabeçalho para `## Requirements`. Sem CLI nesta máquina — ver `openspec/config.yaml`, `operations.archive`.
- [ ] 7.2 Registrar como dívida a guarda para lista vazia em `\listoffigures`/`\listoftables` (`UnifeiICTReport.sty:1595–1605`), contornada aqui por comentário e não resolvida (design.md, decisão 4). Ela pertence ao `.sty` e beneficiaria qualquer documento real.
