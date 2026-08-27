## 1. O texto passa a existir uma vez só

- [x] 1.1 Renomear `\Unifei@NaturezaFolhaRosto` para `\Unifei@Natureza` (`:836`) e atualizar a chamada da folha de rosto (`:1528`). O nome antigo vira mentira assim que a folha de aprovação também o usar.
- [x] 1.2 Substituir os três textos duplicados de `\Unifei@FolhaAprovacaoCorpo` (`:1676-1741`) por uma chamada única de `\Unifei@FolhaAprovacaoNatureza{\Unifei@Natureza}`, logo após `\Unifei@FolhaAprovacaoCabecalho`. Os ramos `\if@unifei@*` ficam, com os blocos de registro e os `\vfill` — só a natureza sai deles.
- [x] 1.3 Levar o comentário D4 (`:1717-1718`) para junto do texto do `tcc1` no macro compartilhado. Ele marca um desvio normativo declarado no manual; perdê-lo num refactor é o modo silencioso de um desvio deixar de ser deliberado.
- [x] 1.4 Corrigir o comentário de `:834-835`, que hoje afirma que o texto está "mantido em um só lugar" quando está em dois. Depois de 1.2 ele passa a ser verdade — dizer o que garante, e que só passou a garantir agora.

## 2. A concordância

- [x] 2.1 Definir `\def\Unifei@trabalhoapresentado{}` junto de `\Unifei@grau` (`:187`) e acrescentá-lo à lista de macros do cabeçalho (`:160-172`).
- [x] 2.2 Preencher nos três ramos de monografia do despacho (`:231-256`): `Trabalho de Conclusão de Curso apresentado` no `tcc2`, `Dissertação apresentada` na `dissertacao`, `Tese apresentada` na `tese`. Substantivo e particípio na mesma cadeia — é isso que a change compra.
- [x] 2.3 Trocar o `\ifdefstring` aninhado do ramo `\if@unifei@monografia` (`:850-856`) pelo macro. O que resta é `\Unifei@trabalhoapresentado\ como requisito parcial para obtenção do título de \Unifei@grau\ em \@subject.`
- [x] 2.4 **Não** tocar nos textos de `estagio`, `generico` e `tcc1`. Ver `design.md` D1: substantivo e particípio já estão na mesma cadeia literal, e estão certos por construção.

## 3. Verificar lendo a página

- [x] 3.1 Ler a folha de rosto e a folha de aprovação de `modelo-tcc2`. Alvo: "Trabalho de Conclusão de Curso **apresentado**" nas duas.
- [x] 3.2 Ler as mesmas duas páginas de `modelo-dissertacao` e `modelo-tese`. Elas estavam certas antes e têm de continuar — "Dissertação apresentada", "Tese apresentada".
- [x] 3.3 Confirmar que a decisão 2 do `design.md` não mexeu na página: rasterizar a folha de aprovação dos seis tipos contra a baseline de `HEAD` (`git archive HEAD | tar -x` num diretório à parte) e comparar por `md5sum`. Tudo idêntico, exceto o `modelo-tcc2`, onde a única diferença é a palavra. Este é o teste da deduplicação, e o único capaz de flagrar um `\vfill` perdido no caminho.
- [x] 3.4 Compilar `manual.tex`. É `tipo=generico` e não deve mudar em nada; se mudar, a hoisting da natureza mexeu no que não devia.

## 4. Documentação

- [x] 4.1 Nada a documentar no manual pela Regra de Platina: nenhum comando público nasce, muda de assinatura ou de comportamento observável pelo autor. O texto da natureza é gerado, e o manual não o reproduz em lugar nenhum — conferido em `Capitulos/` e nos seis arquivos de partida. Registrar aqui que a conferência foi feita, para que a ausência de mudança no manual não pareça esquecimento.

## 5. Ao arquivar

- [ ] 5.1 Sincronizar o delta de `document-type`, cujo requisito dos três tipos de monografia ganha a exigência de concordância.
- [ ] 5.2 Conferir que `add-role-label-gender` continua sendo outra coisa: lá o gênero é de uma pessoa e precisa ser declarado; aqui é do substantivo que o tipo escolhe. Se as duas changes convergirem para um mecanismo só, é sinal de que uma delas está resolvendo o problema errado.

## Registro de aplicação

As duas decisões do `design.md` valeram como escritas. `\Unifei@trabalhoapresentado` entrou no bloco
de despacho ao lado de `\Unifei@grau`, e a folha de aprovação passou a chamar `\Unifei@Natureza` uma
vez, antes dos ramos.

**Um passo a mais que as tarefas não previam.** Tirada a natureza de dentro dos ramos, os de
`\if@unifei@projeto` e `\if@unifei@monografia` ficaram literalmente idênticos — `\vfill`,
`\Unifei@RegistroBanca`, `\vfill`. `\if@unifei@combanca` é exatamente a união dos dois, e passou a
substituí-los. Dois ramos idênticos lado a lado são metade de um refactor, e a comparação de
páginas cobre o risco.

**Verificação (tarefa 3.3), o número que importa:** das 57 páginas dos seis arquivos de partida,
**55 saíram idênticas à baseline de `HEAD`**, bit a bit no rasterizado a 100 dpi. As duas que
diferem são a folha de rosto e a folha de aprovação do `modelo-tcc2`, e a diferença é a palavra.
O `manual.pdf`, 49 páginas, saiu idêntico. A deduplicação não mexeu numa vírgula da saída.

O `tcc1` não tem folha de aprovação nos arquivos de partida — a folha é facultativa (D3) e o
esqueleto não declara banca —, então a natureza do projeto de pesquisa foi conferida só na folha de
rosto. O caminho da folha de aprovação do `tcc1` é o mesmo código dos outros cinco.
