## 1. Obrigatoriedade derivada do tipo

- [ ] 1.1 Declarar duas flags no bloco de despacho de tipo (`:152-158`), no molde de `\if@unifei@areaobrig` e `\if@unifei@absobrig`: uma para o orientador, verdadeira em `estagio`, `tcc1`, `tcc2`, `dissertacao` e `tese`; outra para o supervisor de campo, verdadeira só em `estagio`.

  `generico` é o único tipo com orientador opcional, porque atende manual, memorial e outros documentos sem professor responsável. Ver `design.md` §1.
- [ ] 1.2 Acrescentar os dois blocos de cobrança ao `\AtBeginDocument` existente (`:870-889`), junto dos de área de concentração e abstract. Mensagem no mesmo molde: nomear o comando que falta e o parágrafo da norma que o exige.

  **Não** cobrar fora do `\AtBeginDocument`. O comentário de `:866-869` registra por quê: cobrar antes de o preâmbulo ter sido lido acusa falta de metadado que o autor declara duas linhas abaixo.

## 2. Guarda e emissão

- [ ] 2.1 Guardar `:1461` — o bloco do `generico` — com `\if@supervisorpresent`. Sem professor declarado, nem bloco nem rótulo.

  É o **único** sítio que precisa de guarda: `:1450`, `:1451` e `:1497` ficam cobertos pelo erro da tarefa 1.2 e nunca rodam com valor vazio. Ver `design.md` §4. Não escrever quatro guardas.
- [ ] 2.2 Emitir o coorientador na folha de aprovação, logo abaixo do orientador, quando `\if@cosupervisorpresent` for verdadeira. A flag existe desde `:814-816` e hoje só é consultada em `:1279-1287`, na folha de rosto.

  São três sítios que emitem orientador (`:1450`, `:1461`, `:1497`). Considerar um auxiliar que emita orientador-mais-coorientador de uma vez, em lugar de repetir a condicional três vezes.
- [ ] 2.3 **Não** tocar no comportamento de `\bancamembro` com campos em branco. É deliberado e documentado em `approval-sheet/spec.md:135-136` — serve à folha preparada antes de os nomes serem conhecidos. Deixar comentário no código dizendo que a exceção é intencional, para que a próxima leitura não a "conserte".

## 3. Verificar lendo a página

- [ ] 3.1 Compilar `manual.tex` sem `\supervisor` e ler a **página 3**. O rótulo "Professor da disciplina" sobre linha vazia, que é o defeito original, tem de ter sumido — e o documento tem de compilar, porque o manual é `generico`.
- [ ] 3.2 Compilar cada um dos cinco tipos obrigatórios sem `\supervisor` e confirmar que a compilação **para**, com a mensagem nomeando o metadado. Cinco compilações, cinco mensagens.
- [ ] 3.3 Compilar `modelo-estagio.tex` sem `\empresasupervisor` e confirmar o mesmo.
- [ ] 3.4 Compilar um tipo com banca declarando `\cosupervisor` e **ler a folha de aprovação**: orientador, coorientador e membros externos, nessa ordem, cada um com o seu rótulo.
- [ ] 3.5 Confirmar que nenhum documento que declare `\supervisor` mudou de saída. Os seis arquivos de partida declaram; comparar as folhas antes e depois.

## 4. Documentação

- [ ] 4.1 Acrescentar a obrigatoriedade por tipo à subseção "O rótulo do professor vem do tipo" (`Capitulos/cap3/cap3.tex:84-91`). Ela hoje explica que o rótulo deriva do tipo e não diz que em cinco dos seis a ausência interrompe a compilação.
- [ ] 4.2 Dizer, na mesma subseção ou junto da lista de quem assina a folha (`cap3.tex:113-117`), que o coorientador passa a constar da folha de aprovação quando declarado.
- [ ] 4.3 Remover de `manual.tex` a nota que justifica o `\supervisor` declarado. Ela existe porque deixá-lo em branco produzia o rótulo órfão; depois desta change o manual, que é `generico`, pode ficar sem ele. Decidir na hora se a linha sai ou fica como registro de autoria — a nota é que não faz mais sentido.

## 5. Ao arquivar

- [ ] 5.1 Sincronizar o delta de `approval-sheet` e conferir que o requisito do rótulo sem nome convive com o cenário do `\bancamembro` em branco, sem se contradizerem.
- [ ] 5.2 Registrar em change própria, se ainda não houver, a ausência de flexão de gênero nos rótulos — `design.md` a documenta como limitação pré-existente e fora deste escopo.
