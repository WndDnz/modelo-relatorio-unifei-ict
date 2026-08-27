## Contexto

O pacote declara quatro opções. `tipo=` funciona. `neverindent` interrompe a compilação — `:18` executa `\@neverindenttrue` e não existe `\newif\if@neverindent` no arquivo. `roman` e `sans` alternam `\if@roman`, que tem exatamente três ocorrências no `.sty`: a declaração e as duas opções que a acionam. Nenhuma é consultada.

As três vêm do commit inicial `9a8d0a9` e nenhum commit posterior as tocou. A única anotação de intenção no repositório inteiro é o cabeçalho de `:20`, `% --- Lógica para família de fontes ---`.

Há um terceiro sítio, que a proposta original não conhecia: `:253` mantém uma lista de exclusão com os três nomes, para que o detector de idioma não os confunda com tokens de babel.

## Decisões

### 1. `roman` e `sans` são implementadas

A NBR 14724:2024 **não prescreve família tipográfica**. O §5.1 (Formato) rege cor, papel e tamanho — recomenda tamanho 12 para todo o texto, inclusive a capa, exceto citações longas, notas de rodapé, paginação, dados de catalogação e fontes e legendas de ilustrações e tabelas, que devem ser "em tamanho menor e uniforme". Serifada ou sem serifa não aparece ali, nem no §5.2.

Como a família é livre, a escolha entre serifada e sem serifa é decisão editorial do modelo — e uma decisão editorial que o autor pode legitimamente querer inverter é exatamente o que uma opção de pacote serve para expor.

O padrão de fato hoje é `roman`: corpo em Heuristica serifada, legenda em sem serifa. `sans` inverte os dois.

### 2. A inversão de legenda passa a derivar da flag

Hoje a inversão existe, mas está escrita à mão:

```
:466  \captionsetup{font=small,labelfont={bf,sf},textfont={sf},labelsep=endash}
```

`sf` é literal e não consulta nada. Depois desta change, corpo e legenda são famílias opostas **por construção**, e não por coincidência de duas escolhas independentes. É essa amarração que dá conteúdo à opção; sem ela, `roman`/`sans` seriam um botão que troca metade do documento e deixa a outra metade parada.

Nota: o mecanismo de fontes de `:492` e `:620-645` **não é o que a opção controla**. Ele decide *qual* fonte sem serifa está disponível (IBM Plex Sans, TeX Gyre Heros, Arial…), com aviso quando nenhuma está. A opção decide *onde* a sem serifa é usada. São camadas diferentes e as duas continuam.

### 3. `neverindent` é removida, com erro que explica

A pergunta que a justificaria era a citação direta longa. Não a justifica: o §7.1.1 da NBR 10520:2023 pede **recuo do bloco inteiro** em relação à margem esquerda, não supressão do recuo de primeira linha — e `\quote` (`:997-1008`) já faz `\noindent` internamente, sem depender de opção alguma.

Nenhum elemento das normas consultadas pede supressão de recuo de primeira linha. O modelo carrega `indentfirst` (`:447`) de propósito, e trabalhos ABNT são indentados. Não há saída certa a implementar, e uma opção sem saída certa não deve existir.

Cai `:18`; no lugar entra um `\DeclareOption{neverindent}` que emite `\PackageError` nomeando a remoção. Opção removida em silêncio é pior que opção quebrada: quem a usava não descobre por que o documento mudou.

### 4. Os três sítios andam juntos

```
:18       \DeclareOption{neverindent}   → vira \PackageError
:21-23    \newif\if@roman + as duas opções  → ganham consulta real
:253      lista de exclusão do idioma  → perde 'neverindent', mantém 'roman' e 'sans'
:466      \captionsetup literal        → passa a consultar \if@roman
```

Deixar `:253` intacto ao remover `neverindent` faria a opção continuar engolida em silêncio — nem efeito, nem erro, que é pior que hoje, porque hoje ao menos falha ruidosamente.

## Alternativas descartadas

- **Remover as três.** Descartada pela leitura das normas: como a família é livre, `roman`/`sans` expõem uma escolha legítima do autor, e o mecanismo de inversão que elas controlariam já existe — só está fixo. Removê-las jogaria fora a única das três que tem para onde ir.
- **Implementar `neverindent`.** Descartada por ausência de demanda normativa: nenhum elemento das normas pede supressão de recuo de primeira linha, e o único candidato — a citação longa — resolve o próprio recuo por outro caminho.
- **Fazer `roman`/`sans` sobreporem `\if@unifei@sansset`.** Descartada porque são camadas diferentes: `:620-645` responde "qual fonte sem serifa existe nesta máquina", com fallback e aviso; a opção responde "onde a sem serifa é usada". Sobrepor uma na outra faria dois mecanismos decidirem a mesma coisa.
- **Confiar no babel para recusar a opção removida.** Descartada por inspeção de `:253`: o nome está na lista de exclusão do detector de idioma, então nunca chega ao babel. O erro previsto não aconteceria.
