## Why

O modelo atende seis tipos de documento e oferece **um** arquivo de partida: `modelo-relatorio.tex`, com `tipo=generico`. Quem vai escrever uma dissertação copia o relatório de disciplina e descobre sozinho o que precisa mudar — a opção do pacote, a área de concentração que passa a ser exigida, os membros de banca, o abstract obrigatório. Nada disso aparece até a compilação falhar, e algumas dessas diferenças não falham: produzem um documento sob a natureza errada, em silêncio.

Pior: esse único arquivo de partida é também o documento de exemplo, cheio de conteúdo de demonstração — figuras, tabelas, apêndices, referências fictícias. Não é um ponto de partida; é um documento pronto que precisa ser esvaziado antes de servir.

Seis tipos de documento produzem seis capas, seis naturezas e cinco folhas de aprovação distintas. Um arquivo mostra uma delas.

## What Changes

Seis arquivos novos na raiz — `modelo-generico.tex`, `modelo-estagio.tex`, `modelo-tcc1.tex`, `modelo-tcc2.tex`, `modelo-dissertacao.tex`, `modelo-tese.tex` — cada um com:

- a opção `tipo=` já declarada;
- os metadados **exigidos** por aquele tipo preenchidos com valor de exemplo, e os **opcionais** comentados com a explicação ao lado;
- um esboço mínimo de seções escrito direto no corpo do arquivo;
- as listas (`\listoffigures`, `\listoftables`, `\listofquadros`, `\listofgraficos`) e os glossários **comentados**, com a razão ao lado;
- `\printbibliography` e a declaração do arquivo `.bib` **comentados**, com a instrução de criar o próprio arquivo de referências.

**Os esqueletos não importam nada, e isso é a decisão central.** Não são drivers amputados: são a demonstração da segunda forma de trabalhar. O aluno escreve as seções direto no arquivo. O manual — que se organiza em `Capitulos/` — demonstra a primeira. Cada um ensina pelo próprio corpo, sem que nenhum artefato de exemplo precise ser mantido em sincronia.

Duas coisas ficam comentadas por um motivo que vale registrar, porque é o mesmo nos dois casos: **conteúdo de demonstração não pode vazar para dentro do ponto de partida.**

- As listas, porque `UnifeiICTReport.sty:1595–1605` não tem guarda para lista vazia — descomentadas, um esqueleto sem nenhuma figura emite uma página com o título "LISTA DE ILUSTRAÇÕES" e nada abaixo, na primeiríssima compilação do aluno.
- A bibliografia, porque `referencias.bib` é **fictício de propósito**, com referências falsas que servem aos exemplos do manual. Um esqueleto apontando para ele entrega ao aluno um trabalho com bibliografia inventada.

## Capabilities

### New Capabilities

- `usage-guide`: nasce aqui, com o requisito que governa os arquivos de partida — um por tipo, compilando sem edição. Os requisitos sobre o conteúdo do manual entram na change `rewrite-usage-guide`, que os escreve.

## Fora de escopo

- **O manual.** Change `rewrite-usage-guide`, irmã desta. As duas não dependem uma da outra: o manual menciona os esqueletos, mas não consome nada deles.
- **A galeria de capas no manual** (`\includegraphics[page=1]{build/modelo-tese.pdf}`), que espera justamente estes esqueletos estabilizarem.
- **A guarda para lista vazia no `.sty`.** É a correção de raiz e beneficiaria qualquer documento real cujo autor esqueça de comentar; aqui ela é contornada, não resolvida. Change própria.

## Impact

- Seis arquivos `.tex` novos na raiz.
- `.latexmkrc` não muda: `$out_dir` já é `build/`, e os nomes-base distintos evitam conflito de auxiliares — a confirmar por execução, não por leitura.
- `modelo-relatorio.tex` **não é tocado** nesta change. Ele vira `manual.tex` na change do manual.
- `README.md` não é tocado: sua reestruturação pertence à change do manual, e mexer nele aqui criaria conflito entre as duas.
- Sem alteração em `UnifeiICTReport.sty`.
