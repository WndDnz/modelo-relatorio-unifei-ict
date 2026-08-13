## Why

O texto de exemplo do modelo (`Capitulos/cap2/cap2.tex`) é, na prática, o guia de utilização: é dele que o autor de um relatório aprende o que o pacote oferece. Ele carrega hoje quatro defeitos, dois deles normativos.

O mais grave é uma **contradição interna**. O `itemize` das linhas 66–90 ensina os nomes nativos do LaTeX — "Capítulos", "Seções", "Subseções", "Subsubseções" — e vinte linhas adiante, na mesma seção, a lista das linhas 110–115 ensina o oposto, que é o que o pacote de fato faz:

```
     \chapter       -> Seção        \subsection    -> Subsubseção
     \section       -> Subseção     \subsubsection -> Parágrafo
```

Essa cascata está em `UnifeiICTReport.sty:303–306`, e existe porque a NBR 14724:2024 não admite a divisão do trabalho em capítulos — o próprio guia diz isso na linha 106, logo depois de ter ensinado o contrário. Quem seguir a primeira lista escreve "conforme a subseção acima" sobre um `\subsection` que o `\refcomp` imprime como **Subsubseção**. O texto discorda da saída compilada, e o guia discorda de si mesmo.

O segundo defeito normativo: as linhas 134–137 atribuem as **citações em texto** à NBR 6023:2018. A 6023 rege *referências*; citação em documento é a **NBR 10520:2023**, que está em `.refs/` e nunca é citada pelo modelo. A frase ainda escorrega de "citações em texto" para "referências bibliográficas" na mesma oração, fundindo as duas coisas que as duas normas separam. É o erro que mais custa ao leitor: ele copia a atribuição errada para o próprio trabalho.

Os outros dois são de execução. `\LaTeX\,` aparece em três lugares onde se queria uma vírgula — `\,` é o comando de espaço fino, então a vírgula pretendida nunca é escrita e o texto sai com um espaço no lugar dela. Compila limpo e imprime errado, que é o modo de falha característico deste projeto. E restam quatro erros de digitação.

Esta change vem **antes** da reescrita do manual de propósito. A reescrita dissolve `cap2.tex` e leva semanas; até lá o PDF publicado ensina a norma errada. O texto corrigido é o que a reescrita herda.

## What Changes

- As citações em texto passam a ser atribuídas à **NBR 10520:2023**, e a frase separa citação de referência em vez de fundi-las. A NBR 6023:2018 permanece citada onde de fato se aplica, na elaboração das referências.
- `referencias.bib` ganha a entrada `nbr10520:2023`, no mesmo padrão das entradas ABNT vizinhas (`author = {{Associação Brasileira de Normas Técnicas}}`, com chaves duplas) — sem ela a correção não teria o que citar.
- O `itemize` das divisões passa a ensinar os nomes que o pacote realmente imprime, com o comando LaTeX entre parênteses. A lista duplicada das linhas 110–115 deixa de existir como segunda fonte de verdade.
- Os prefixos de rótulo (`cap:`, `sec:`, `ssc:`, `sss:`) **não mudam** — ver "Decisões" abaixo.
- A afirmação de que `\refcomp` resolve o nome "a partir do rótulo" passa a dizer o que ocorre: o nome vem do contador do elemento referenciado, via `\autoref`.
- Os três `\LaTeX\,` viram `\LaTeX,`.
- Os quatro erros de digitação são corrigidos: "TeX Live ." (espaço antes do ponto), "no modulo" → "no modelo", "famíla" → "família", "sem apas" → "sem aspas".

Não entra: a reescrita do guia, que é change à parte; e a grafia "compreenssão" na linha 180, que está errada **de propósito**, marcada `[grafia errada no original]` dentro de um exemplo de citação literal.

## Capabilities

Nenhuma. Esta change não altera comportamento do pacote — corrige prosa e um erro de escape em texto de exemplo.

A entrada nova em `referencias.bib` já é governada por `bibliography-accuracy`, pelos requisitos *"ABNT self-references cite the currently valid edition"* e *"Consistent field pattern across sibling ABNT entries"*, que valem como estão e não precisam de delta.

A correção da prosa é justamente o que a capability `usage-guide` vai governar — mas ela nasce na change de reescrita do manual, desenhada por inteiro, e não improvisada aqui para acomodar uma correção de digitação. Esta é a primeira change do repositório sem delta de spec; se a preferência for outra, o caminho é adiantar `usage-guide` com um requisito só.

## Decisões

**Os prefixos de rótulo ficam como estão.** O desalinhamento é real — `ssc:` sugere "subseção" e marca o que o modelo chama de Subsubseção —, mas nenhum código depende dos prefixos: `\refcomp` resolve pelo contador, não pelo texto do rótulo. Renomeá-los quebraria todos os rótulos já escritos nos arquivos de exemplo e em qualquer documento de aluno, em troca de um mnemônico. Passam a ser apresentados pelo que são: mnemônico do **comando** (`\subsection` → `ssc:`), não do nome ABNT da divisão.

## Impact

- `Capitulos/cap2/cap2.tex`: linhas 19, 22, 23, 27, 31, 62–90, 100–101, 110–115, 134–137, 169, 363.
- `referencias.bib`: entrada nova `nbr10520:2023`.
- Sem efeito sobre `UnifeiICTReport.sty` — a cascata de nomes em `:303–306` já está correta; é o guia que discorda dela.
- **Adjacente, fora de escopo:** `.refs/NBR_6023_2025.pdf` é a **Emenda 1** (`ABNT NBR 6023:2018/Em1:2025`, 11 páginas), verificado no próprio PDF — não é edição nova. A entrada `nbr6023:2018` está correta e `bibliography-accuracy` não está sendo violada. Fica em aberto, para change própria, se a emenda alterou alguma regra que os exemplos de referência do modelo ainda seguem na forma antiga: exige ler as 11 páginas e conferir contra `referencias.bib`.
