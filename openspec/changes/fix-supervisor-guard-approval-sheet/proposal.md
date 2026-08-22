## Why

Tirar o `\supervisor` do preâmbulo faz a folha de aprovação sair com um **rótulo órfão**: a linha "Professor da disciplina" é impressa sozinha, sem nome nenhum acima dela. Verificado na página 3 de `build/manual.pdf`, com o `\supervisor` comentado.

A causa é uma guarda que existe e não é usada. O pacote declara `\if@supervisorpresent` e o mantém correto:

```
UnifeiICTReport.sty:808-810
  \newif\if@supervisorpresent\@supervisorpresentfalse
  ... \ifblank{#1}{\@supervisorpresentfalse}{\@supervisorpresenttrue}
```

A folha de rosto consulta essa flag (`:1279`) e omite o bloco quando não há professor. A folha de aprovação **não a consulta** em nenhum dos três pontos em que emite o professor:

```
:1450  \Unifei@RegistroPorProfessor{\@supervisor}{Orientador acadêmico}   % estagio
:1461  \Unifei@RegistroPorProfessor{\@supervisor}{\Unifei@papel\ da disciplina}  % generico
:1497  \Unifei@RegistroPorProfessor{\@supervisor}{Orientador}             % monografias
```

Com `\@supervisor` vazio, `\Unifei@RPPloop` (`:1396`) ainda percorre a lista uma vez e emite um `\Unifei@RegistroBloco` de nome vazio com o rótulo por cima. Um bloco sem nome não é um bloco vazio: é uma função atribuída a ninguém, numa página cuja finalidade é justamente registrar quem aprovou o trabalho.

Compila limpo, sem aviso. É o modo de falha característico deste repositório, e o terceiro caso da mesma família encontrado nesta rodada, ao lado de `add-empty-list-guard` e `fix-glossary-build`.

Os seis arquivos de partida declaram `\supervisor`, então nenhum deles exibe o sintoma. A proteção é acidental — a mesma de `fix-glossary-build`. Quem apaga a linha, ou quem prepara a folha antes de saber quem orienta, recebe o defeito.

## What Changes

A folha de aprovação passa a consultar `\if@supervisorpresent` antes de emitir o professor, nos três tipos. Sem professor declarado, nenhum bloco e nenhum rótulo.

A decidir no design, e não aqui:

- **Omitir ou recusar.** Nos tipos de monografia o orientador é obrigatório de fato: uma folha de aprovação de tese sem orientador não é um documento legítimo. Ali, o certo pode ser `\PackageError` nomeando o metadado que falta — como já acontece com a área de concentração — em vez de omitir em silêncio. No `generico` a omissão basta.
- **A distinção em relação ao `\bancamembro`.** Campo em branco na banca é comportamento **deliberado e documentado**: serve à folha preparada antes de os nomes serem conhecidos. Essa exceção precisa sobreviver à mudança, e a diferença entre os dois casos precisa ficar explícita no código.
- **`\cosupervisor`**, que tem flag própria (`:814-816`) e merece a mesma conferência.

## Capabilities

### Modified Capabilities

- `approval-sheet`: já governa quem consta na folha por tipo. O requisito novo diz que rótulo sem nome não é uma dessas formas.

## Fora de escopo

- **A folha de rosto**, que já consulta a flag e está correta.
- **Os arquivos de partida**, que declaram `\supervisor` e continuam devendo declará-lo.
- **O manual.** A subseção 3.2.3 descreve o rótulo que deriva do tipo; depois desta change ela ganha uma frase sobre a ausência. Enquanto isso, `manual.tex` declara `\supervisor` — não porque o manual tenha professor responsável, mas porque deixá-lo em branco produziria o rótulo órfão. O preâmbulo do manual traz a nota dizendo isso.

## Impact

- `UnifeiICTReport.sty`, nos três pontos citados.
- Nenhum documento que declare `\supervisor` muda de saída.
- `build/manual.pdf` perde o rótulo órfão da página 3.
