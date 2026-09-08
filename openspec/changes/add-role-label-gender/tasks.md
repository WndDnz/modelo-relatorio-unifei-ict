## 1. Os metadados aceitam o gênero

- [x] 1.1 Dar argumento opcional a `\supervisor` (`:892`) e `\cosupervisor` (`:899`), guardando a cadeia de letras ao lado do valor. Padrão: cadeia vazia, que vale como tudo masculino.

  **Resultado.** Driver de teste `/tmp/opencode/sel-tcc2.tex` (cópia de `modelo-tcc2`) com `\supervisor[fm]{Prof. Dr. Nome Um\\Prof. Dra. Nome Dois}` e `\cosupervisor[f]{Prof. Dra. Nome da Coorientadora}`. `latexmk` exit 0, sem erro nem aviso. `pdftotext` da folha de rosto e da folha de aprovação: os dois nomes do orientador listados sob "ORIENTADORES" — a detecção de plural do `\AtBeginDocument` reagiu à cadeia com `\\` — e o bloco "COORIENTADOR" presente. A flexão do rótulo em si é tarefa 2. Não-regressão: `latexmk -g modelo-tcc2 modelo-generico modelo-estagio` exit 0, forma de chamada original sem argumento intacta.
- [x] 1.2 Idem para `\empresasupervisor` (`:917`).

  **Resultado.** Driver de teste `/tmp/opencode/sel-estagio.tex` (cópia de `modelo-estagio`) com `\empresasupervisor[f]{Nome da Supervisora na Empresa}`. `latexmk` exit 0, sem erro nem aviso; o nome sai na folha de aprovação do estágio (`pdftotext`). Chamada original sem argumento continua compilando (drivers de partida, exit 0).
- [x] 1.3 Redefinir `\author` com argumento opcional, preservando o que a classe `book` faz com o obrigatório. É a única redefinição de comando do núcleo nesta change — sem o argumento, o comportamento tem de ser o de hoje.

  **Resultado.** No mesmo `/tmp/opencode/sel-tcc2.tex`, `\author[f]{Autora Teste}` compila (`latexmk` exit 0) e "Autora Teste" sai na capa e na folha de rosto (`pdftotext`). A forma sem argumento preserva o comportamento de `book`: os três drivers de partida recompilados de cabeça com `latexmk -g` (exit 0, 0 erros em `build/*.log`) — nada mudou na chamada que os arquivos de partida usam.
- [x] 1.4 Escrever o seletor: dada a cadeia e a posição *i*, devolve `f` ou `m`, com `m` para posição além do fim da cadeia. Uma pessoa a mais que letras declaradas é masculina, e não erro — declarar gênero continua opcional.

  **Resultado.** `/tmp/opencode/selector.tex` (carrega `UnifeiICTReport` e chama o `\Unifei@generoseletor` real, via `\makeatletter`), `latexmk` exit 0, resultado lido por `pdftotext`. Todos os casos bateram com o especificado:

  | caso | cadeia | posição | observado |
  |---|---|---|---|---|
  | 1 | `f` | 1 | `f` |
  | 2 | `f` | 2 (além do fim) | `m` |
  | 3 | vazia | 1 | `m` |
  | 4 | vazia | 2 | `m` |
  | 5 | `fm` | 1 | `f` |
  | 6 | `fm` | 2 | `m` |
  | 7 | `fm` | 5 (além do fim) | `m` |
  | 8 | `ff` | 2 | `f` |

  Posição além do fim e cadeia vazia saem `m`, sem erro nem aviso — nenhum bug no seletor.

## 2. Os rótulos flexionam

- [x] 2.1 Acrescentar as formas femininas de `\Unifei@papel`/`\Unifei@papelplural` nos dois ramos que as definem (`:195-196` e `:216-217`): Orientadora/Orientadoras, Professora/Professoras. Pares literais — ver `design.md` §3.
- [x] 2.2 Estender o bloco de `\AtBeginDocument` (`:829-842`), que já resolve o plural, para resolver também o gênero de `\Unifei@papelrotulo` e `\Unifei@rotuloestagiario`. É o lugar que existe justamente porque o ponto de uso é hostil.
- [x] 2.3 Flexionar o rótulo de autor da capa (`:1508`): Autor/Autora/Autores/Autoras. Mesma detecção de plural que já está ali.
- [x] 2.4 Flexionar os rótulos por pessoa dentro de `\Unifei@RegistroPorProfessor` (`:1631-1641`): o laço já percorre os nomes, e passa a consultar a *i*-ésima letra. Atinge "Orientador" da banca (`:1742`), "Orientador acadêmico" do estágio (`:1704`) e o `\Unifei@papel\ da disciplina` do generico (`:1722`).
- [x] 2.5 Flexionar "Coorientador" nos dois sítios (`:1529` e `:1651`) e "Supervisor de campo" (`:1708`).

  **Resultado.** Decisão registrada: a folha de rosto mantém o rótulo de coorientador no singular, com flexão só de gênero (Coorientador/Coorientadora pela letra 1 da cadeia) — sem plural coletivo neste sítio (Coorientadores/Coorientadoras), para não mudar a saída de documentos sem gênero declarado. O plural coletivo continua restrito a `papel` (ORIENTADORES/ORIENTADORAS) e `autor` (AUTORES/AUTORAS), que já tinham forma plural antes. Driver `/tmp/opencode/red-cos.tex` com `\cosupervisor{Prof. A\\Prof. B}`: antes da correção imprimia "COORIENTADORES" (regressão vs. o singular fixo de antes); depois, "COORIENTADOR". A folha de aprovação não muda: segue o caminho por pessoa de `\Unifei@RegistroPorProfessor` (`:1811`), que flexiona individualmente.
- [x] 2.6 **Não** tocar em `\bancamembro`. Ver `design.md` §2: a titulação ali é texto livre, já escrito pelo autor no gênero certo.

## 3. Verificar lendo a página

- [x] 3.1 **A medição que motivou a change:** compilar `modelo-tcc2` com a linha do `\cosupervisor` do arquivo de partida descomentada e ler a folha de rosto e a folha de aprovação. Hoje sai "COORIENTADOR" sobre "Prof. Dra. Nome da Coorientadora"; o alvo é "COORIENTADORA", com `[f]`.

  **Resultado.** Driver `/tmp/opencode/s3/gate31-tcc2.tex` (cópia de `modelo-tcc2`, linha 59 descomentada como `\cosupervisor[f]{Prof. Dra. Nome da Coorientadora}`), `latexmk` exit 0. Capa (pág. 1) byte-idêntica à baseline (`md5sum` igual); folha de rosto (pág. 2) difere só no esperado: "COORIENTADORA" em versal sobre "Prof. Dra. Nome da Coorientadora", abaixo do bloco AUTOR/ORIENTADOR. Folha de aprovação (pág. 3): nome da coorientadora logo abaixo do orientador, com rótulo por pessoa "Coorientadora". Páginas 4–11 idênticas à baseline. Página a página, pág. 1 e 4–11 `SAME`; pág. 2–3 `DIFF` (o que a change deve mudar).
- [x] 3.2 Compilar um `generico` com `\supervisor[fm]{...\...}` e ler a folha de aprovação: dois blocos, "Professora da disciplina" num e "Professor da disciplina" no outro. É o caso que a decisão 1 do `design.md` existe para atender.

  **Resultado.** Driver `/tmp/opencode/s3/gate32-gen.tex` (cópia de `modelo-generico`) com `\supervisor[fm]{Prof. Dra. Nome da Professora\\Prof. Dr. Nome do Professor}`, `latexmk` exit 0. Folha de aprovação (pág. 3), lida por página: bloco "Prof. Dra. Nome da Professora" com "Professora da disciplina" sob ele; bloco "Prof. Dr. Nome do Professor" com "Professor da disciplina". Dois blocos, cada um flexionado pela sua letra da cadeia.
- [x] 3.3 Ler a capa desse mesmo documento: o rótulo coletivo sai "PROFESSORES", masculino plural, por ser grupo misto. Com `[ff]`, "PROFESSORAS".

  **Resultado.** Medi o rótulo coletivo no sítio onde ele existe de fato: o `generico` não imprime rótulo de papel na capa (capa = instituição, nome, título, local/ano — `UnifeiICTReport.sty:1567-1604`); o coletivo sai na folha de rosto, pág. 2 (`:1673`). No driver misto `[fm]` (o do 3.2): "PROFESSORES", masculino plural, junto dos dois nomes. No segundo driver `/tmp/opencode/s3/gate33-gen-ff.tex` (`\supervisor[ff]` sobre os mesmos dois nomes): "PROFESSORAS". O `[ff]` só venceu com todas as posições `f` (decisão 6). Nenhum outro sítio da capa/folha de rosto mudou.
- [x] 3.4 Compilar um `estagio` com autora e supervisora de campo: "Aluna estagiária", "Supervisora de campo", "Orientadora acadêmica".

  **Resultado.** Driver `/tmp/opencode/s3/gate34-estagio.tex` (cópia de `modelo-estagio`) com `\author[f]`, `\supervisor[f]` e `\empresasupervisor[f]`, `latexmk` exit 0. Folha de aprovação (pág. 3), os três blocos na ordem do estágio: "Aluna estagiária" sobre "Nome da Autora"; "Prof. Dra. Nome da Orientadora Acadêmica" com "Orientadora acadêmica"; "Nome da Supervisora" com "Supervisora de campo". Folha de rosto (pág. 2): "AUTORA" e "ORIENTADORA" em versal (flexão dentro do smallcaps); capa com "Nome da Autora".
- [x] 3.5 **A verificação de não-regressão:** rasterizar todas as páginas dos seis arquivos de partida e do `manual.tex` contra a baseline de `HEAD` e comparar por `md5sum`. Sem argumento opcional declarado, **tudo** tem de sair idêntico — é o que cobre a redefinição de `\author` da tarefa 1.3.

  **Resultado.** Baseline `git archive HEAD` extraída e compilada de cabeça em `/tmp/opencode/baseline` (os sete documentos, `latexmk -g`, todos exit 0). Árvore atual idem (exit 0, 0 erros em `build/*.log`). Rasterização `pdftoppm -r 100 -png` página a página, `md5sum` comparado: **106/106 páginas idênticas** — `SAME` em todas. Por documento:

  | doc | páginas | md5 |
  |---|---|---|
  | modelo-tcc1 | 8 | idênticas |
  | modelo-tcc2 | 11 | idênticas |
  | modelo-generico | 8 | idênticas |
  | modelo-estagio | 8 | idênticas |
  | modelo-dissertacao | 11 | idênticas |
  | modelo-tese | 11 | idênticas |
  | manual | 49 | idênticas |

  A redefinição de `\author` (1.3) e a resolução de rótulos não mudaram nenhum byte da saída sem argumento declarado. Nota de método: compilar fora da árvore sem copiar `Fontes/` (Exo2) faz o modelo sair com outra fonte em silêncio — qualquer remasterização futura precisa de `Fontes/` + `Logos/` ao lado do `.tex`; com isso presente, a reprodução é byte-idêntica.
- [x] 3.6 Confirmar que a flexão dentro de `\unifeismallcaps` não trava a compilação. O comentário de `:822-826` registra um laço infinito nesse mesmo ponto; a tarefa é medir, não confiar no desenho.

  **Resultado.** Quatro drivers de verificação atravessam `\unifeismallcaps` (versal das pág. 1–2): singular "COORIENTADORA", "AUTORA", "ORIENTADORA" e coletivos "PROFESSORES"/"PROFESSORAS" — todos `latexmk` exit 0, sem timeout nem travamento. Os sete documentos sem argumento, que também passam o mesmo comando de versal, exit 0. Nenhum laço; a flexão resolvida no `\AtBeginDocument` (`:829-905`) sai como macro simples no ponto de uso, como o `:822-834` prescreve.

## 4. Documentação

- [ ] 4.1 Documentar o argumento opcional no capítulo 3, onde os quatro comandos já são apresentados, com exemplo de um nome e de vários. Regra de Platina: comando público que ganha argumento entra documentado e exemplificado.
- [ ] 4.2 Corrigir o exemplo de `Capitulos/cap3/cap3.tex:128-130`, que hoje declara uma coorientadora e produz "Coorientador". Passa a trazer `[f]` — o exemplo é a primeira coisa que o autor copia.
- [ ] 4.3 Atualizar a tabela de comandos de `Capitulos/cap3/cap3.tex:48-50`, que descreve os quatro sem mencionar o argumento.
- [ ] 4.4 Levar `[f]` para a linha comentada do `\cosupervisor` nos arquivos de partida que a trazem, junto da explicação — o arquivo de partida é onde o autor descobre que a opção existe.
- [ ] 4.5 Registrar no manual que o grupo misto leva o rótulo coletivo ao masculino plural, e por quê. Sem isso parece defeito.

## 5. Ao arquivar

- [ ] 5.1 Sincronizar o delta de `document-type`, que ganha o requisito da flexão dos rótulos de pessoa.
- [ ] 5.2 Decidir se o rótulo de autor da capa deve migrar para capability própria. Hoje `document-type` é a dona por ser a única que fala em rótulo de pessoa, mas "Autor" não deriva do tipo — a capa o imprime igual nos seis. Se `add-optional-elements` criar `pretextual-elements`, é candidato natural.
