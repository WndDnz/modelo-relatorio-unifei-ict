## 1. Os metadados aceitam o gênero

- [ ] 1.1 Dar argumento opcional a `\supervisor` (`:892`) e `\cosupervisor` (`:899`), guardando a cadeia de letras ao lado do valor. Padrão: cadeia vazia, que vale como tudo masculino.
- [ ] 1.2 Idem para `\empresasupervisor` (`:917`).
- [ ] 1.3 Redefinir `\author` com argumento opcional, preservando o que a classe `book` faz com o obrigatório. É a única redefinição de comando do núcleo nesta change — sem o argumento, o comportamento tem de ser o de hoje.
- [ ] 1.4 Escrever o seletor: dada a cadeia e a posição *i*, devolve `f` ou `m`, com `m` para posição além do fim da cadeia. Uma pessoa a mais que letras declaradas é masculina, e não erro — declarar gênero continua opcional.

## 2. Os rótulos flexionam

- [ ] 2.1 Acrescentar as formas femininas de `\Unifei@papel`/`\Unifei@papelplural` nos dois ramos que as definem (`:195-196` e `:216-217`): Orientadora/Orientadoras, Professora/Professoras. Pares literais — ver `design.md` §3.
- [ ] 2.2 Estender o bloco de `\AtBeginDocument` (`:829-842`), que já resolve o plural, para resolver também o gênero de `\Unifei@papelrotulo` e `\Unifei@rotuloestagiario`. É o lugar que existe justamente porque o ponto de uso é hostil.
- [ ] 2.3 Flexionar o rótulo de autor da capa (`:1508`): Autor/Autora/Autores/Autoras. Mesma detecção de plural que já está ali.
- [ ] 2.4 Flexionar os rótulos por pessoa dentro de `\Unifei@RegistroPorProfessor` (`:1631-1641`): o laço já percorre os nomes, e passa a consultar a *i*-ésima letra. Atinge "Orientador" da banca (`:1742`), "Orientador acadêmico" do estágio (`:1704`) e o `\Unifei@papel\ da disciplina` do generico (`:1722`).
- [ ] 2.5 Flexionar "Coorientador" nos dois sítios (`:1529` e `:1651`) e "Supervisor de campo" (`:1708`).
- [ ] 2.6 **Não** tocar em `\bancamembro`. Ver `design.md` §2: a titulação ali é texto livre, já escrito pelo autor no gênero certo.

## 3. Verificar lendo a página

- [ ] 3.1 **A medição que motivou a change:** compilar `modelo-tcc2` com a linha do `\cosupervisor` do arquivo de partida descomentada e ler a folha de rosto e a folha de aprovação. Hoje sai "COORIENTADOR" sobre "Prof. Dra. Nome da Coorientadora"; o alvo é "COORIENTADORA", com `[f]`.
- [ ] 3.2 Compilar um `generico` com `\supervisor[fm]{...\...}` e ler a folha de aprovação: dois blocos, "Professora da disciplina" num e "Professor da disciplina" no outro. É o caso que a decisão 1 do `design.md` existe para atender.
- [ ] 3.3 Ler a capa desse mesmo documento: o rótulo coletivo sai "PROFESSORES", masculino plural, por ser grupo misto. Com `[ff]`, "PROFESSORAS".
- [ ] 3.4 Compilar um `estagio` com autora e supervisora de campo: "Aluna estagiária", "Supervisora de campo", "Orientadora acadêmica".
- [ ] 3.5 **A verificação de não-regressão:** rasterizar todas as páginas dos seis arquivos de partida e do `manual.tex` contra a baseline de `HEAD` e comparar por `md5sum`. Sem argumento opcional declarado, **tudo** tem de sair idêntico — é o que cobre a redefinição de `\author` da tarefa 1.3.
- [ ] 3.6 Confirmar que a flexão dentro de `\unifeismallcaps` não trava a compilação. O comentário de `:822-826` registra um laço infinito nesse mesmo ponto; a tarefa é medir, não confiar no desenho.

## 4. Documentação

- [ ] 4.1 Documentar o argumento opcional no capítulo 3, onde os quatro comandos já são apresentados, com exemplo de um nome e de vários. Regra de Platina: comando público que ganha argumento entra documentado e exemplificado.
- [ ] 4.2 Corrigir o exemplo de `Capitulos/cap3/cap3.tex:128-130`, que hoje declara uma coorientadora e produz "Coorientador". Passa a trazer `[f]` — o exemplo é a primeira coisa que o autor copia.
- [ ] 4.3 Atualizar a tabela de comandos de `Capitulos/cap3/cap3.tex:48-50`, que descreve os quatro sem mencionar o argumento.
- [ ] 4.4 Levar `[f]` para a linha comentada do `\cosupervisor` nos arquivos de partida que a trazem, junto da explicação — o arquivo de partida é onde o autor descobre que a opção existe.
- [ ] 4.5 Registrar no manual que o grupo misto leva o rótulo coletivo ao masculino plural, e por quê. Sem isso parece defeito.

## 5. Ao arquivar

- [ ] 5.1 Sincronizar o delta de `document-type`, que ganha o requisito da flexão dos rótulos de pessoa.
- [ ] 5.2 Decidir se o rótulo de autor da capa deve migrar para capability própria. Hoje `document-type` é a dona por ser a única que fala em rótulo de pessoa, mas "Autor" não deriva do tipo — a capa o imprime igual nos seis. Se `add-optional-elements` criar `pretextual-elements`, é candidato natural.
