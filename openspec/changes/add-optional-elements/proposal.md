## Why

O capítulo 3 do manual traz uma seção chamada "O que este modelo não oferece" (`Capitulos/cap3/cap3.tex:188-197`). Ela lista elementos que a NBR 14724:2024 prevê e que o pacote não implementa:

- **dedicatória** (§4.2.1.4), **agradecimentos** (§4.2.1.5) e **epígrafe** (§4.2.1.6), opcionais;
- **errata** (§4.2.1.2), **lombada** (§4.1.2) e **índice** (§4.2.3.5).

`fix-glossary-build` acrescenta a essa lista o **glossário** (§4.2.3.2), ao desligar o glossário `main` do pacote `glossaries`; a change `add-glossary-backmatter` já está registrada para fechá-lo à parte.

A seção existe por uma decisão registrada em `rewrite-usage-guide`: declarar a ausência é melhor que omiti-la, porque quem precisa de agradecimentos numa dissertação precisa saber disso **antes** de escrever, e não ao procurar o comando na véspera da entrega.

Declarar a ausência foi o passo certo naquele momento. Esta change dá o seguinte: fechar as ausências, em vez de continuar documentando-as. São elementos que trabalhos do ICT usam de fato — agradecimentos e dedicatória em toda monografia, epígrafe com frequência — e que hoje cada autor compõe à mão, cada um de um jeito, sem apoio do modelo e sem garantia de conformidade.

É a maior das changes ativas em superfície: mexe nos pré-textuais, na parte externa e nos pós-textuais ao mesmo tempo. Registrada agora para não se perder, e para que as changes pequenas em curso não sejam desenhadas de costas para ela.

## What Changes

O modelo passa a oferecer comando próprio para cada elemento da lista, com a formatação que a norma exige e a posição correta na ordem dos elementos.

A decidir no design, e não aqui:

- **Se a change se divide.** Seis elementos em três partes do documento é escopo grande para uma change só, e este repositório vem trabalhando em incrementos pequenos e verificáveis. A divisão natural seria por parte — pré-textuais, parte externa, pós-textuais —, e a decisão pesa o custo de três ciclos contra o de um ciclo grande.
- **A lombada é caso à parte.** O §4.1.2 rege impressão, não composição de miolo; ela só faz sentido em trabalho encadernado, e a sua geração pode nem pertencer ao mesmo arquivo `.tex`.
- **O índice remissivo** é regido pela NBR 6034:2004, não pela 14724, e depende de `makeindex` — isto é, de mais um passo no ciclo de compilação, exatamente como `fix-glossary-build` acabou de acrescentar para os glossários. Herdar a decisão daquela change, e não reabri-la.
- **Quais são obrigatórios por tipo.** Nenhum destes é obrigatório em tipo algum, mas a folha de aprovação e o resumo já mostram que obrigatoriedade derivada do tipo é o padrão da casa; decidir se algum deles merece o mesmo tratamento.

## Capabilities

### Added Capabilities

- `pretextual-elements`: os elementos pré-textuais que o modelo oferece hoje estão espalhados por `approval-sheet`, `document-type` e `abbreviation-symbol-lists`, cada um pela porta que o trouxe. Os que esta change acrescenta não têm dono, e criar uma capability por elemento fragmentaria o que a norma trata junto, na mesma seção.

## Fora de escopo

- **O glossário (§4.2.3.2)**, que é de `add-glossary-backmatter`.
- **A página de Declaração de uso de Inteligência Artificial**, que é de `add-ai-usage-declaration`. Ela entra no mesmo lugar do documento e será desenhada junto, mas a justificativa é de outra natureza: não há norma que a exija.
- **As sete changes em curso**, que devem entrar antes: esta é a refatoração grande, e desenhá-la sobre um `.sty` com defeito conhecido custa mais caro.

## Impact

- `UnifeiICTReport.sty`, em três regiões distintas.
- Os seis arquivos de partida e o manual, pela Regra de Platina: comando público entra documentado e exemplificado.
- A seção "O que este modelo não oferece" do capítulo 3 encolhe, e é essa a medida do sucesso desta change.
