## Modelo de Relatório Técnico-Científico (Unifei ICT)

Este repositório contém um modelo de relatório técnico-científico para os cursos do Instituto de Ciências Tecnológicas (ICT) da Unifei. O objetivo é fornecer um template pronto para uso com XeLaTeX/LuaLaTeX que já traz formatação institucional, capa e folha de rosto, estilos de título, tratamento de fontes e utilitários úteis (referências, glossários, figuras, tabelas, etc.).

### Estrutura do projeto

- `modelo-relatorio.tex` — arquivo principal (driver) do documento.
- `UnifeiICTReport.sty` — pacote de estilo personalizado que configura fontes, títulos, legendas, macros e utilitários.
- `referencias.bib` — arquivo BibTeX/BibLaTeX com exemplos de referências.
- `Capitulos/` — capítulos do relatório (cada capítulo em subdiretório).
- `Preambulo/` — arquivos auxiliares (lista de abreviaturas, símbolos, etc.).
- `Logos/`, `Fontes/` — recursos opcionais (logos e fontes locais).

## Requisitos

- TeX Live (ou outra distribuição moderna) com `xelatex` instalado.
- `biber` (recomendado) ou `bibtex` conforme sua configuração de `biblatex`.
- `makeglossaries` (se usar glossários/abreviaturas).
- Ferramentas opcionais: `latexmk` (automatiza as etapas de compilação).

## Como compilar (exemplos para Windows - cmd.exe / PowerShell)

1. Compilação mínima com XeLaTeX (duas execuções garantem referências cruzadas):

```cmd
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
```

2. Se usar `biber` para a bibliografia (com `biblatex`):

```cmd
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
biber modelo-relatorio
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
xelatex -interaction=nonstopmode -halt-on-error modelo-relatorio.tex
```

3. Gerar glossários (se aplicável):

```cmd
makeglossaries modelo-relatorio
```

4. Alternativa com `latexmk` (recomendado para fluxo de edição):

```cmd
latexmk -xelatex -pdf modelo-relatorio.tex
```

Observação: dependendo da sua instalação, `biblatex` pode usar `biber` (padrão moderno). Se o seu fluxo usa `bibtex`, substitua `biber` por `bibtex` nas instruções acima.

## Metadados da capa / folha de rosto

Edite `modelo-relatorio.tex` para preencher os metadados:

- `\title{...}` — título
- `\subtitle{...}` — subtítulo (opcional)
- `\author{...}` — autor(es) (use `\\` para múltiplos autores)
- `\supervisor{...}` — orientador (opcional)
- `\cosupervisor{...}` — coorientador (opcional)
- `\subject{...}` — disciplina ou assunto
- `\abstract{...}` e `\keywords{...}` — resumo e palavras-chave

## Macros e comandos personalizados (resumo rápido)

O pacote `UnifeiICTReport.sty` fornece várias macros úteis. Abaixo há uma lista curta com exemplos de uso.

- `\supervisor{Nome do Orientador}` — define orientador mostrado na capa.
- `\cosupervisor{Nome do Coorientador}` — define coorientador.
- `\unifeifont{...}` / `{\unifeifont texto }` — aplica a fonte institucional (Exo2) quando disponível.
- `\unifeismallcaps{Texto}` — versão em small-caps (ou uppercase quando small-caps não estão disponíveis na fonte local).
- `\refcomp{Tipo}{rótulo}` — referência formatada com nome do tipo, número, e nome (ex.: `\refcomp{Seção}{sec:ex}`).
- `\reffig{<label>}`, `\reftable{<label>}`, `\refeq{<label>}` — referências rápidas a figura, tabela e equação.
- `\refeqcomp{<label>}` ou `\refeqcomp{<label>}[<nome opcional>]` — referência a equações no mesmo estilo de `\refcomp`; a forma com `[...]` permite passar um nome customizado para substituir o nome que viria de `\nameref*{...}`.
- `\fonte{texto}` — insere a informação de fonte abaixo de figuras/tabelas; alinha automaticamente à borda esquerda do último gráfico/tabela (usa internamente `\LastGraphicWidth`).
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
- Se as referências aparecem como `?` ou nomes/legendas faltando, rode a sequência completa de compilação (XeLaTeX → Biber → XeLaTeX ×2) e execute `makeglossaries` quando necessário.
- Se houver erros relacionados a fontes (mktextfm), prefira instalar as versões OpenType ou ajustar
  a cadeia de fallback no `UnifeiICTReport.sty`.
- As fontes utilizadas neste template foram: Heuristica (fonte principal), Exo 2 (fonte
  institucional da Unifei), IBM Plex Mono (fonte monoespaçada).

## Contribuição

Sinta-se à vontade para abrir issues ou enviar patches com melhorias (ex.: suporte a mais pacotes,
ajustes de layout, exemplos adicionais de capítulos) via pull-request.

---
