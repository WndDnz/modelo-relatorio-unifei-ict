## Contexto

O modelo passou a atender seis tipos de documento, regidos por duas normas diferentes, mas seu texto continua sendo três capítulos que oscilam entre relatório fictício e manual. Com os arquivos de partida criados em `add-type-skeletons`, o texto deixa de precisar fazer os dois papéis: esta change decide o que ele passa a ser.

## Decisões

### 1. `manual.tex` e `modelo-<tipo>.tex` — nomes que dizem o papel

`modelo-relatorio.tex` vira **`manual.tex`**: é o documento que se lê, não o que se copia.

Mantê-lo chamado `modelo-relatorio.tex` ao lado de seis `modelo-*.tex` faria dele o sétimo arquivo de partida aos olhos de quem chega — e é o único da raiz que ninguém deve copiar. O nome carrega a distinção que o README teria de explicar.

`manual.tex` compila com `tipo=generico`: o manual precisa de um tipo, e o genérico é o que menos promete sobre si mesmo.

### 2. O manual descreve as seis formas; não as desenha

Compilando como `generico`, o manual mostra **uma** capa e **uma** folha de aprovação, enquanto o capítulo 3 documenta seis e cinco. Com a galeria adiada, essa distância é consequência aceita.

Ela precisa estar registrada porque a reação natural de quem escrever o capítulo 3 é compensar — desenhar as outras capas à mão para ilustrar. **Não deve.** Uma capa desenhada para ilustração é uma segunda implementação do layout: compila limpo e passa a divergir da real na primeira change que toque a capa de verdade. É exatamente o motivo pelo qual as `minipage` foram rejeitadas quando esta change foi concebida.

Até a galeria existir, o capítulo 3 **descreve em prosa e em tabela** o que muda por tipo, e remete aos arquivos de partida: quem quiser ver a capa de tese compila `modelo-tese.tex`, que existe e é curto.

### 3. README apresenta, PDF instrui

Hoje a tabela de tipos, os metadados e o resumo de macros existem **nos dois**, e já divergiram uma vez — a obrigatoriedade do abstract no `tcc2` teve de ser corrigida em dois lugares do README, e um deles quase passou. Duplicação de documentação não envelhece parelha.

O README passa a: dizer o que é o modelo, listar os seis tipos em uma linha cada, dizer qual arquivo copiar, dizer como compilar, e apontar para o manual. Todo o resto vive no PDF, que é onde há espaço para a justificativa normativa — e onde o exemplo pode ser mostrado compilado ao lado do código que o produz, coisa que Markdown não faz.

### 4. Sete capítulos, e por que o terceiro é o mais importante

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

### 5. A estrutura do manual é o exemplo

O manual se organiza em `Capitulos/`, uma pasta por capítulo, e demonstra `\subimport` em uso. Os arquivos de partida, completos em um arquivo só, demonstram a alternativa. As duas formas de trabalhar ficam documentadas por artefato existente e compilável, e nenhum exemplo extra precisa ser mantido em sincronia.

Isso impõe uma exigência à estrutura escolhida em 4: ela precisa ser defensável **como estrutura de trabalho**, e não apenas como índice de manual — porque é ela que o leitor vai copiar.

### 6. A ausência é documentada

A NBR 14724:2024 lista dedicatória, agradecimentos, epígrafe, errata, lombada e índice; o pacote não oferece nenhum. O capítulo 3 declara isso, em vez de deixar o leitor concluir que o modelo é completo — quem precisa de agradecimentos numa dissertação precisa saber, antes de escrever, que terá de improvisar.

Documentar a ausência é o que mantém a lista viva como escopo de trabalho futuro. Silenciar sobre ela a apaga.

### 7. A instrução sobre o `.bib` aparece nos dois lugares, em formas diferentes

Os arquivos de partida trazem, junto da chamada comentada, a instrução de criar o próprio arquivo de referências. O manual traz a mesma matéria em forma longa: por que o `referencias.bib` do repositório é fictício, como criar o próprio, e como declará-lo.

Isso **não contradiz** a decisão 3. O que o README não pode fazer é duplicar tratamento detalhado; o esqueleto dá a instrução mínima no ponto de uso, onde ela é acionável, e o manual dá o porquê. São registros diferentes do mesmo assunto, não a mesma explicação escrita duas vezes.

## Desvios registrados

Nenhum novo. Esta change não altera comportamento do pacote e não diverge de norma alguma. Os desvios D1–D4 seguem valendo, registrados em `add-document-types`, e o capítulo 3 deve **explicá-los ao leitor** onde forem visíveis — a folha sem espaço de assinatura é o mais notável —, em vez de descrevê-los como se fossem o que a norma pede.

O rebaixamento de níveis (`\chapter` → Seção) **não é desvio**: é como o modelo cumpre a NBR 14724:2024 §4.2.2 usando uma classe que fala outro vocabulário. O manual precisa distinguir as duas coisas, senão o leitor conclui que o modelo diverge da norma onde ele a obedece.

## Questões resolvidas

**Vale fazer `\section` virar o nível de topo e desabilitar `\chapter`?** Não. Foi medido, e é mais barato do que parece — mas continua não valendo.

Já está pago o que costuma ser caro: `UnifeiICTReport.sty:445–447` já faz `\counterwithout{figure|table|equation}{chapter}`, então nada precisa ser reparentado; e `\tableofcontents`, `\listoffigures`, `\listoftables` e `\glossarysection` são artesanais, não chamam `\chapter*` e são indiferentes ao nível de topo. Apêndices e anexos têm contador próprio, nunca compartilhado com `\c@chapter` — restariam dois `\addcontentsline{toc}{chapter}`.

Sobrariam: deslocar `titlesec`, com `\section` tendo de **aprender a quebrar página**, que hoje vem de graça do `\chapter`; deslocar `\l@chapter`; e recuperar o quarto nível numerado, que exigiria `secnumdepth=4`, `tocdepth=4`, `\titleformat{\paragraph}` e `\l@paragraph`, porque `\paragraph` não é numerado por padrão.

O que decide contra é o outro lado. O PDF sai **idêntico** nos dois desenhos — o rebaixamento é vocabulário de código-fonte, invisível ao leitor do trabalho. Em troca dele, todo documento existente quebra (`\chapter{}` deixa de existir), inclusive trabalho de aluno em andamento, e o modelo passa a remar contra a classe `book`, construída em torno do `\chapter` como unidade estrutural.

Descartado junto o meio-termo de definir `\secao{}` como fachada de `\chapter{}`: duas formas para a mesma coisa, e o manual teria de ensinar as duas — pior que qualquer um dos extremos.

A conclusão prática é a tarefa 2.8: o rebaixamento fica **explicado**, não eliminado.
