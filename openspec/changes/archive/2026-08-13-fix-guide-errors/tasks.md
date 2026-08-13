## 1. Citações: a norma certa (C1)

- [x] 1.1 Acrescentar a entrada `nbr10520:2023` a `referencias.bib`, no padrão das entradas ABNT vizinhas (`nbr6023:2018`, `nbr14724:2024`): `@manual`, `author = {{Associação Brasileira de Normas Técnicas}}` com chaves duplas, `title = {NBR 10520}`, `subtitle` com o título real da norma, `location = {Rio de Janeiro}`, `number`, `year = {2023}`. Conferir o título exato em `.refs/NBR_10520_2023.pdf` em vez de reconstruí-lo de memória.

  **Resultado.** Título conferido no PDF: *Informação e documentação — Citações em documentos — Apresentação*, segunda edição, 19.07.2023. Entrada inserida logo após `nbr6023:2018`.

- [x] 1.2 Reescrever `cap2.tex:134–137`. A frase atual atribui as citações em texto à NBR 6023:2018 e escorrega para "referências bibliográficas" na mesma oração. Separar as duas: **citação no documento** é NBR 10520:2023; **elaboração das referências** é NBR 6023:2018. Manter a citação à 6023 onde ela de fato se aplica — a change corrige a atribuição, não remove a norma.

  **Resultado.** A frase passou a nomear as duas normas com o objeto de cada uma, fechando com a distinção em uma linha: "Uma diz como citar; a outra, como descrever o que foi citado." A 6023 continua citada, no lugar certo.

- [x] 1.3 Verificar por compilação que `\cite{nbr10520:2023}` resolve, que o nome institucional sai inteiro ("Associação Brasileira de Normas Técnicas", sem inversão nem fragmento) e que a entrada aparece na lista de referências. É exatamente o que `bibliography-accuracy` exige das entradas ABNT.

  **Resultado.** Citação resolve como "(Associação Brasileira de Normas Técnicas, 2023)". Na lista de referências: "ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. NBR 10520: Informação e documentação -- Citações em documentos -- Apresentação. Rio de Janeiro, 2023." Nome inteiro, sem inversão.

## 2. Nomes das divisões: uma fonte de verdade só (C4)

- [x] 2.1 Reescrever o `itemize` de `cap2.tex:66–90` para ensinar os nomes que o pacote imprime, com o comando LaTeX entre parênteses — Seção (`\chapter`), Subseção (`\section`), Subsubseção (`\subsection`), Parágrafo (`\subsubsection`). A cascata autoritativa está em `UnifeiICTReport.sty:303–306`; copiar dela, não redigitar. CRÍTICO: o texto atual ensina o oposto, e a lista de `:110–115` já ensina o certo — o guia hoje se contradiz na mesma seção.

  **Resultado.** O bloco foi reordenado, não só corrigido: o rebaixamento passou a ser **ensinado antes** de os nomes serem usados. Primeiro a razão normativa e a tabela de correspondência, depois as diretrizes por nível — que agora trazem o nome ABNT em negrito com o comando entre parênteses. Na ordem anterior, o leitor encontrava os nomes vinte linhas antes da explicação deles.

- [x] 2.2 Ajustar a frase introdutória de `:62–63`, que descreve o modelo como organizado "em capítulos, seções e subseções". "Capítulo" é justamente o nome que o pacote elimina, porque a NBR 14724:2024 não admite a divisão em capítulos — o que o próprio guia afirma em `:106`.

- [x] 2.3 Eliminar a lista de `:110–115` como fonte concorrente, agora que `2.1` incorporou o conteúdo dela. Preservar a justificativa normativa de `:106–108` (por que os níveis são nomeados um degrau abaixo do comando) — ela explica a decisão e não deve sumir junto com a lista.

  **Resultado.** Lista e justificativa foram movidas para a abertura da seção, onde a justificativa passou a citar a NBR 14724:2024 (4.2.2) explicitamente. Restou uma única fonte de verdade sobre os nomes.

- [x] 2.4 Manter os prefixos de rótulo `cap:`, `sec:`, `ssc:`, `sss:` inalterados, reapresentando-os como mnemônico do **comando**, não do nome ABNT. Ver proposal.md, "Decisões". Não renomear: nada no código lê o prefixo, e renomear quebraria todo rótulo já escrito.

  **Resultado.** O desalinhamento passou a ser dito em voz alta, em vez de deixado para o leitor tropeçar: "os prefixos de rótulo sugeridos são mnemônicos do **comando**, e não do nome impresso --- por isso `ssc:` marca aquilo que o documento chama de Subsubseção".

- [x] 2.5 Corrigir `cap2.tex:100–101`, que afirma que o nome da divisão é determinado "a partir do rótulo". `\refcomp` resolve pelo `\autoref`, que usa o **contador** do elemento referenciado (`UnifeiICTReport.sty:943–948`). O prefixo do rótulo não entra na decisão — a redação atual ensina um modelo mental que leva o aluno a esperar que renomear um rótulo mude o nome impresso.

  **Resultado.** Passou a dizer "a partir do **contador** do elemento referenciado, e não do primeiro argumento nem do texto do rótulo", com a consequência explícita ("renomear um rótulo não muda o nome impresso") e a ligação com o rebaixamento, que é onde ele fica visível.

- [x] 2.6 Verificar por compilação, lendo a página gerada: o `\subsection{Subsubseção de exemplo}` de `:95` deve sair rotulado como Subsubseção, e `\refcomp{}{ssc:exemplo}` deve imprimir "Subsubseção N - ...". Conferir que o texto novo e a saída concordam, que é o defeito que esta seção corrige.

  **Resultado.** `\refcomp{}{ssc:exemplo}` imprime "Subsubseção 2.3.1 - Subsubseção de exemplo"; `\refcomp{}{sss:exemplo}` imprime "Parágrafo 2.3.1.1 - Parágrafo de exemplo". Texto e saída concordam. Página rasterizada e lida: o `itemize` reescrito, mais longo, não gerou viúva nem estouro de margem.

## 3. Vírgulas engolidas pelo espaço fino (C2)

- [x] 3.1 Trocar `\LaTeX\,` por `\LaTeX,` em `cap2.tex:19`, `:31` e `:363`. `\,` é o comando de espaço fino: a vírgula pretendida nunca chega ao documento, e sai um espaço no lugar dela.
- [x] 3.2 Varrer os demais arquivos de texto (`Capitulos/`, `Preambulo/`, `modelo-relatorio.tex`) atrás do mesmo padrão — uma sequência de controle seguida de `\,` onde o contexto pede pontuação. Corrigir o que aparecer; o erro é de digitação e não tem motivo para estar só em `cap2.tex`.

  **Resultado.** Varredura por `\<cs>\,` em todos os `.tex` fora de `build/`: nenhuma ocorrência restante no repositório. As três estavam mesmo confinadas ao `cap2.tex`.

- [x] 3.3 Verificar na página compilada que as três vírgulas aparecem. Compilação limpa não prova nada aqui: o texto errado sempre compilou sem aviso — é o que o torna o modo de falha característico deste projeto.

  **Resultado.** As três presentes no PDF: "completa do LATEX, usando", "diferente do LATEX,", "oficial do LATEX, na CTAN".

## 4. Erros de digitação (C3)

- [x] 4.1 `cap2.tex:22` — "TeX Live ." tem espaço antes do ponto final.
- [x] 4.2 `cap2.tex:23` — "As fontes utilizadas no modulo são" → "no modelo".
- [x] 4.3 `cap2.tex:27` — "famíla Plex" → "família Plex".
- [x] 4.4 `cap2.tex:169` — "sem apas" → "sem aspas".
- [x] 4.5 NÃO corrigir "compreenssão" em `:180`: a grafia está errada de propósito, marcada `[grafia errada no original]`, dentro de um exemplo de citação literal. Conferir que ela sobreviveu à passagem do corretor ortográfico.

  **Resultado.** Os quatro corrigidos e conferidos no PDF. "compreenssão" sobreviveu, ocorrência única, intacta.

## 5. Fechamento

- [x] 5.1 Compilar `modelo-relatorio.tex` do zero (`latexmk -C` antes) e ler as páginas alteradas rasterizadas, não apenas o log. Todo defeito desta change compila limpo hoje.

  **Resultado.** Compilação limpa, 32 páginas, sem erro. `build/modelo-relatorio.pdf` atualizado e conferido.

  **Nota de ambiente.** A primeira tentativa falhou com `xdvipdfmx:fatal: Unable to open "build/modelo-relatorio.pdf"` — o arquivo estava travado por um visualizador aberto, e sobreviveu inclusive ao `latexmk -C`. A verificação foi feita então em diretório separado (`-outdir`/`-auxdir`). Depois de destravado, `latexmk` sozinho ainda respondia "Nothing to do": o `.fdb_latexmk` já registrava os fontes como processados, porque só o passo de escrita do PDF havia falhado. `latexmk -g` força as regras e resolve. Vale lembrar em qualquer compilação futura deste repositório.

- [x] 5.2 Conferir que nenhuma ocorrência de "NBR 6023" restou atribuída a citações em texto, e que a NBR 10520 aparece citada ao menos uma vez no corpo do guia.

  **Resultado.** Zero ocorrências da construção antiga. A NBR 10520 aparece uma vez no corpo (§2.4, Citações) e uma vez na lista de referências.

## Achado registrado, fora de escopo

`.refs/NBR_6023_2025.pdf` é a **Emenda 1** (`ABNT NBR 6023:2018/Em1:2025`, 11 páginas), verificado no próprio PDF — não é edição nova. A entrada `nbr6023:2018` está correta e `bibliography-accuracy` não está sendo violada. Fica em aberto se a emenda alterou regra que os exemplos de referência do modelo ainda seguem na forma antiga: exige ler as 11 páginas contra `referencias.bib`.
