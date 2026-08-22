## Why

O pacote declara quatro opções. Uma funciona. Das outras três, duas não fazem nada e a terceira quebra a compilação.

**`neverindent` interrompe o build.** A linha 18 executa `\\neverindenttrue`, e não existe `\\newif\\if\\neverindent` em lugar algum do arquivo:

```
UnifeiICTReport.sty:18
  \DeclareOption{neverindent}{\\neverindenttrue}
```

Verificado: `\usepackage[tipo=generico,neverindent]{UnifeiICTReport}` para com `! Undefined control sequence. \ds\neverindent ->\\neverindenttrue`, no `\ProcessOptions` da linha 133. Quem passar a opção não recebe um aviso — recebe um documento que não compila.

**`roman` e `sans` não fazem nada.** As duas alternam a flag `\\if\roman` (`:21–23`), e essa flag **nunca é consultada**: as três ocorrências no arquivo são a declaração e as duas opções que a acionam. A escolha de família tipográfica é decidida em outro lugar, por `\\if\unifei\sansset` (`:620`), que não tem relação com elas.

Verificado por compilação: `[tipo=generico,roman]` e `[tipo=generico,sans]` produzem texto idêntico ao do documento sem opção alguma, e embutem exatamente o mesmo conjunto de fontes — Exo2 Regular e Bold, Heuristica Regular e Bold, nos três casos.

O defeito veio à tona ao fechar a tarefa 6.1 de `rewrite-usage-guide`, que exige documentar todo comando público: as três opções não são citadas no README, no manual nem nos arquivos de partida, e a razão de não serem é agora clara. Não há o que documentar. Uma opção que existe, é aceita pelo `\DeclareOption` e não faz nada é pior que uma opção ausente: quem a encontrar no `.sty` vai usá-la e concluir que o efeito prometido é sutil demais para notar.

## What Changes

As três opções passam a ter comportamento definido: ou fazem o que o nome promete, ou deixam de ser declaradas.

A decidir no design, e não aqui:

- **Implementar ou remover.** São decisões independentes uma da outra. `neverindent` tem nome autoexplicativo e um comportamento óbvio a implementar; `roman`/`sans` competem com o mecanismo de família que já existe e funciona, e implementá-las pode ser reimplementar o que `\\if\unifei\sansset` já faz.
- **Se removidas, como falhar.** Opção não declarada é repassada ao babel como idioma — comportamento documentado do pacote. Quem hoje passa `sans` passaria a receber um erro de idioma confuso. Um `\DeclareOption` que emite `\PackageError` nomeando a remoção é mais honesto que o silêncio ou que o erro do babel.
- **Se implementadas, qual é a saída certa.** `neverindent` afeta o recuo de primeira linha, que a NBR 14724:2024 não prescreve, mas o modelo hoje aplica. Mudar isso por opção precisa de uma posição sobre o que o padrão deve ser.

## Capabilities

### Added Capabilities

- `package-options`: as opções de carregamento do pacote não têm capability. `document-type` governa o `tipo=`, que é a única que funciona, e é o precedente do que se espera das demais: valor inválido para com erro do próprio pacote, nomeando os valores aceitos.

## Fora de escopo

- **`tipo=`**, que funciona e é de `document-type`.
- **O mecanismo de fontes** (`:492`, `:620`), que está correto e faz o *fallback* prometido.
- **O manual.** Enquanto as três opções não tiverem comportamento definido, documentá-las é documentar um defeito. `rewrite-usage-guide` fecha a tarefa 6.1 apontando para esta change, e não escrevendo prosa sobre elas.

## Impact

- `UnifeiICTReport.sty`, nas linhas 18 e 21–23.
- Nenhum documento deste repositório passa qualquer uma das três, então nada em uso muda de saída.
- Documento de terceiro que passe `roman` ou `sans` hoje compila e ignora a opção; depois desta change, ou obtém o efeito, ou obtém um erro que explica.
