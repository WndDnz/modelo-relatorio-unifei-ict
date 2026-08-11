## 0. Ao arquivar

- [ ] 0.1 Conferir que o sync aplicou os três `RENAMED` de `approval-sheet` como renome, e não como remoção mais adição — é o primeiro delta `MODIFIED`/`RENAMED` deste repositório, então esse caminho do fluxo de sync nunca rodou aqui. Depois do sync, `approval-sheet` fica com três requisitos em português e dois em inglês; a mistura é esperada e só some na migração geral (ver design.md, "Idioma dos artefatos").

## 1. Seleção do tipo por opção de pacote

- [x] 1.1 Declarar os seis tipos com `\DeclareOption` explícito no bloco de opções (`UnifeiICTReport.sty:18–38`): `generico`, `estagio`, `tcc1`, `tcc2`, `dissertacao`, `tese`. CRÍTICO: o `\DeclareOption*` existente acumula opções desconhecidas em `\UnifeiICTReport@rawopts` e as repassa ao babel — um tipo não declarado vira erro de idioma, longe da causa real. **Resolvido com a forma `tipo=<valor>`** (ver design.md, "O tipo vai como chave"): a forma curta `[tcc1]` protegia só os seis valores exatos, e qualquer erro de digitação continuava vazando para o babel — reproduzido por compilação. A chave torna a intenção inequívoca. Os seis valores soltos seguem declarados, mas apenas para recusar com mensagem que ensina a forma certa.
- [x] 1.2 Guardar o tipo num estado interno consultável, com `generico` como padrão quando nenhuma opção de tipo é passada.
- [x] 1.3 Derivar do tipo os parâmetros que variam: layout (relatório / projeto / monografia), grau pretendido, obrigatoriedade de abstract e de área de concentração, e norma de referência.
- [x] 1.4 Verificar por compilação que um tipo inválido produz erro do próprio pacote nomeando os aceitos, e não erro do babel.
- [x] 1.5 Verificar que passar duas opções de tipo ao mesmo tempo falha de forma explícita, em vez de a última vencer silenciosamente.
- [x] 1.6 Quebra limpa dos valores antigos: `\folhaaprovacao` deixa de aceitar tipo por parâmetro. Ao receber um, falhar com mensagem que nomeia a nova forma (`\usepackage[<tipo>]{UnifeiICTReport}`) e os seis valores. CRÍTICO para `tcc`, que não é mapeável — ele se divide em `tcc1` e `tcc2`, regidos por normas diferentes, e adivinhar produziria um documento inteiro sob a norma errada sem erro algum. Ver design.md, "Quebra limpa".

## 2. Metadados novos

- [x] 2.1 Acrescentar grau pretendido, área de concentração e linha de pesquisa, com valores derivados ou declarados conforme o tipo.
- [x] 2.2 Exigir área de concentração em dissertação e tese, falhando com mensagem que nomeia o metadado ausente — seguindo o padrão de erro explícito que `\folhaaprovacao` já usa para tipo desconhecido.
- [x] 2.3 Aceitar área de concentração e linha de pesquisa como opcionais nos demais casos, sem emitir nada quando não declaradas.
- [x] 2.4 Permitir mais de um professor em `\supervisor`, separados por `\\`, reaproveitando a detecção que a capa já faz para os autores (`\IfSubStr` sobre o `\@author` detokenizado, que alterna entre "Autor" e "Autores"). Não inventar uma segunda convenção. Verificar que `\if@supervisorpresent` continua correto com valor múltiplo, e que a capa de quem declara um professor só não muda em nada.
- [x] 2.5 Derivar do tipo o rótulo do papel na capa e na folha de rosto, hoje fixo em "Orientador": `generico` → Professor/Professores; `estagio` e os quatro tipos de trabalho de conclusão → Orientador (e Coorientador quando declarado). Ver a tabela em design.md, "O rótulo do papel varia por tipo".

## 3. Folha de aprovação

- [x] 3.1 Fazer a folha consultar o tipo do documento em vez de receber parâmetro próprio, mantendo a decisão da tarefa 0.1 sobre os valores antigos.
- [x] 3.2 Remover as linhas de assinatura de todos os layouts (D1). `\Unifei@AssinaturaBloco` desenha `\rule{7cm}{0.4pt}` por signatário; a folha passa a registrar composição e data.
- [x] 3.3 Incluir o orientador na banca a partir de `\supervisor`, sem exigir um `\bancamembro` que o repita.
- [x] 3.4 Acrescentar o bloco do aluno estagiário ao relatório de estágio, que passa a ter três partes: estagiário, orientador e supervisor de campo.
- [x] 3.5 Emitir um bloco por professor no relatório genérico, quando houver mais de um.
- [x] 3.6 Suprimir a folha por completo no TCC1 sem banca, sem deixar página em branco nem entrada no sumário.
- [x] 3.7 Ajustar os textos de natureza por tipo, incluindo o do TCC1, que declara grau pretendido por ser requisito parcial para o título (D4) — contrariando a NBR 15287 §4.2.1.1(e) de propósito.
- [x] 3.8 Comentar no `.sty` a base de cada desvio (D1 a D4), como já é feito para os tipos contemplados pela norma, para que ninguém "corrija" depois o que está certo de propósito.

## 4. Resumos

- [x] 4.1 Tornar o abstract condicional: obrigatório em dissertação e tese (§4.2.1.8), opcional nos demais.
- [x] 4.2 Falhar com mensagem explícita quando dissertação ou tese não declarar abstract.
- [x] 4.3 Não emitir página nem cabeçalho de abstract quando ele é opcional e não foi declarado.
- [x] 4.4 Verificar que um documento que hoje declara os dois resumos continua produzindo os dois, em qualquer tipo.

## 5. Documentação e exemplo

- [x] 5.1 Documentar no `README.md` a tabela de tipos: norma de cada um, o que exige, o que é opcional e o que muda entre `tcc2`, `dissertacao` e `tese`.
- [x] 5.2 Documentar a estrutura textual que a NBR 15287 §4.2.2 prescreve para o TCC1 — tema, problema, hipóteses, objetivos, justificativa, referencial teórico, metodologia, recursos, cronograma — deixando claro que o modelo não gera os capítulos.
- [x] 5.3 Atualizar `modelo-relatorio.tex`: a opção no `\usepackage`, os metadados novos e a folha sem parâmetro, com comentário de como trocar de tipo.
- [x] 5.4 Registrar no README que apêndices e anexos já servem ao TCC1 sem alteração, já que a NBR 15287 §4.2.3.3/§4.2.3.4 usa a mesma regra da 14724.

## 6. Verificação

- [x] 6.1 Compilar `modelo-relatorio.tex` com `latexmk` em cada um dos seis tipos e confirmar build limpo nos seis.
- [x] 6.2 Conferir cada folha renderizada contra a composição esperada do seu tipo: professor(es); estagiário + orientador + supervisor de campo; orientador + externos.
- [x] 6.3 Confirmar visualmente que nenhuma folha, em nenhum tipo, desenha linha de assinatura.
- [x] 6.4 Confirmar que o TCC1 sem banca não produz folha nem página em branco, e que com banca produz.
- [x] 6.5 Confirmar que dissertação e tese falham sem área de concentração e sem abstract, com mensagens que nomeiam o que falta.
- [x] 6.6 Confirmar que TCC2 compila sem área de concentração e sem abstract.
- [x] 6.7 Confirmar que um relatório genérico com dois professores rende dois blocos na folha e, na capa, o rótulo pluralizado — e que com um professor só a capa fica idêntica à de hoje.
- [x] 6.9 Confirmar que o rótulo do papel muda conforme o tipo: "Professor" no genérico, "Orientador" nos demais.
- [x] 6.10 Confirmar que `\folhaaprovacao[tcc]` e `\folhaaprovacao[disciplina]` falham com mensagem que ensina a nova forma, em vez de compilar.
- [x] 6.8 Confirmar que ilustrações, legendas, apêndices e anexos seguem funcionando em todos os tipos — nada nesta change deveria tocá-los.
