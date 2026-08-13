## Contexto

O modelo passou a atender seis tipos de documento, regidos por duas normas diferentes, mas continua sendo apresentado por um único arquivo `modelo-relatorio.tex` com `tipo=generico` e por três capítulos que oscilam entre relatório fictício e manual. Esta change decide como o texto passa a cobrir os seis tipos, e o que exatamente o autor copia para começar.

## Decisões

### 1. Seis drivers, não um documento com minipages

Cogitou-se condensar tudo em um documento só, renderizando as partes divergentes — capas, folhas de aprovação — lado a lado em `minipage`. Foi rejeitado por evidência no `.sty`, não por preferência:

- O tipo resolve **uma vez**, em `\ProcessOptions`, numa cascata de `\ifx` que fixa booleanos globais (`UnifeiICTReport.sty:150–205`). Não há um segundo tipo a encenar no meio do documento sem lutar contra o desenho do pacote.
- `\folhaaprovacao` usa `\cleardoublepage` e `\vfill` de página inteira. Nada disso sobrevive dentro de uma `minipage`.

Qualquer um dos dois caminhos obrigaria a **reimplementar à mão** a capa e a folha de aprovação para a demonstração. Essa segunda implementação compilaria limpo e passaria a divergir da real silenciosamente, na primeira change seguinte que tocasse o layout — que é precisamente o modo de falha que este projeto já paga caro.

Seis drivers evitam isso por construção: cada um exercita o caminho real do pacote.

### 2. `manual.tex` e `modelo-<tipo>.tex` — nomes que dizem o papel

`modelo-relatorio.tex` vira **`manual.tex`**: é o documento que se lê, não o que se copia. Os seis esqueletos ficam `modelo-generico.tex`, `modelo-estagio.tex`, `modelo-tcc1.tex`, `modelo-tcc2.tex`, `modelo-dissertacao.tex`, `modelo-tese.tex`.

Manter o manual chamado `modelo-relatorio.tex` ao lado de seis `modelo-*.tex` faria dele o sétimo esqueleto aos olhos de quem chega — e é o único arquivo da raiz que ninguém deve copiar. O nome carrega a distinção que o README teria de explicar.

`manual.tex` compila com `tipo=generico`: o manual precisa de um tipo, e o genérico é o que menos promete sobre si mesmo.

### 3. Os esqueletos não importam nada — e por quê isso não é amputação

Um esqueleto que fizesse `\subimport{Capitulos/cap1/}{cap1.tex}` viria acompanhado de uma árvore de arquivos vazios, ou apontaria para os capítulos do manual. A primeira é lixo a apagar; a segunda faz o esqueleto compilar o manual inteiro.

Ao não importar nada, o esqueleto passa a ser **a demonstração da segunda forma de trabalhar**: tudo num arquivo só, seções escritas direto no corpo. E o manual, que se organiza em `Capitulos/`, é a demonstração da primeira. As duas formas ficam documentadas por existência, e não por descrição — nenhum artefato de exemplo extra precisa ser mantido em sincronia.

### 4. Listas comentadas nos esqueletos

`\listoffigures` e `\listoftables` (`UnifeiICTReport.sty:1595–1605`) fazem `\cleardoublepage`, imprimem o título e chamam `\@starttoc` **sem guarda para lista vazia**. Um esqueleto recém-copiado, sem uma figura sequer, sairia com uma página de título e nada abaixo — na primeiríssima compilação do aluno.

Nos esqueletos as quatro listas saem comentadas, com a explicação ao lado, seguindo o que `modelo-relatorio.tex` já faz para `\listofquadros` e `\listofgraficos`. O mesmo vale para `\printglossary` sem sigla declarada.

**Registrado como dívida, não resolvido aqui:** a guarda para lista vazia pertence ao `.sty` e beneficiaria qualquer documento real cujo autor esqueça de comentar. Contornar por comentário resolve o esqueleto e deixa o defeito de pé. É change própria, e esta não mexe no `.sty` para não misturar reescrita de texto com mudança de comportamento.

### 5. README apresenta, PDF instrui

Hoje a tabela de tipos, os metadados e o resumo de macros existem **nos dois**, e já divergiram. Duplicação de documentação não envelhece parelha.

O README passa a: dizer o que é o modelo, listar os seis tipos em uma linha cada, dizer qual arquivo copiar, dizer como compilar, e apontar para o PDF. Todo o resto vive no PDF, que é onde há espaço para a justificativa normativa — e onde o exemplo pode ser mostrado compilado ao lado do código que o produz, coisa que Markdown não faz.

### 6. Sete capítulos, e por que o terceiro é o mais importante

| # | Capítulo | Origem |
|---|----------|--------|
| 1 | Introdução | novo — os seis tipos e como escolher |
| 2 | Preparando o ambiente | `cap2` §2.1–2.2 |
| 3 | Estrutura do documento | **novo, quase inteiro** |
| 4 | Escrevendo o texto | `cap2` §2.3–2.4 |
| 5 | Ilustrações, tabelas, equações | `cap2` §2.5–2.6, praticamente intacto |
| 6 | Elementos pós-textuais | `cap2` §2.7 + apêndices/anexos |
| 7 | Conclusão | novo, curto |

O capítulo 3 concentra o débito: ordem dos elementos pré-textuais, capa, folha de rosto, folha de aprovação por tipo, banca, área de concentração, resumos e sua obrigatoriedade variável. É a matéria de duas changes inteiras que nunca chegou ao texto.

O capítulo 5 é o que já está bom. A reescrita **preserva** seu conteúdo; movê-lo não é pretexto para refazê-lo.

### 7. A ausência é documentada

A NBR 14724:2024 lista dedicatória, agradecimentos, epígrafe, errata, lombada e índice; o pacote não oferece nenhum. O capítulo 3 declara isso, em vez de deixar o aluno concluir que o modelo é completo — quem precisa de agradecimentos numa dissertação precisa saber, antes de escrever, que terá de improvisar.

Documentar a ausência é o que mantém a lista viva como escopo de trabalho futuro. Silenciar sobre ela a apaga.

## Desvios registrados

Nenhum novo. Esta change não altera comportamento do pacote — e portanto não diverge de norma alguma. Os desvios D1–D4 seguem valendo, registrados em `add-document-types`, e o capítulo 3 deve **explicá-los ao leitor** onde forem visíveis (a folha sem espaço de assinatura é o mais notável), em vez de descrevê-los como se fossem o que a norma pede.

## Questões resolvidas

**O manual mostra as seis capas?** Não nesta change. Com esqueletos que não importam nada, cada PDF tem 4 a 6 páginas, e `\includegraphics[page=1]{build/modelo-tese.pdf}` mostraria saída real, sem ciclo de dependência — os esqueletos não dependem do manual. É a forma certa e fica disponível. Adiada por acoplamento: exige build em duas fases e quebra quando a paginação do esqueleto muda. Entra depois de os esqueletos estabilizarem.

**Vale fazer `\section` virar o nível de topo e desabilitar `\chapter`?** Não. Foi medido, e é mais barato do que parece — mas continua não valendo.

Já está pago o que costuma ser caro: `:445–447` já faz `\counterwithout{figure|table|equation}{chapter}`, então nada precisa ser reparentado; e `\tableofcontents`, `\listoffigures`, `\listoftables` e `\glossarysection` (`:1584–1625`) são artesanais, não chamam `\chapter*` e são indiferentes ao nível de topo. Apêndices e anexos têm contador próprio, nunca compartilhado com `\c@chapter` (`:1722–1734`) — restariam dois `\addcontentsline{toc}{chapter}` em `:1838` e `:1847`.

Sobrariam: deslocar `titlesec` (`:1576–1581`), com `\section` tendo de **aprender a quebrar página**, que hoje vem de graça do `\chapter`; deslocar `\l@chapter` (`:1639`); e recuperar o quarto nível numerado, que exigiria `secnumdepth=4`, `tocdepth=4`, `\titleformat{\paragraph}` e `\l@paragraph`, porque `\paragraph` não é numerado por padrão.

O que decide contra é o outro lado. O PDF sai **idêntico** nos dois desenhos — o rebaixamento é vocabulário de código-fonte, invisível ao leitor do trabalho. Em troca dele, todo documento existente quebra (`\chapter{}` deixa de existir), inclusive trabalho de aluno em andamento, e o modelo passa a remar contra a classe `book`, que é construída em torno do `\chapter` como unidade estrutural.

Descartado junto o meio-termo de definir `\secao{}` como fachada de `\chapter{}`: duas formas para a mesma coisa, e o manual teria de ensinar as duas — pior que qualquer um dos extremos.

A conclusão prática é a tarefa 3.8: o rebaixamento fica **explicado**, não eliminado.

**Um `latexmk` constrói tudo?** `.latexmkrc` manda saída para `build/`; `latexmk modelo-*.tex manual.tex` produz sete PDFs lá. Sem conflito de arquivos auxiliares — os nomes-base diferem. A tarefa é confirmar isso por execução, não por leitura.

## Questões em aberto

- **Onde ficam os `Preambulo/lista-*.tex`?** O manual os usa via `\subimport`. Os esqueletos, que não importam nada, precisam declarar siglas inline ou não declarar nenhuma. A decidir na implementação, com a mesma lógica do item 3.
