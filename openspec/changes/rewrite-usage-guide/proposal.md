## Why

O texto do modelo vive hoje uma ambiguidade que não se sustenta mais: ele finge ser um relatório exemplar e, ao mesmo tempo, é o único manual que o pacote tem. Os três capítulos alternam conteúdo fictício com meta-comentário sobre o próprio modelo — `cap1.tex` explica como escrever uma introdução *e* declara que o objetivo geral do trabalho é apresentar o modelo; `cap3.tex` conclui um trabalho que não existe. Nenhum aluno consegue usá-lo como ponto de partida sem primeiro apagar metade dele.

Enquanto isso, a documentação ficou **duas changes atrás da implementação**. `add-approval-sheet-and-appendices` e `add-document-types` entregaram, entre as duas, seis tipos de documento, a folha de aprovação derivada do tipo, apêndices e anexos, banca examinadora, área de concentração, linha de pesquisa, múltiplos professores em `\supervisor` e abstract de obrigatoriedade variável. Praticamente nada disso aparece no guia. O modelo passou a atender dissertação e tese sem que uma linha do texto explique como.

Isso não foi descuido: foi ausência de regra. Nenhuma change até hoje teve como tarefa verificável "documentar o que esta change entrega", porque não havia capability que exigisse isso. Sem uma, a próxima change reabre a mesma dívida.

E o modelo único não cobre mais o que ele promete. Seis tipos de documento produzem seis capas, seis naturezas e cinco folhas de aprovação distintas; um `modelo-relatorio.tex` com `tipo=generico` mostra uma delas.

## What Changes

**O guia assume ser o manual.** Deixa de simular um relatório. Os três capítulos atuais dão lugar a sete, e o `cap2.tex` monolítico de 493 linhas deixa de existir:

```
1  Introdução                    o que é, para quem, os seis tipos e como escolher
2  Preparando o ambiente         TeX Live, xelatex, fontes, latexmk,
                                 organização em pastas × arquivo único
3  Estrutura do documento        frontmatter/mainmatter/backmatter, ordem
                                 pré-textual, capa, folha de rosto, folha de
                                 aprovação, resumos
4  Escrevendo o texto            divisões, rótulos, \refcomp, citações, notas
5  Ilustrações, tabelas, equações  (o material atual, que é a parte boa)
6  Elementos pós-textuais        referências, apêndices, anexos, listas, glossário
7  Conclusão
```

O **capítulo 3 é o novo centro de gravidade**: é onde mora tudo que as duas changes entregaram sem documentar, e é o capítulo que hoje simplesmente não existe.

**Seis esqueletos, um por tipo** — `modelo-generico.tex`, `modelo-estagio.tex`, `modelo-tcc1.tex`, `modelo-tcc2.tex`, `modelo-dissertacao.tex`, `modelo-tese.tex` — cada um com a opção de tipo já posta, os metadados que aquele tipo exige presentes e os opcionais comentados com a explicação ao lado.

**Os esqueletos não importam nada, de propósito.** Não são drivers amputados: são a demonstração do outro modo de trabalhar. O aluno escreve as seções direto no arquivo. O manual mostra a organização em pastas com `\subimport`; os esqueletos mostram o arquivo único. Cada um ensina pelo próprio corpo, e **a estrutura do manual é o exemplo da organização em pastas** — não há um terceiro artefato de exemplo a manter sincronizado.

Consequência que precisa de tratamento: `\listoffigures` e `\listoftables` (`UnifeiICTReport.sty:1595–1605`) emitem título incondicionalmente, sem guarda para lista vazia. Um esqueleto sem nenhuma figura sairia com uma página "LISTA DE ILUSTRAÇÕES" e nada embaixo. Nos esqueletos as listas saem **comentadas**, com a explicação ao lado — que é o que `modelo-relatorio.tex` já faz para `\listofquadros` e `\listofgraficos`.

**Divisão de papéis entre README e PDF:** o PDF dá as instruções detalhadas; o README apresenta o modelo, diz qual esqueleto copiar e aponta para o PDF. O que hoje está duplicado nos dois — a tabela de tipos, os metadados, o resumo de macros — passa a viver só no PDF.

**A capability `usage-guide`** transforma "o guia ficou para trás" de acidente recorrente em item conferível: nasce exigindo que todo comando oferecido ao autor esteja documentado, que afirmação normativa nomeie a norma que efetivamente rege, e que exista um esqueleto por tipo que compile sem edição.

## Capabilities

### New Capabilities

- `usage-guide`: o que o manual precisa cobrir e com que fidelidade; a existência de um esqueleto por tipo de documento; e a divisão de papéis entre README e PDF.

## Fora de escopo

- **A galeria de capas.** Com esqueletos que não importam nada, cada um compila em 4 a 6 páginas, e o manual poderia mostrar as seis variantes com `\includegraphics[page=1]{build/modelo-tcc2.pdf}` — saída real, incapaz de divergir. É a forma certa e continua disponível; fica para depois de os esqueletos estabilizarem, para esta change não carregar acoplamento de build junto com a reescrita toda.
- **Os erros do texto atual** (norma errada nas citações, vocabulário de divisões contraditório, `\LaTeX\,`): change `fix-guide-errors`, que roda antes desta. O texto corrigido é o que a reescrita herda.
- **Os elementos pré-textuais ausentes** — dedicatória, agradecimentos, epígrafe, errata, lombada, índice. A NBR 14724:2024 os lista e o pacote não os oferece. O manual **declara a ausência** em vez de silenciar; implementá-los é change própria.
- `cover-and-title`, que moverá o requisito de subtítulo para fora de `approval-sheet`.

## Impact

- `Capitulos/`: `cap1`, `cap2`, `cap3` dão lugar a sete capítulos. Maior reescrita de texto do repositório até hoje.
- Seis arquivos `modelo-*.tex` novos na raiz. `modelo-relatorio.tex` passa a ser o driver do manual — a decidir em design.md se é renomeado.
- `README.md`: encolhe; perde o que passou ao PDF.
- `referencias.bib`: as referências fictícias servem aos exemplos de citação e permanecem; conferir que o aviso de que são falsas sobreviva à reescrita.
- Sem alteração em `UnifeiICTReport.sty`. A guarda para lista vazia seria melhoria real do pacote e está registrada como tal, mas esta change contorna comentando as chamadas, e não mexe no código.
