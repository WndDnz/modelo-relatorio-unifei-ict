## 1. Ligar o `\stateacronym`

- [ ] 1.1 Fazer a capa imprimir a sigla ao lado da cidade (`:1213`, hoje `\MakeUppercase{\@location}` seguido do ano). A folha de rosto (`:1317`) continua com `\@state` por extenso.

  O metadado estava declarado em `:800-801`, documentado no manual e ligado a nada. Ver `design.md` §3.

## 2. Os seis arquivos de partida

- [ ] 2.1 Declarar `\course` preenchido com valor de exemplo nos seis `modelo-<tipo>.tex`, como os demais metadados que o autor precisa trocar.
- [ ] 2.2 Acrescentar `\institution`, `\faculty`, `\location`, `\state` e `\stateacronym` **comentados, com o padrão ao lado**, nos seis.

  O critério que separa os dois grupos: `\course` está errado para a maioria; os cinco estão certos para todos os que este modelo atende.
- [ ] 2.3 Conferir que os seis continuam compilando sem edição, que é o requisito de `usage-guide` estabelecido por `add-type-skeletons`.

## 3. Verificar lendo a página

- [ ] 3.1 Ler a **página 1** dos seis PDFs: a capa tem de trazer cidade e sigla, e nenhum curso — a capa nunca imprimiu curso.
- [ ] 3.2 Ler a **página 2** dos seis: é a folha de rosto, e é ela que imprime curso e unidade. É aqui que a mudança de `\course` aparece.

  Olhar a página certa: o `Impact` da proposta dizia capa e folha de rosto, e `design.md` §2 corrige — `\@course` só é impresso em `:1235` e `\@faculty` só em `:1233`, os dois no bloco da folha de rosto.
- [ ] 3.3 Compilar um dos seis com os cinco comentados descomentados e valores de outra instituição, confirmando que capa e folha de rosto respondem aos seis metadados.

## 4. Documentação

- [ ] 4.1 **Corrigir `Capitulos/cap3/cap3.tex:65-69`**, que afirma que sem `\course` "a capa sai com o curso errado". A capa não imprime curso: quem sai errada é a folha de rosto. O defeito que o parágrafo descreve é real; a página que ele nomeia, não.
- [ ] 4.2 Atualizar a linha de `\stateacronym` na tabela de metadados (`cap3.tex:57`) e o parágrafo de `ssc:metadados-padrao`, agora que a sigla é impressa na capa e deixou de ser comando sem efeito.
- [ ] 4.3 Dizer no capítulo 3 que os arquivos de partida trazem os cinco comentados, e por quê — para que o autor do ICT saiba que não precisa mexer e o de outro campus saiba que pode.

## 5. Ao arquivar

- [ ] 5.1 Sincronizar o delta de `usage-guide`, cujo requisito dos arquivos de partida ganha o caso do metadado com padrão embutido — que não é exigido nem opcional, e por isso escapava da regra.
