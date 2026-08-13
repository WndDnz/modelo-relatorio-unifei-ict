## 1. Implementação

- [x] 1.1 Acrescentar `\@unifei@absobrigtrue` ao ramo `tcc2` da cascata de tipos (`UnifeiICTReport.sty:192–195`), ao lado de `\@unifei@monografiatrue` e `\@unifei@combancatrue`. A validação de `:870–878` já existe e passa a alcançar o `tcc2` sem qualquer alteração — a mensagem de erro que ela emite já cita o §4.2.1.8.

  **Resultado.** Uma linha. A validação existente alcançou o `tcc2` sem nenhuma alteração, como previsto, e a mensagem que ela emite já cita o parágrafo certo.

- [x] 1.2 Comentar no ramo a base normativa, como os demais ramos já fazem para suas decisões: o TCC2 é monografia completa e a NBR 14724:2024 §4.1 marca o resumo em língua estrangeira como obrigatório sem qualificar por tipo de trabalho.
- [x] 1.3 Comentar no ramo `tcc1` por que ele **não** recebe o mesmo tratamento: é projeto de pesquisa, regido pela NBR 15287:2025, em cujo texto a palavra *resumo* não ocorre. CRÍTICO: sem essa nota, o próximo leitor da cascata vê `tcc1` e `tcc2` lado a lado com tratamentos diferentes e "uniformiza" — que é exatamente o erro que os comentários de D1–D4 existem para evitar.

  **Resultado.** O comentário do `tcc1` começa por nomear a ausência ("SEM `\@unifei@absobrigtrue`, ao contrário do tcc2 logo abaixo") antes de justificá-la, e termina com a instrução explícita de não uniformizar. Uma ausência não chama atenção sozinha; precisa ser declarada para ser lida como decisão.

## 2. Verificação

- [x] 2.1 Compilar um documento `tipo=tcc2` **sem** `\abstractseclang` e confirmar que a compilação para com o erro do pacote, nomeando o comando que falta e citando o §4.2.1.8 — e não com um erro genérico do LaTeX, nem com um documento completo em silêncio.

  **Resultado.** Compilação interrompida com `Package UnifeiICTReport Error: Falta o resumo em língua estrangeira`, nomeando `\abstractseclang{...}` e o §4.2.1.8. Erro do pacote, não do LaTeX.

- [x] 2.2 Compilar um documento `tipo=tcc2` **com** `\abstractseclang` e ler a página do abstract rasterizada: o resumo em língua estrangeira sai, com suas palavras-chave, na forma que `dissertacao` e `tese` já produzem.

  **Resultado.** Compila (exit 0). Página 4 rasterizada e lida: título ABSTRACT centralizado na fonte institucional em azul, texto do resumo e linha `Keywords:` — a mesma forma da página RESUMO que a precede.

- [x] 2.3 Compilar `tipo=tcc1` sem `\abstractseclang` e confirmar que **continua compilando**, sem erro e sem página em branco no lugar do abstract. É a metade da decisão que não deve ter mudado, e a que uma edição desatenta na cascata quebraria.
- [x] 2.4 Confirmar que `generico` e `estagio` seguem compilando sem abstract. Os três tipos que não mudam precisam ser exercitados, não presumidos: a alteração é numa cascata de `\ifx` onde ramos vizinhos se parecem.

  **Resultado.** `tcc1`, `generico` e `estagio` compilaram sem erro e sem abstract. Além disso, `modelo-relatorio.tex` (que é `generico`) reconstruiu com **263.144 bytes**, exatamente o mesmo tamanho de antes da alteração — o driver do repositório não foi tocado pela mudança.

  **Nota de método.** O primeiro teste do `tcc2` com abstract falhou, e a causa era o meu gerador de arquivos de teste, não o pacote: um `sed` consumiu o `\a` de `\abstractseclang`, produzindo `bstractseclang`. Vale como lembrete de que um teste que falha acusa primeiro o próprio teste.

## 3. Documentação

- [x] 3.1 Corrigir a linha `tcc2` da tabela "o que muda entre eles" no `README.md`, que diz *opcional* na coluna abstract. Conferir que a linha `dissertacao · tese` continua coerente com ela depois da mudança.
- [x] 3.2 Conferir que nenhuma outra passagem do `README.md` afirma que o abstract é opcional no TCC2 — a tabela não é necessariamente o único lugar.

  **Resultado.** Havia mesmo um segundo lugar: a descrição de `\makeabstracts` no resumo de macros dizia "Em `dissertacao` e `tese` ele é obrigatório". Reescrita para os três tipos de monografia, com a razão de o `tcc1` ficar de fora. A frase da linha 92, que fala em obrigatoriedade variável sem enumerar tipos, continua correta e não precisou mudar.

## 4. Ao arquivar

- [x] 4.1 Sincronizar o delta `MODIFIED` para `openspec/specs/document-type/spec.md`, substituindo o requisito homônimo **na posição em que ele já está** (é o sexto dos sete). Segundo delta `MODIFIED` do repositório; ver `openspec/config.yaml`, `operations.archive`.

  **Resultado — o delta estava incompleto, e a conferência do sync foi o que revelou.** O requisito *Os três tipos de monografia compartilham o layout mas não o comportamento* (terceiro dos sete) afirmava que TCC2, dissertação e tese diferem "no grau pretendido e na obrigatoriedade de abstract e de área de concentração". Depois desta change eles **não diferem mais** quanto ao abstract, e a spec ficaria se contradizendo a três requisitos de distância.

  Em vez de emendar a spec principal por fora do rastro, o delta da change foi corrigido primeiro, passando a restatar os dois requisitos, e só então sincronizado. O `proposal.md` foi atualizado junto: sua seção de capabilities citava só um dos dois.

  Sync conferido: sete requisitos, mesma ordem, alvos ainda na 3ª e na 6ª posição; zero ocorrências das formulações antigas.

- [x] 4.2 Conferir que o cenário novo — *Projeto de pesquisa não é exceção aberta* — entrou junto, e que os três cenários restatados substituíram os antigos em vez de se somarem a eles.

  **Resultado.** O requisito ficou com 4 cenários — os 3 restatados mais o novo —, e não 7. Substituição, não soma.
