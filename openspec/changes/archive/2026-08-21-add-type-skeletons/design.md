## Contexto

Como dar a seis tipos de documento um ponto de partida cada, sem criar seis artefatos que precisem ser mantidos em sincronia com o modelo e entre si.

## Decisões

### 1. Seis arquivos, não um parametrizado

A alternativa era um único arquivo com a linha do tipo comentada em seis variantes, para o aluno descomentar a sua. Rejeitada: as diferenças entre os tipos não estão só na opção do pacote. `dissertacao` e `tese` exigem área de concentração; os tipos com banca precisam de `\bancamembro`; `generico` não tem banca alguma; o abstract é obrigatório nos três tipos de monografia e opcional nos demais. Um arquivo só teria de carregar todos os metadados de todos os tipos, a maioria comentada, e o aluno teria de descobrir quais valem para ele — que é exatamente o trabalho que esta change existe para eliminar.

Também foi rejeitado condensar tudo em um documento que renderizasse as variantes lado a lado em `minipage`, por evidência no `.sty`: o tipo resolve **uma vez**, em `\ProcessOptions`, numa cascata de `\ifx` que fixa booleanos globais (`UnifeiICTReport.sty:150–220`), e `\folhaaprovacao` usa `\cleardoublepage` e `\vfill` de página inteira, que não sobrevivem dentro de uma `minipage`. Qualquer um dos dois caminhos obrigaria a reimplementar à mão a capa e a folha de aprovação — uma segunda implementação que compilaria limpo e passaria a divergir da real em silêncio na primeira change seguinte que tocasse o layout.

Seis drivers evitam isso por construção: cada um exercita o caminho real do pacote.

### 2. Não importam nada

Um esqueleto que fizesse `\subimport{Capitulos/cap1/}{cap1.tex}` viria acompanhado de uma árvore de arquivos vazios — lixo a apagar — ou apontaria para os capítulos do manual, e aí compilaria o manual inteiro.

Ao não importar nada, o esqueleto passa a ser **a demonstração da segunda forma de trabalhar**: tudo num arquivo só, seções escritas direto no corpo. O manual, organizado em `Capitulos/`, demonstra a primeira. As duas formas ficam documentadas por artefato existente e compilável, e não por descrição.

### 3. Nada que dependa de conteúdo inexistente é chamado

Duas coisas ficam comentadas nos esqueletos, e vale ver que são o mesmo problema:

**As listas.** `\listoffigures` e `\listoftables` (`UnifeiICTReport.sty:1595–1605`) fazem `\cleardoublepage`, imprimem o título e chamam `\@starttoc` sem guarda para lista vazia. Sem uma figura sequer, sai uma página de título e nada abaixo. É o que `modelo-relatorio.tex` já faz para `\listofquadros` e `\listofgraficos` — prática existente, apenas estendida.

**A bibliografia.** `referencias.bib` é fictício de propósito: suas referências falsas existem para os exemplos de citação do manual, e o próprio texto avisa isso. Um esqueleto que aponte para ele entrega ao aluno um trabalho com bibliografia inventada — e, pior que a lista vazia, esse defeito não é visualmente óbvio: parece uma bibliografia legítima.

Por isso `\printbibliography` **e** a declaração do arquivo `.bib` saem comentados, com a instrução de criar o próprio arquivo de referências ao lado. Comentar só a impressão deixaria o `.bib` fictício declarado e processado pelo biber, sem benefício.

A regra geral, que vale para os dois: **conteúdo de demonstração não vaza para dentro do ponto de partida.**

**Registrado como dívida, não resolvido aqui:** a guarda para lista vazia pertence ao `.sty` e beneficiaria qualquer documento real cujo autor esqueça de comentar a chamada. Contornar por comentário resolve o esqueleto e deixa o defeito de pé. Esta change não toca o `.sty` para não misturar criação de arquivos com mudança de comportamento do pacote.

### 4. O comentário explica, não só desativa

Uma linha comentada sem explicação é indistinguível de uma linha que alguém esqueceu de apagar — e a reação natural do aluno é descomentar para ver o que acontece. No caso das listas ele descobre o problema na hora; no caso da bibliografia, não descobre.

Cada bloco comentado leva ao lado **o que ele faz, quando descomentar, e o que acontece se descomentar cedo demais**. O mesmo texto, em forma longa, entra no manual — o esqueleto dá a instrução no ponto de uso, o manual dá o porquê.

### 5. A capability nasce com um requisito só

`usage-guide` é criada aqui, mas apenas com o requisito sobre os arquivos de partida. Os outros quatro — sobre o que o manual cobre, com que fidelidade normativa, e a divisão de papéis com o README — entram na change que escreve o manual.

Trazê-los todos para cá deixaria a spec afirmando, desde já, coisas verdadeiras apenas depois da change seguinte. Uma spec que descreve um estado futuro não é verificável, e a única coisa que `usage-guide` existe para impedir é justamente a documentação ficar atrás da implementação.

## Questões resolvidas

**Um `latexmk` constrói tudo?** `.latexmkrc` manda saída para `build/`, e os nomes-base dos seis diferem entre si e de `modelo-relatorio.tex`, então não deve haver conflito de arquivos auxiliares. A confirmar por execução — a tarefa exige rodar, não deduzir.

**Os esqueletos declaram siglas e símbolos?** Hoje isso vem de `Preambulo/lista-abreviaturas.tex` e `lista-simbolos.tex` via `\subimport`, o que contraria a decisão 2. Pela mesma lógica da decisão 3, o glossário não deve ser impresso quando não há o que imprimir: os esqueletos declaram inline uma sigla de exemplo, comentada, e mantêm os `\printglossary` comentados ao lado.
