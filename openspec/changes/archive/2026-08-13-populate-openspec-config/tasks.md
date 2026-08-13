## 1. Contexto do projeto

- [x] 1.1 Preencher `context:` com o que o projeto é: modelo LaTeX/XeLaTeX de trabalhos acadêmicos do ICT/Unifei, empacotado em `UnifeiICTReport.sty`, servindo seis tipos de documento selecionados por opção de pacote (`generico`, `estagio`, `tcc1`, `tcc2`, `dissertacao`, `tese`). Build por `latexmk` com `.latexmkrc` (`$pdf_mode = 5`, saída em `build/`).
- [x] 1.2 Listar as normas e o que cada uma cobre, para que nenhuma change volte a atribuir comportamento à norma errada: **NBR 14724:2024** trabalhos acadêmicos; **NBR 15287:2025** projeto de pesquisa (só `tcc1`); **NBR 6023:2018** elaboração de referências; **NBR 10520:2023** citações em documentos; **NBR 6027:2012** sumário; **NBR 6034:2004** índice. Registrar explicitamente o par que mais se confunde: 6023 é referência, 10520 é citação.

  **Resultado.** A distinção 6023/10520 ficou dita pelo objeto de cada uma, e não só pelo rótulo: "a 6023 rege a referência — a lista ao final, que descreve cada obra; a 10520 rege a citação — a remissão feita no corpo do texto". Foi essa confusão que produziu `fix-guide-errors`. Registrada também a Emenda 1 da 6023 (21.05.2025), para que ninguém a confunda com edição nova.

- [x] 1.3 Declarar o idioma: artefatos OpenSpec em **português** desde 2026-08-10. Os specs anteriores a essa data estão em inglês e aguardam migração — a mistura é conhecida e esperada, não é defeito a corrigir de passagem.
- [x] 1.4 Declarar que o CLI `openspec` **não está instalado** nesta máquina, e que os fluxos `/opsx:*` rodam à mão contra a árvore `openspec/`.
- [x] 1.5 Declarar a restrição de material: os PDFs em `.refs/` são normas ABNT **pagas**, com marca d'água de instituição terceira, e o repositório é público. Permanecem no `.gitignore` e nunca são versionados, citados por trecho longo, nem reproduzidos em artefato. CRÍTICO: são consultáveis localmente, o que faz a tentação aparecer justamente quando se quer precisão normativa.

## 2. Regras por artefato

- [x] 2.1 `rules.proposal`: nomear a norma (e o parágrafo, quando houver) que rege o comportamento proposto; declarar desvios deliberados na própria proposta, em vez de deixá-los implícitos na implementação.
- [x] 2.2 `rules.design`: numerar cada desvio da norma (D1, D2, …), citando o que a norma diz e por que o modelo diverge; espelhar cada um em comentário no ponto correspondente do `.sty`. A prática já existe — veio de `add-document-types` — e sobrevive só por memória.

  **Resultado.** Acrescentada uma terceira regra não prevista: registrar as alternativas descartadas junto da evidência que as descartou. Duas decisões desta sessão (minipages para as capas; `\section` como nível de topo) foram rejeitadas por medição, e sem o registro a pergunta volta sem os números que a fecharam.

- [x] 2.3 `rules.tasks`: toda tarefa que altera a saída do documento carrega a própria verificação, e a verificação **lê a página compilada** (rasterizada, ou `pdftotext`), não o log. Registrar o motivo junto da regra, senão ela vira ritual: neste projeto os defeitos característicos compilam limpo — `\,` engolindo pontuação, `--` que não vira travessão sob XeLaTeX/fontspec, código não-expansível dentro de `\the<contador>` corrompendo o `.aux`.
- [x] 2.4 `rules.tasks`: nomes de sequência de controle aceitam **apenas letras**. Dígitos em nome de macro (`\Unifei@tcc1`) não são erro de sintaxe — quebram de formas distantes e difíceis de ler. Daí `\Unifei@tmptccum` / `tmptccdois` no `.sty`, que sem esta nota parecem arbitrários e convidam a "simplificação".

  **Resultado.** Ficou em `context:`, junto dos demais casos de "compila limpo, imprime errado", e não em `rules.tasks`: é fato sobre o TeX, que vale para quem redige e para quem implementa, não instrução de como escrever uma tarefa. Em `rules.tasks` ficou a regra geral correspondente — marcar como CRÍTICO o que quebra longe da causa.

## 3. Orientação por operação

- [x] 3.1 `operations.apply.guidance`: conduzir à mão, sem CLI — marcar `- [ ]` → `- [x]` em `tasks.md` com nota curta do que foi de fato verificado, não do que foi escrito.

  **Resultado.** Acrescentada a permissão explícita de divergir do plano quando a investigação mostra que ele estava errado, desde que a divergência vá escrita no resultado com a razão. Aconteceu duas vezes nesta sessão (o escopo real de C4; a reordenação do bloco das divisões), e sem a regra o executor tende a cumprir o plano errado ao pé da letra.

- [x] 3.2 `operations.archive.guidance`: sincronizar os deltas para `openspec/specs/` à mão antes de mover a change para `openspec/changes/archive/AAAA-MM-DD-<nome>/`. Em delta `RENAMED`, conferir que o requisito renomeado ficou **na posição original** — renome aplicado como remoção mais adição é indistinguível no diff final e só aparece na ordem dos requisitos.
- [x] 3.3 `operations.archive.guidance`: cenário do delta que não restata um cenário existente é decisão, não detalhe de formatação — manter (traduzindo, se o requisito hospedeiro mudou de idioma) quando o comportamento continua verdadeiro; descartar apenas quando um requisito novo o substitui. Registrar o destino de cada um no `tasks.md` da change.

## 4. Fechamento

- [x] 4.1 Conferir que o YAML resultante é válido e que `schema: spec-driven` continua na primeira linha.

  **Resultado.** Validado com `yaml.safe_load`. Chaves de topo `schema`, `context`, `rules`, `operations`; `context` com 65 linhas; `rules` com 3/3/4 regras em `proposal`/`design`/`tasks`; `operations` com 2 e 3 orientações em `apply` e `archive`. A estrutura corresponde à documentada no boilerplate que ela substituiu.

- [x] 4.2 Remover os blocos de exemplo comentados que o conteúdo real substituiu, preservando os comentários que ainda documentam chaves não usadas.

  **Resultado.** Todos removidos: as quatro chaves que o boilerplate documentava (`context`, `rules`, `operations.apply`, `operations.archive`) passaram a ter conteúdo real, então não restou chave não usada a documentar. Cada bloco ficou com um comentário de uma linha no lugar.

- [x] 4.3 Verificar o efeito real: rodar `/opsx:propose` sobre uma change de teste e confirmar que o contexto aparece na redação dos artefatos. Descartar a change de teste em seguida. Sem isto, a única prova é que o arquivo tem texto.

  **Resultado — a tarefa estava mal formulada, e o teste não foi feito.** A injeção do `context`/`rules` acontece via `openspec instructions <artefato> --change <nome> --json`, e esse CLI **não existe nesta máquina**. Nada lê `config.yaml` automaticamente aqui: uma change de teste não provaria nada além de que os artefatos podem ser escritos sem o arquivo, que já se sabe — foi assim nas sete changes anteriores.

  O que dá para afirmar: o arquivo é YAML válido e sua estrutura corresponde exatamente à que o próprio boilerplate documentava e que a skill consome (`context`, `rules.<artefato>`, `operations.<operação>.guidance`). Enquanto o CLI não for instalado, `config.yaml` vale como **documento canônico de leitura obrigatória** por quem conduz o fluxo — não como mecanismo automático. O próprio `context:` diz que o CLI não está instalado, o que fecha o círculo para quem o ler.
