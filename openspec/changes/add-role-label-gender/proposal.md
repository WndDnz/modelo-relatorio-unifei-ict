## Why

Os rótulos de papel do pacote são masculinos fixos. `\Unifei@papel` (`UnifeiICTReport.sty:188-189`,
`:807-831`) alterna singular e plural e nada mais; "Orientador", "Professor", "Aluno estagiário",
"Coorientador" (`:1514`, `:1636`), "Orientador acadêmico" (`:1688`) e "Supervisor de campo"
(`:1692`) estão escritos por extenso no ponto de emissão.

A consequência é que a capa, a folha de rosto e a folha de aprovação de um trabalho orientado por
uma professora imprimem "ORIENTADOR". O autor que quiser corrigir não tem por onde: nenhum dos
rótulos é parâmetro.

Foi levantado como limitação pré-existente no `design.md` de `fix-supervisor-guard-approval-sheet`,
que a declarou fora de escopo por uma razão boa — aquela change consertava rótulo órfão, e trocar o
regime de rótulos no mesmo diff teria misturado dois problemas. A tarefa de arquivamento 5.2 daquela
change manda registrá-la aqui.

Nenhuma norma é violada: a NBR 14724:2024 não prescreve rótulo algum nesses pontos. O defeito é de
adequação, não de conformidade — o que não o torna menor para quem recebe o documento com o próprio
papel no gênero errado.

## What Changes

Os rótulos de papel passam a flexionar em gênero, e o autor passa a ter como declará-lo.

A decidir no design, e não aqui:

- **Como o gênero é declarado.** As candidatas são um argumento opcional nos comandos de metadado
  (`\supervisor[f]{...}`), um comando de metadado próprio, ou a inferência — que fica descartada de
  saída: nome não determina gênero, e errar por adivinhação é pior que errar por omissão.
- **Qual é o padrão.** Manter o masculino como padrão preserva a saída atual de todo documento
  existente, e é a escolha barata; é também a que continua errando por omissão na metade dos casos.
  A alternativa é exigir a declaração nos tipos em que o papel é obrigatório, como
  `fix-supervisor-guard-approval-sheet` já fez com o nome.
- **Onde os rótulos passam a morar.** Hoje estão em seis pontos de emissão diferentes. Flexionar em
  cada um multiplica o `\if`; uma tabela única de rótulos é mais limpa e é refatoração maior.
- **Quantos papéis entram.** Orientador, coorientador e professor responsável são os frequentes.
  "Aluno estagiário" e "Supervisor de campo" têm o mesmo defeito e o mesmo remédio, e deixá-los de
  fora entrega meia solução.

## Capabilities

### Modified Capabilities

- `document-type`: é a dona do requisito "O rótulo do papel do professor deriva do tipo", que hoje
  faz o rótulo variar por tipo e por número. O gênero é a terceira dimensão da mesma variação, e
  cabe no mesmo requisito.

## Fora de escopo

- **Os rótulos que não designam pessoa** — "Autor"/"Autores" tem o mesmo defeito e resolve-se pelo
  mesmo mecanismo, mas pertence à capa, não ao papel do professor. Decidir no design se entra junto.
- **Linguagem neutra.** Esta change flexiona em masculino e feminino, que é o que os documentos do
  ICT usam hoje. Terceira forma é decisão institucional, não de modelo.

## Impact

- `UnifeiICTReport.sty`, nos seis pontos de emissão de rótulo e no bloco de metadados.
- Os seis arquivos de partida e o manual, pela Regra de Platina: se um comando público ganha
  argumento, o argumento entra documentado e exemplificado.
