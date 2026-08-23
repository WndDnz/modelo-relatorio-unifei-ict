## Why

A NBR 14724:2024 §4.2.3.2 prevê o **glossário** como elemento pós-textual opcional, elaborado em ordem alfabética. O modelo não o oferece: usa o pacote `glossaries` apenas para as duas listas pré-textuais — abreviaturas e siglas (§4.2.1.7) e símbolos (§4.2.1.8).

O glossário `main` do `glossaries` existia carregado, nunca usado e nunca documentado. `fix-glossary-build` o desliga com `nomain`, pela Regra de Platina — capacidade que o manual não documenta não fica disponível e muda —, e acrescenta o glossário à lista de ausências do capítulo 3.

Esta change fecha a ausência, em vez de declará-la. É a alternativa que `fix-glossary-build/design.md` descartou **por escopo, e não por mérito**: ali o objetivo era fazer o ciclo de compilação rodar.

Não é dívida herdada de defeito. É elemento que a norma prevê, que trabalhos do ICT usam, e que hoje o autor tem de compor à mão.

## What Changes

O modelo passa a oferecer o glossário pós-textual, no molde de `\apendices` e `\anexos`: um comando no `\backmatter` que emite o elemento com título, entrada de sumário e ordenação alfabética.

A decidir no design, e não aqui:

- **Reativar o `main` do `glossaries` ou usar tipo próprio.** `fix-glossary-build` desliga o `main`; esta change decide se o religa ou declara um tipo `glossario` ao lado de `acronym` e `symbols`. A segunda forma deixa o nome do tipo dizer o que ele é.
- **Como o autor declara os verbetes.** Os dois arquivos de `Preambulo/` são o precedente; um terceiro seguiria o padrão que o manual já ensina.
- **Ordem alfabética e localidade.** O §4.2.3.2 exige ordem alfabética; ordenação em português tem acentuação e o `makeindex` não a trata sozinho. Decidir entre a ordenação do `makeindex` e `xindy`, e medir o resultado com verbetes acentuados — não presumir.
- **Onde entra na ordem dos pós-textuais**, em relação a referências, apêndices, anexos e índice.

## Capabilities

### Modified Capabilities

- `appendix-annex`: já governa os elementos pós-textuais que o modelo oferece e a ordem entre eles. O glossário é da mesma família e da mesma seção da norma; abrir capability nova para um elemento seria fragmentar o que já está junto.

## Fora de escopo

- **As duas listas pré-textuais**, que são de `abbreviation-symbol-lists` e continuam como estão.
- **O passo de compilação**, que é de `fix-glossary-build` e é pré-requisito desta: sem o `makeglossaries` rodando, um glossário declarado sairia em branco como as listas saíam.

## Impact

- `UnifeiICTReport.sty`, no bloco de `glossaries` (`:350`) e no dos pós-textuais.
- `.latexmkrc`, se o tipo novo exigir regra própria.
- Os seis arquivos de partida e o manual, pela Regra de Platina: comando público entra documentado e exemplificado.
- A lista de ausências do capítulo 3 perde o glossário que `fix-glossary-build` acabou de acrescentar.
