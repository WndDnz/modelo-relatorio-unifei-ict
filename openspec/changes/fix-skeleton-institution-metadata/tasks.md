## 1. Ligar o `\stateacronym`

- [x] 1.1 Fazer a capa imprimir a sigla ao lado da cidade (`:1213`, hoje `\MakeUppercase{\@location}` seguido do ano). A folha de rosto (`:1317`) continua com `\@state` por extenso.

  O metadado estava declarado em `:800-801`, documentado no manual e ligado a nada. Ver `design.md` §3.

## 2. Os seis arquivos de partida

- [x] 2.1 Declarar `\course` preenchido com valor de exemplo nos seis `modelo-<tipo>.tex`, como os demais metadados que o autor precisa trocar.
- [x] 2.2 Acrescentar `\institution`, `\faculty`, `\location`, `\state` e `\stateacronym` **comentados, com o padrão ao lado**, nos seis.

  O critério que separa os dois grupos: `\course` está errado para a maioria; os cinco estão certos para todos os que este modelo atende.
- [x] 2.3 Conferir que os seis continuam compilando sem edição, que é o requisito de `usage-guide` estabelecido por `add-type-skeletons`.

## 3. Verificar lendo a página

- [x] 3.1 Ler a **página 1** dos seis PDFs: a capa tem de trazer cidade e sigla, e nenhum curso — a capa nunca imprimiu curso.
- [x] 3.2 Ler a **página 2** dos seis: é a folha de rosto, e é ela que imprime curso e unidade. É aqui que a mudança de `\course` aparece.

  Olhar a página certa: o `Impact` da proposta dizia capa e folha de rosto, e `design.md` §2 corrige — `\@course` só é impresso em `:1235` e `\@faculty` só em `:1233`, os dois no bloco da folha de rosto.
- [x] 3.3 Compilar um dos seis com os cinco comentados descomentados e valores de outra instituição, confirmando que capa e folha de rosto respondem aos seis metadados.

## 4. Documentação

- [x] 4.1 **Corrigir `Capitulos/cap3/cap3.tex:65-69`**, que afirma que sem `\course` "a capa sai com o curso errado". A capa não imprime curso: quem sai errada é a folha de rosto. O defeito que o parágrafo descreve é real; a página que ele nomeia, não.
- [x] 4.2 Atualizar a linha de `\stateacronym` na tabela de metadados (`cap3.tex:57`) e o parágrafo de `ssc:metadados-padrao`, agora que a sigla é impressa na capa e deixou de ser comando sem efeito.
- [x] 4.3 Dizer no capítulo 3 que os arquivos de partida trazem os cinco comentados, e por quê — para que o autor do ICT saiba que não precisa mexer e o de outro campus saiba que pode.

## 5. Ao arquivar

- [ ] 5.1 Sincronizar o delta de `usage-guide`, cujo requisito dos arquivos de partida ganha o caso do metadado com padrão embutido — que não é exigido nem opcional, e por isso escapava da regra.

## Registro de aplicação

`\stateacronym` deixou de ser botão morto: a capa passa a imprimir "ITABIRA, MG" no lugar de "ITABIRA", e a folha de rosto segue com o estado por extenso. As duas formas estão comentadas no `.sty`, com o motivo da repartição, para que a próxima leitura não "uniformize" as duas.

Os seis arquivos de partida ganharam um bloco novo, "Instituição, unidade, curso e local", com `\course` declarado e os outros cinco comentados com o padrão ao lado. O bloco foi inserido antes da seção de resumo, e não junto dos metadados de aprovação: `modelo-dissertacao` e `modelo-tese` não têm `\notaaprovacao`, então não havia âncora comum ali.

Verificação, lendo as páginas:

- **Página 1** dos seis: a capa traz "ITABIRA, MG" e o ano, e nenhum curso — a capa nunca imprimiu curso.
- **Página 2** dos seis: a folha de rosto traz instituição, unidade e curso, e é onde a declaração de `\course` aparece. Sai "Nome do seu Curso" no lugar do padrão "Engenharia de Computação", que era o defeito.
- `modelo-tcc2` com os cinco descomentados e valores de outra instituição: capa "OURO PRETO, MS", folha de rosto "Escola de Engenharias" e "Ouro Preto, Minas Gerais do Sul, 24 de agosto de 2026". Os seis metadados respondem.
- Os seis compilam sem edição e mantêm a paginação.

Correção documental da tarefa 4.1: `Capitulos/cap3/cap3.tex` afirmava que sem `\course` "a capa sai com o curso errado". O defeito é real, a página nomeada não — quem sai errada é a folha de rosto. O parágrafo agora diz qual é, e diz também o que a capa imprime, para que a confusão não volte.
