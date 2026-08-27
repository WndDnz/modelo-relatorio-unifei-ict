## Why

A citação direta com mais de três linhas sai em espaço **um e meio**, e deveria sair em espaço simples.

Medido pelo próprio TeX, com `\the\baselineskip` impresso dentro e fora do bloco:

```
corpo do texto:      21.75pt
dentro do \quote:    20.40pt

entrelinha simples do \small a 12pt = 13.6pt
13.6 x 1.5 = 20.4    ← o bloco herda o espacejamento do corpo
```

Duas normas dizem o mesmo, por caminhos diferentes:

- **NBR 10520:2023 §7.1.1** — a citação direta com mais de três linhas é destacada por recuo padronizado em relação à margem esquerda (recomendado 4 cm), em letra menor, **em espaço simples** e sem aspas.
- **NBR 14724:2024 §5.2** — todo o texto em espaçamento 1,5, excetuadas as citações diretas com mais de três linhas, notas de rodapé, referências, títulos e legendas de ilustrações e tabelas, fontes e natureza, **que devem ser em espaço simples**.

A causa é uma omissão simples: `\renewcommand{\baselinestretch}{1.5}` (`:938`) vale globalmente, e `\quote` (`:997-1008`) nunca chama `\singlespacing`. Dos quatro requisitos do §7.1.1 o modelo cumpre três — recuo de 4 cm via minipage, `\small`, sem aspas — e falha o quarto.

Compila limpo e sai plausível: o bloco *parece* destacado porque está recuado e menor, e a diferença de entrelinha só aparece medindo ou comparando lado a lado. É o modo de falha característico deste repositório.

**Os demais elementos da lista do §5.2 estão corretos**, e isso foi medido, não presumido:

```
legenda de figura:   13.6pt   (simples)
fonte da ilustração: 13.6pt   (simples)
nota de rodapé:      12.0pt   (simples)
```

O `caption` normaliza a entrelinha das legendas e o `setspace` corrige as notas de rodapé por conta própria. Só a citação escapou dos dois.

## What Changes

O bloco de citação direta longa passa a ser composto em espaço simples, independentemente do espacejamento do corpo.

A decidir no design, e não aqui:

- **`\singlespacing` do setspace ou `\baselinestretch` local.** O pacote já carrega `setspace` (`:348`) mas não usa a interface dele — define `\baselinestretch` na mão (`:938`). Misturar as duas formas é fonte conhecida de surpresa; a escolha aqui deve considerar arrumar também `:938`, ou deliberadamente não mexer nele.
- **Onde a chamada entra.** Dentro da `minipage` de `\quote`, antes do texto, e se a citação bibliográfica ao pé do bloco (`\footnotesize\cite`) entra ou não no mesmo grupo.

## Capabilities

### Added Capabilities

- `direct-citation`: a citação no corpo do texto — regida pela NBR 10520:2023 — não tem capability neste repositório. `bibliography-accuracy` governa a referência (NBR 6023), que é a lista ao final e descreve a obra; a citação é a remissão feita no texto, e é outra norma. Esta change abre a capability com o requisito da citação longa.

## Fora de escopo

- **Legendas, fontes de ilustração e notas de rodapé**, medidas e corretas.
- **`:938`**, a definição global de `\baselinestretch`, exceto no que a decisão de design acima obrigar a tocar.
- **A natureza do trabalho e as referências**, que o §5.2 também excetua e que **não foram medidas** — a natureza é gerada dentro do pacote e as referências vêm do biblatex. Conferi-las é trabalho de outra change; registrá-las aqui como corretas seria presumir.
- **O manual.** A subseção que descreve `\quote` ganha a menção ao espaço simples depois que a mudança entrar.

## Impact

- `UnifeiICTReport.sty`, no bloco de `\quote` (`:997-1008`).
- Todo documento que use `\quote` muda de saída: o bloco encolhe verticalmente. Mudança a verificar lendo a página, e não o log.
- Nenhum outro elemento muda.
