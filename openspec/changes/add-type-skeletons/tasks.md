## 1. Os seis arquivos

- [x] 1.1 Criar `modelo-generico.tex`, `modelo-estagio.tex`, `modelo-tcc1.tex`, `modelo-tcc2.tex`, `modelo-dissertacao.tex`, `modelo-tese.tex`, cada um com `tipo=` já declarado e **sem nenhum `\subimport`** — o esqueleto é a demonstração do documento em arquivo único (design.md, decisão 2).

  **Resultado.** Seis arquivos, nenhum `\subimport`. Também ficaram de fora `import`, `lipsum`, `fancyvrb`, `subcaption` e `booktabs`, que o driver atual carrega para os exemplos do manual e que um ponto de partida não precisa.

- [x] 1.2 Em cada um, trazer **preenchidos com valor de exemplo** os metadados que aquele tipo exige, e **comentados com explicação ao lado** os opcionais. Consultar `openspec/specs/document-type/spec.md` para a matriz, não a memória: área de concentração exigida em `dissertacao` e `tese`, opcional em `tcc2`; abstract obrigatório nos três tipos de monografia (`tcc2` inclusive, desde a change `require-abstract-tcc2`) e opcional nos demais; banca ausente no `generico`; `\bancamembro` só para os membros externos, porque o orientador já entra por `\supervisor`.

  **Resultado.** Um metadado não previsto pela matriz apareceu na leitura do `.sty`: `\empresasupervisor`, que só o `estagio` usa — é o supervisor de campo, terceira parte da folha de aprovação daquele tipo (`UnifeiICTReport.sty:1451`). Entrou preenchido no esqueleto do estágio e em nenhum outro.

  Também ficou claro que `\subject` significa coisas diferentes por tipo: disciplina em `generico` e `estagio`, curso em `tcc1` e `tcc2`, programa de pós-graduação em `dissertacao` e `tese` (`:771–786`). O valor de exemplo de cada esqueleto reflete isso.

- [x] 1.3 Escrever no corpo de cada um o esboço mínimo de seções, direto no arquivo. No `tcc1`, seguir a estrutura textual que a NBR 15287:2025 §4.2.2 prescreve — tema, problema, hipóteses, objetivos, justificativa, referencial teórico, metodologia, recursos e cronograma —, que `document-type` documenta mas não gera.
- [x] 1.4 Nenhum conteúdo de demonstração: sem `\lipsum`, sem figuras de amostra, sem apêndices de exemplo. O esqueleto é ponto de partida, não documento pronto a ser esvaziado.

## 2. O que fica comentado, e por quê

- [x] 2.1 Comentar `\listoffigures`, `\listoftables`, `\listofquadros` e `\listofgraficos` em todos os seis. CRÍTICO: `UnifeiICTReport.sty:1595–1605` não tem guarda para lista vazia — descomentado, um esqueleto sem figuras emite página de título seguida de nada, na primeira compilação do aluno.
- [x] 2.2 Comentar `\printbibliography` **e** a declaração do arquivo `.bib`. Comentar só a impressão deixaria o `referencias.bib` fictício declarado e processado pelo biber, sem benefício. CRÍTICO: as referências desse arquivo são falsas de propósito, e uma bibliografia inventada não é visualmente óbvia como uma lista vazia é — o aluno pode entregar sem perceber.

  **Resultado.** O `\usepackage[style=abnt]{biblatex}` também saiu comentado, junto dos outros dois. Carregar o biblatex sem nenhum recurso declarado só produziria aviso sem serventia, e deixá-lo ativo sugeriria que a bibliografia está configurada quando não está. As três linhas formam um bloco único, com a instrução acima delas.

- [x] 2.3 Junto do bloco da bibliografia, escrever a instrução de **criar o próprio arquivo `.bib`**: qual comando o declara, onde o arquivo fica, e que ele começa vazio. Esta instrução é a contrapartida de não apontar para o arquivo fictício — sem ela, o esqueleto apenas esconde o assunto.
- [x] 2.4 Declarar inline uma sigla de exemplo comentada e manter os `\printglossary` comentados ao lado, em vez de importar `Preambulo/lista-*.tex` (design.md, questões resolvidas). Importar contraria a decisão 2, e imprimir glossário vazio repete o problema das listas.

  **Resultado.** `\makeglossaries` e um `\newacronym` de exemplo, ambos comentados, no mesmo bloco. `\makeglossaries` precisa ir junto: descomentar só o `\newacronym` não bastaria.

- [x] 2.5 Cada bloco comentado leva ao lado **o que faz, quando descomentar e o que acontece se descomentar cedo demais**. Linha comentada sem explicação é indistinguível de sobra esquecida, e a reação natural é descomentar para ver — o que no caso da bibliografia não revela o problema.

  **Resultado.** O aviso da bibliografia é o mais enfático dos três, e de propósito: "Um trabalho entregue com ele tem bibliografia falsa, e isso não salta aos olhos ao folhear o PDF."

## 3. Verificação

- [x] 3.1 Compilar os seis do zero (`latexmk -C` antes) e **ler as páginas rasterizadas**, um a um: capa correta para o tipo, natureza correta, folha de aprovação na forma daquele tipo — e no `tcc1` sem banca, ausente por completo. Seis PDFs, seis leituras: é o requisito "compila sem edição" sendo de fato exercido, e não presumido.

  **Resultado.** Os seis compilam sem erro. Mapa de páginas conferido em todos; capa de `tese` e folha de aprovação de `estagio` lidas rasterizadas — a segunda mostra as três partes corretas (aluno estagiário, orientador acadêmico, supervisor de campo). No `tcc1`, sem `\bancamembro` declarado, a folha **não é emitida**: a página 3 é o RESUMO, logo após a folha de rosto, sem página em branco nem entrada no sumário.

- [x] 3.2 Confirmar em cada PDF que **não há página de título seguida de vazio** — nem lista, nem glossário, nem bibliografia. É o defeito que as tarefas da seção 2 existem para evitar, e o único jeito de saber é contando as páginas do que saiu.

  **Resultado.** Varredura página a página nos seis: nenhuma com menos de 25 caracteres de texto. Zero páginas órfãs.

- [x] 3.3 Verificar que `dissertacao` e `tese` **falham** se a área de concentração for removida, e que `tcc2`, `dissertacao` e `tese` falham sem `\abstractseclang`, com erro do pacote nomeando o que falta. Os esqueletos trazem esses campos preenchidos; a verificação é de que eles estão lá porque são exigidos, e não por decoração.

  **Resultado.** Cinco testes negativos, todos com erro do próprio pacote: `dissertacao` e `tese` sem área → "Falta a área de concentração"; `tcc2`, `dissertacao` e `tese` sem abstract → "Falta o resumo em língua estrangeira".

  **Nota de método.** As duas primeiras tentativas produziram resultado falso, e nenhuma delas por culpa do modelo. Na primeira, o `sed` não comentou linha alguma e os cinco casos "compilaram" — teste vazio passando por aprovação. Na segunda, comentar apenas a linha `\abstractseclang{%` deixou o corpo do bloco solto no preâmbulo, e a compilação falhou com `Missing \begin{document}` — falha pelo motivo errado, que teria sido lida como sucesso se eu só olhasse o código de saída. A terceira tentativa contou as linhas efetivamente comentadas antes de compilar, e distinguiu erro do pacote de erro do LaTeX. **Um teste negativo precisa provar que alterou o que pretendia alterar; senão ele mede a si mesmo.**

- [x] 3.4 Confirmar por execução que `latexmk modelo-*.tex` constrói tudo em `build/` sem conflito de arquivos auxiliares. Verificar, não deduzir dos nomes.

  **Resultado.** Um `latexmk modelo-*.tex` após `latexmk -C` constrói os sete drivers (os seis novos mais `modelo-relatorio.tex`) em `build/`, exit 0, sem conflito.

- [x] 3.5 Confirmar que `modelo-relatorio.tex` continua compilando sem alteração. Esta change não o toca, e é bom que o PDF gerado saia idêntico — comparar o tamanho em bytes com o do commit anterior.

  **Resultado.** 263.144 bytes, 32 páginas — idêntico ao do commit anterior.

## 4. Ao arquivar

- [ ] 4.1 `usage-guide` é capability nova: o sync cria `openspec/specs/usage-guide/spec.md` a partir do delta `## ADDED`, convertendo o cabeçalho para `## Requirements`. `openspec archive add-type-skeletons` faz esse sync — ver `openspec/config.yaml`, `operations.archive`, para o que fica de mão depois dele.
- [x] 4.2 Registrar como dívida a guarda para lista vazia em `\listoffigures`/`\listoftables` (`UnifeiICTReport.sty:1595–1605`), contornada aqui por comentário e não resolvida (design.md, decisão 3). Ela pertence ao `.sty` e beneficiaria qualquer documento real.

  **Resultado.** O repositório não tinha registro de dívida algum — nem arquivo, nem convenção. Registrada como change própria, `add-empty-list-guard`, que é o único registro durável que este repositório tem: aparece em `openspec list` e não morre dentro de um `archive/`. A proposta cobre as **quatro** listas, não só as duas do `.sty:1605–1622` — `\listofquadros` e `\listofgraficos` herdam o mesmo bloco por `
ovotipoilustracao` (`:1116`). Delta escrito em `illustration-types`, com a ressalva de que `\listoftables` (§4.2.1.10) hoje não tem capability que a governe. Mecanismo — silêncio ou aviso, e como detectar a lista vazia sem oscilar entre passadas do latexmk — deixado para o design daquela change.
- [x] 4.3 Anotar que a galeria de capas no manual fica destravada a partir daqui. **Correção de premissa:** o design previa esqueletos de 4 a 6 páginas; saíram com **8** (`generico`, `estagio`, `tcc1`) e **11** (`tcc2`, `dissertacao`, `tese`), entre 118 e 122 KB. Continuam curtos e baratos de incluir. O mapa de páginas para `\includegraphics`: capa sempre em 1, folha de rosto em 2, folha de aprovação em 3 — **exceto no `tcc1`, que não a emite**. A galeria precisa tratar esse caso, e não assumir a página 3 uniformemente.

  **Resultado.** Anotado no `proposal.md` de `rewrite-usage-guide`, no item da galeria em "Fora de escopo" — que é onde quem for construí-la vai ler. Os seis foram recompilados hoje para conferir: 8, 8, 8, 11, 11, 11 páginas, exit 0, iguais ao que esta tarefa havia registrado.
