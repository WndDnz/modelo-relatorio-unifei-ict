## Modelo de Relatório Técnico-Científico (Unifei ICT)

Este repositório contém um modelo de relatório técnico-científico para os cursos do Instituto de Ciências Tecnológicas (ICT) da Unifei. O objetivo é fornecer um template pronto para uso com XeLaTeX/LuaLaTeX que já traz formatação institucional, capa e folha de rosto, estilos de título, tratamento de fontes e utilitários úteis (referências, glossários, figuras, tabelas, etc.).

### Estrutura do projeto

- `modelo-relatorio.tex` — arquivo principal (driver) do documento.
- `UnifeiICTReport.sty` — pacote de estilo personalizado que configura fontes, títulos, legendas, macros e utilitários.
- `referencias.bib` — arquivo BibTeX/BibLaTeX com exemplos de referências.
- `Capitulos/` — capítulos do relatório (cada capítulo em subdiretório).
- `Preambulo/` — arquivos auxiliares (lista de abreviaturas, símbolos, etc.).
- `Logos/`, `Fontes/` — recursos opcionais (logos e fontes locais).
- `.latexmkrc` — configuração de compilação (XeLaTeX, saída em `build/`).
- `build/` — saída da compilação (PDF e auxiliares); gerado automaticamente, fora do controle de versão.

## Requisitos

- TeX Live (ou outra distribuição moderna) com `xelatex` instalado.
- `biber` (recomendado) ou `bibtex` conforme sua configuração de `biblatex`.
- `makeglossaries` (se usar glossários/abreviaturas).
- `latexmk` — recomendado, automatiza todas as etapas; o projeto já inclui um `.latexmkrc` pronto.

## Como compilar

O repositório traz um arquivo `.latexmkrc` já configurado: pipeline XeLaTeX, SyncTeX ligado e todos
os arquivos auxiliares e o PDF gerados em `build/` (diretório ignorado pelo Git). Basta rodar, na
raiz do projeto:

```bash
latexmk modelo-relatorio.tex
```

Sem argumentos adicionais: o `latexmk` lê o `.latexmkrc`, decide sozinho quantas passadas de XeLaTeX
são necessárias e chama o `biber` quando a bibliografia muda. O PDF sai em `build/modelo-relatorio.pdf`.

Comandos úteis:

```bash
latexmk -pvc modelo-relatorio.tex   # recompila a cada gravação do arquivo (modo de edição)
latexmk -c                          # remove os auxiliares, preserva o PDF
latexmk -C                          # remove os auxiliares e também o PDF
```

Os comandos acima funcionam igualmente em Linux, macOS e Windows (`cmd.exe` ou PowerShell), desde que
`latexmk`, `xelatex` e `biber` estejam no `PATH`.

### Compilação manual (sem `latexmk`)

Só é necessária se o `latexmk` não estiver disponível. A ordem importa, e o XeLaTeX precisa rodar
duas vezes ao final para que as referências cruzadas, o sumário e as listas fiquem corretos:

```bash
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
biber modelo-relatorio
makeglossaries modelo-relatorio
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
```

O passo do `makeglossaries` só é necessário se o documento usar abreviaturas ou símbolos. Se a sua
configuração de `biblatex` usar `bibtex` em vez de `biber`, troque o comando correspondente.

Atenção: neste fluxo manual os arquivos auxiliares e o PDF ficam na raiz do projeto, não em `build/`.

## Metadados da capa / folha de rosto

Edite `modelo-relatorio.tex` para preencher os metadados:

- `\title{...}` — título
- `\subtitle{...}` — subtítulo (opcional). Passe **só o texto**, sem dois-pontos: a NBR 14724:2024 §4.1.1, alínea d) exige que o subtítulo seja "precedido de dois-pontos, evidenciando a sua subordinação ao título", e o modelo insere essa pontuação sozinho. Sem subtítulo declarado, nenhum dois-pontos aparece.
- `\fulltitle` — o título completo composto: título + `:` + subtítulo (ou só o título, se não houver subtítulo). É totalmente expansível, então serve dentro de `\edef`, de metadados de PDF (`\hypersetup{pdftitle={\fulltitle}}`) e de referências cruzadas, sem precisar recompor a string à mão.

  Na capa e na folha de rosto, título e subtítulo são diagramados como um **bloco contínuo** — sem quebra de parágrafo entre eles, fluindo como um texto só —, ambos em caixa alta, distinguidos apenas pelo peso: título em negrito, subtítulo sem negrito. No restante do documento (folha de aprovação), o mesmo bloco aparece em caixa normal.
- `\author{...}` — autor(es) (use `\\` para múltiplos autores)
- `\supervisor{...}` — orientador (opcional)
- `\cosupervisor{...}` — coorientador (opcional)
- `\subject{...}` — disciplina ou assunto
- `\abstract{...}` e `\keywords{...}` — resumo e palavras-chave

### Folha de aprovação

Metadados adicionais, usados apenas pela folha de aprovação (todos opcionais):

- `\aprovacaodata{...}` — data de aprovação. Sem ela, a folha simplesmente não imprime essa linha (em vez de um campo em branco estranho).
- `\notaaprovacao{...}` — nota, quando a instituição usa esse campo. Mesmo comportamento se omitida.
- `\empresasupervisor{...}` — supervisor de estágio na empresa; só usado pelo tipo `estagio`.
- `\bancamembro{Nome}{Titulação}{Instituição}` — adiciona um membro à banca examinadora; só usado pelos tipos `tcc`/`dissertacao`. Chame uma vez por membro esperado — inclusive com os três campos em branco, se os nomes ainda não forem conhecidos: o resultado é um bloco de assinatura corretamente formatado, mas em branco (a folha é impressa para ser assinada depois), não um erro.

## Macros e comandos personalizados (resumo rápido)

O pacote `UnifeiICTReport.sty` fornece várias macros úteis. Abaixo há uma lista curta com exemplos de uso.

- `\supervisor{Nome do Orientador}` — define orientador mostrado na capa.
- `\cosupervisor{Nome do Coorientador}` — define coorientador.
- `\unifeifont{...}` / `{\unifeifont texto }` — aplica a fonte institucional (Exo2) quando disponível.
- `\unifeismallcaps{Texto}` — versão em small-caps (ou uppercase quando small-caps não estão disponíveis na fonte local).
- `\refcomp{}{rótulo}` — referência formatada com nome do tipo, número e título (ex.: `\refcomp{}{sec:ex}` produz "Subseção 2.1 - Objetivos"). O nome do tipo é resolvido automaticamente pelo `\autoref`, seguindo a nomenclatura da NBR 14724:2024 adotada pelo modelo: `\chapter` → Seção, `\section` → Subseção, `\subsection` → Subsubseção, `\subsubsection` → Parágrafo. O primeiro argumento é ignorado, existindo só para compatibilidade com `\reffigcomp` e afins.
- `\refcomp*{Tipo}{rótulo}` — versão estrelada: imprime `Tipo` literalmente. Use para rótulos que o `\autoref` não reconhece (contadores próprios, ambientes personalizados) ou quando quiser outro nome (ex.: `\refcomp*{Ilustração}{fig:exemplo}`).
- `\reffig{<label>}`, `\reftable{<label>}`, `\refeq{<label>}` — referências rápidas a figura, tabela e equação. `\refquadro{<label>}` e `\refgrafico{<label>}` fazem o mesmo para Quadro e Gráfico (veja abaixo).
- `\refeqcomp{<label>}` ou `\refeqcomp{<label>}[<nome opcional>]` — referência a equações no mesmo estilo de `\refcomp`; a forma com `[...]` permite passar um nome customizado para substituir o nome que viria de `\nameref*{...}`.
- `figuraabnt` / `tabelaabnt` / `quadroabnt` / `graficoabnt` — ambientes para figuras, tabelas, quadros e gráficos com a legenda garantidamente acima do conteúdo, como exige a NBR 14724:2024 §5.8 (figuras, quadros, gráficos, ...) e §5.9 (tabelas). Rótulo e legenda são argumentos do ambiente, não comandos escritos no corpo, então não há ordem errada possível de digitar:

  ```latex
  \begin{figuraabnt}[!htbp]{fig:rotulo}{Legenda da figura}[Legenda curta]
      \includegraphics[width=0.9\textwidth]{arquivo}
      \fonte{o próprio autor}
  \end{figuraabnt}
  ```

  A posição do float (primeiro argumento, opcional) tem `[!htbp]` como padrão; a legenda curta (penúltimo argumento, opcional) só aparece na respectiva lista. `tabelaabnt`, `quadroabnt` e `graficoabnt` têm exatamente a mesma assinatura. Os ambientes `figure` e `table` continuam disponíveis, mas neles a posição da legenda depende da ordem do código, sem aviso caso saia fora da norma.

  Um último argumento opcional, entre `<` e `>`, declara a largura da ilustração (ex.: `<0.9\textwidth>`, repetindo o valor passado a `\includegraphics`). Quando presente, a legenda e o `\fonte{}` passam a acompanhar exatamente essa largura, como exige a NBR 14724:2024 §5.8. Sem ele, o comportamento é o de sempre: legenda na largura do bloco de texto, `\fonte{}` alinhado à largura medida do último gráfico.

  `quadroabnt` e `graficoabnt` têm numeração e lista próprias (`\listofquadros`/`\listofgraficos`, comentadas por padrão em `modelo-relatorio.tex`, como as demais listas opcionais), independentes de `figuraabnt`. Note a diferença entre Quadro e Tabela: o §5.9 reserva "Tabela" para conteúdo cujo dado central é numérico; um Quadro é uma ilustração comum (§5.8) cujo conteúdo central é textual, mesmo organizado em linhas e colunas. Veja o exemplo lado a lado em `Capitulos/cap2/cap2.tex`.

  Um tipo de ilustração que o modelo não prevê (Fluxograma, Organograma, ...) não exige editar o pacote: `\novotipoilustracao{<contador>}{<palavra designativa>}{<ambiente>}`, **no preâmbulo do seu documento**, declara um tipo novo — contador próprio, ambiente `<ambiente>` no mesmo molde acima, `\ref<contador>`/`\ref<contador>comp` e `\listof<contador>s` — a partir dessas três informações. É a mesma máquina que gera `quadroabnt` e `graficoabnt`:

  ```latex
  \novotipoilustracao{fluxograma}{Fluxograma}{fluxogramaabnt}
  ```

  Depois disso, `\begin{fluxogramaabnt}{flu:rotulo}{Legenda}` e `\reffluxograma{flu:rotulo}` funcionam como os tipos que já vêm no pacote.

- `\folhaaprovacao` ou `\folhaaprovacao[<tipo>]` — folha de aprovação (NBR 14724:2024 §4.2.1.3), elemento obrigatório. Chame logo depois de `\maketitle`, antes de `\makeabstracts`. `<tipo>` é opcional e vale `disciplina` (padrão), `estagio`, `tcc` ou `dissertacao`; um tipo desconhecido é erro de compilação, não renderiza o padrão silenciosamente. Reaproveita `\title`/`\subtitle`/`\author`/`\supervisor`/`\subject` já declarados para a capa — não precisam ser redeclarados. `disciplina` e `estagio` assinam com `\supervisor`/`\empresasupervisor`; `tcc`/`dissertacao` assinam com a banca declarada via `\bancamembro` (veja acima).
- `\apendices` / `\anexos` — abrem o grupo de apêndices/anexos pós-textuais (NBR 14724:2024 §4.2.3.3/§4.2.3.4), com uma entrada coletiva no sumário ("APÊNDICES"/"ANEXOS", não uma por letra). Chame uma vez, depois de `\backmatter`, antes do primeiro `\apendice`/`\anexo` do respectivo grupo.
- `\apendice{<rótulo>}{<título>}` / `\anexo{<rótulo>}{<título>}` — abre um apêndice/anexo, lettered A, B, ... independentemente (dois grupos, duas sequências). Título centralizado, com a mesma ênfase visual da seção primária, sem indicativo numérico. Referencie normalmente com `\refcomp{}{<rótulo>}` ou `\autoref{<rótulo>}` — resolvem para "Apêndice A"/"Anexo A" automaticamente, sem precisar de um comando de referência dedicado. Figuras, tabelas e outras ilustrações dentro de um apêndice/anexo continuam a sequência numérica normal do documento.

  ```latex
  \backmatter

  \apendices
  \apendice{ape:questionario}{Questionário aplicado na pesquisa}
  Conteúdo do apêndice, de autoria do próprio autor do relatório...

  \anexos
  \anexo{ane:certificado}{Certificado de participação no evento}
  Conteúdo do anexo, reproduzindo um documento de terceiros...
  ```

  Apêndice (§3.4) é de autoria do próprio autor; anexo (§3.3) reproduz um documento de terceiros. É essa autoria — não o formato do conteúdo — que decide entre os dois.
- `\fonte{texto}` — insere a informação de fonte abaixo de figuras/tabelas; alinha automaticamente à borda esquerda do último gráfico/tabela (usa internamente `\LastGraphicWidth`). Chame-o como último elemento **dentro** do ambiente: fora dele, a fonte se descola do float e fica perdida no corpo do texto.
- `\quote{<bibkey>}{<texto>}` — insere uma citação longa formatada (útil para citações diretas extensas); a chave `bibkey` aparece como citação à direita.
- `\makeabstracts` — imprime resumos (usado no driver `modelo-relatorio.tex`).

Notas rápidas sobre referências:

- Use `\printbibliography` (já presente no driver) para imprimir referências. Se alterar as opções
  do `biblatex`, ajuste o fluxo de compilação conforme indicado acima.
- Para listar abreviaturas e símbolos use `\printglossary[type=\acronymtype]` e `\printglossary[type=symbols]`.

## Fontes locais

O pacote tenta carregar fontes locais quando colocadas na pasta `Fontes/` (por exemplo
`Fontes/Exo2/`). Se as fontes não estiverem presentes, o estilo faz fallback para fontes do sistema.
Recomenda-se usar XeLaTeX ou LuaLaTeX para garantir corretamente o suporte a OpenType/UTF-8. A fonte
Exo 2 fornecida com o pacote faz parte do tema institucional, segundo o Manual de Identidade da Unifei.

## Boas práticas e solução de problemas

- Sempre use codificação UTF-8 nos arquivos (`.tex`, `.bib`).
- Se as referências aparecem como `?` ou nomes/legendas faltando, rode `latexmk modelo-relatorio.tex` mais uma vez; persistindo, apague os auxiliares com `latexmk -C` e compile do zero.
- Se houver erros relacionados a fontes (mktextfm), prefira instalar as versões OpenType ou ajustar
  a cadeia de fallback no `UnifeiICTReport.sty`.
- As fontes utilizadas neste template foram: Heuristica (fonte principal), Exo 2 (fonte
  institucional da Unifei), IBM Plex Mono (fonte monoespaçada).

## Contribuição

Sinta-se à vontade para abrir issues ou enviar patches com melhorias (ex.: suporte a mais pacotes,
ajustes de layout, exemplos adicionais de capítulos) via pull-request.

---
