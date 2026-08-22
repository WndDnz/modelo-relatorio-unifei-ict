## Modelo ABNT do ICT/Unifei

Modelo LaTeX para trabalhos acadêmicos dos cursos do Instituto de Ciências Tecnológicas (ICT) da
Universidade Federal de Itajubá. O pacote `UnifeiICTReport.sty` cuida da formatação exigida pelas
normas da ABNT — capa, folha de rosto, folha de aprovação, resumos, ilustrações, citações e
referências — para seis tipos de documento.

**A documentação de uso é o manual**, em `manual.tex`. Compile-o e leia o PDF: ele descreve tudo o
que o modelo oferece, com exemplos. Este README trata só de como começar.

## Qual arquivo copiar

Há um arquivo de partida por tipo, na raiz. Copie o seu, renomeie-o e escreva ali. Cada um já vem
com o tipo declarado e os metadados exigidos preenchidos com valor de exemplo, e compila sem edição
alguma.

| arquivo | documento | norma |
|---|---|---|
| `modelo-generico.tex` | relatório de disciplina *(padrão)* | NBR 14724:2024, no que couber |
| `modelo-estagio.tex` | relatório de estágio | NBR 14724:2024, no que couber |
| `modelo-tcc1.tex` | projeto de pesquisa (TCC 1) | **NBR 15287:2025** |
| `modelo-tcc2.tex` | monografia de conclusão de curso | NBR 14724:2024 |
| `modelo-dissertacao.tex` | monografia de mestrado | NBR 14724:2024 |
| `modelo-tese.tex` | monografia de doutorado | NBR 14724:2024 |

O tipo é declarado uma única vez, como opção do pacote, e governa o documento inteiro:

```latex
\usepackage[tipo=tcc2]{UnifeiICTReport}
```

Escolher o tipo errado nem sempre dá erro — o manual explica o que cada um muda, e o que fazer
quando um metadado obrigatório falta.

`manual.tex` **não é** um arquivo de partida: é o manual, e não deve ser copiado como base de
trabalho.

## Requisitos

- TeX Live (ou outra distribuição moderna) com `xelatex`.
- `biber`, para a bibliografia.
- `makeglossaries`, se o documento usar abreviaturas ou símbolos.
- `latexmk` — recomendado; o repositório já traz um `.latexmkrc` pronto.

## Como compilar

Na raiz do projeto:

```bash
latexmk modelo-tcc2.tex
```

O `latexmk` lê o `.latexmkrc`, decide sozinho quantas passadas de XeLaTeX são necessárias e chama o
`biber` quando a bibliografia muda. O PDF sai em `build/`.

```bash
latexmk -pvc modelo-tcc2.tex   # recompila a cada gravação (modo de edição)
latexmk -c                     # remove os auxiliares, preserva o PDF
latexmk -C                     # remove os auxiliares e também o PDF
```

Funciona igualmente em Linux, macOS e Windows, desde que `latexmk`, `xelatex` e `biber` estejam no
`PATH`. Compilar chamando o `xelatex` à mão também funciona, mas as passadas repetidas e os passos
da bibliografia e dos glossários passam a ser sua responsabilidade.

## Estrutura do repositório

- `manual.tex` — o manual do modelo. **Leia-o antes de escrever.**
- `modelo-*.tex` — os seis arquivos de partida, um por tipo.
- `UnifeiICTReport.sty` — o pacote: fontes, títulos, legendas, macros e utilitários.
- `Capitulos/` — os capítulos do manual, um por subdiretório.
- `Preambulo/` — listas de abreviaturas e de símbolos do manual.
- `referencias.bib` — referências **fictícias**, que servem aos exemplos do manual. Crie o seu.
- `Logos/`, `Fontes/` — logos e fontes locais.
- `.latexmkrc` — configuração de compilação (XeLaTeX, saída em `build/`).
- `build/` — saída da compilação; gerada automaticamente, fora do controle de versão.

## Solução de problemas

- Use codificação UTF-8 em todos os arquivos (`.tex`, `.bib`).
- Referências saindo como `?`, legendas faltando: compile mais uma vez; persistindo, `latexmk -C` e
  compile do zero.
- Erros de fonte: prefira instalar as versões OpenType. O modelo faz *fallback* para fontes do
  sistema quando as originais — Exo 2, Heuristica, IBM Plex Sans e Mono — não estão presentes.
- **Compilação limpa não prova saída correta.** Boa parte dos enganos deste modelo compila sem
  aviso algum. Abra o PDF e leia a página.

## Contribuição

Problemas no pacote, dúvidas sobre a formatação exigida e sugestões de melhoria são bem-vindos como
issues ou pull requests. Ao relatar um problema, informe o tipo de documento declarado e anexe, se
possível, um exemplo mínimo que o reproduza.
