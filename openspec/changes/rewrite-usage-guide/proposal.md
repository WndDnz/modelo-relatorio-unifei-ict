## Why

O texto do modelo vive hoje uma ambiguidade que não se sustenta mais: ele finge ser um relatório exemplar e, ao mesmo tempo, é o único manual que o pacote tem. Os três capítulos alternam conteúdo fictício com meta-comentário sobre o próprio modelo — `cap1.tex` explica como escrever uma introdução *e* declara que o objetivo geral do trabalho é apresentar o modelo; `cap3.tex` conclui um trabalho que não existe.

Enquanto isso, a documentação ficou **duas changes atrás da implementação**. `add-approval-sheet-and-appendices` e `add-document-types` entregaram, entre as duas, seis tipos de documento, a folha de aprovação derivada do tipo, apêndices e anexos, banca examinadora, área de concentração, linha de pesquisa, múltiplos professores em `\supervisor` e abstract de obrigatoriedade variável. Praticamente nada disso aparece no guia. O modelo passou a atender dissertação e tese sem que uma linha do texto explique como.

Isso não foi descuido: foi ausência de regra. Nenhuma change até hoje teve como tarefa verificável "documentar o que esta change entrega", porque não havia capability que exigisse isso. Sem uma, a próxima change reabre a mesma dívida.

## What Changes

**O guia assume ser o manual.** Deixa de simular um relatório — agora que os arquivos de partida existem em change própria, ele não precisa mais fazer os dois papéis. Os três capítulos atuais dão lugar a sete, e o `cap2.tex` monolítico de 493 linhas deixa de existir:

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

**`modelo-relatorio.tex` vira `manual.tex`.** É o documento que se lê, não o que se copia — e com seis `modelo-<tipo>.tex` na raiz, o nome antigo o faria parecer um sétimo arquivo de partida.

**A estrutura do manual é o exemplo.** Ele se organiza em `Capitulos/` e demonstra `\subimport`; os arquivos de partida, completos em um arquivo só, demonstram a alternativa. As duas formas ficam documentadas por artefato compilável, e nenhum exemplo extra precisa ser mantido em sincronia.

**Divisão de papéis entre README e PDF:** o PDF dá as instruções detalhadas; o README apresenta o modelo, diz qual arquivo copiar e aponta para o PDF. O que hoje está duplicado nos dois — a tabela de tipos, os metadados, o resumo de macros — passa a viver só no PDF.

**`usage-guide` ganha seus requisitos de conteúdo.** A capability nasce em `add-type-skeletons`, governando os arquivos de partida; aqui entram os quatro requisitos sobre o manual — que todo comando oferecido ao autor esteja documentado, que afirmação normativa nomeie a norma que efetivamente rege, que as duas formas de organizar arquivos estejam demonstradas, e que README e manual não se dupliquem.

## Capabilities

### Modified Capabilities

- `usage-guide`: ganha quatro requisitos sobre o conteúdo do manual e a divisão de papéis com o README. O requisito sobre os arquivos de partida, criado em `add-type-skeletons`, não é tocado.

## Dependências

Depende de **`add-type-skeletons`**, mas apenas para referenciá-los: o manual aponta os seis arquivos de partida como exemplo da organização em arquivo único, e o requisito correspondente exige que ambas as demonstrações existam. Nenhum conteúdo é consumido deles. Se a ordem se inverter, as passagens que os citam ficam sem referente.

Depende de **`fix-guide-errors`** (já arquivada): o capítulo 5 herda o texto atual quase intacto, e herdá-lo antes da correção reintroduziria a norma errada nas citações em arquivo novo, onde ninguém procura.

## Fora de escopo

- **Os arquivos de partida**, criados em `add-type-skeletons`.
- **A galeria de capas.** Com os esqueletos existindo e sendo curtos, `\includegraphics[page=1]{build/modelo-tese.pdf}` mostraria saída real, incapaz de divergir, e sem ciclo de dependência. É a forma certa e fica disponível — adiada para não carregar acoplamento de build junto com a reescrita toda. Ver "Decisões" sobre o que o manual faz nesse meio-tempo.

  **Mapa de páginas, conferido nos seis PDFs:** capa em 1, folha de rosto em 2, folha de aprovação em 3 — **exceto no `tcc1`**, que não a emite quando não há `ancamembro` declarado, e cuja página 3 é o resumo. Quem construir a galeria trata esse caso; assumir a página 3 uniformemente produz uma "folha de aprovação" de tese que é o resumo do projeto de pesquisa, e o defeito compila limpo. Os esqueletos saíram com 8 páginas (`generico`, `estagio`, `tcc1`) e 11 (`tcc2`, `dissertacao`, `tese`), entre 118 e 122 KB — curtos e baratos de incluir.
- **Os elementos pré-textuais ausentes** — dedicatória, agradecimentos, epígrafe, errata, lombada e índice. A NBR 14724:2024 os lista e o pacote não os oferece. O manual **declara a ausência** em vez de silenciar; implementá-los é change própria.
- `cover-and-title`, que moverá o requisito de subtítulo para fora de `approval-sheet`.

## Decisões

**O manual descreve as seis formas; não as desenha.** Ele compila como `tipo=generico`, então o leitor vê uma capa e uma folha de aprovação, enquanto o capítulo 3 documenta seis e cinco. Sem a galeria, essa distância é consequência aceita — e precisa estar dita, porque quem implementar o capítulo 3 vai sentir a falta e tentar compensar desenhando os exemplos à mão.

Não deve. Uma capa desenhada à mão para ilustração é uma segunda implementação do layout: compila limpo e passa a divergir da real na primeira change seguinte que toque a capa. É o mesmo motivo pelo qual as `minipage` foram rejeitadas. Até a galeria existir, o manual **descreve em prosa e tabela** o que muda por tipo.

## Impact

- `Capitulos/`: `cap1`, `cap2`, `cap3` dão lugar a sete capítulos. Maior reescrita de texto do repositório até hoje.
- `modelo-relatorio.tex` → `manual.tex`, com `git mv`.
- `README.md`: encolhe; perde o que passou ao PDF.
- `referencias.bib`: as referências fictícias servem aos exemplos de citação do manual e permanecem; conferir que o aviso de que são falsas sobreviva à reescrita.
- Sem alteração em `UnifeiICTReport.sty`.
