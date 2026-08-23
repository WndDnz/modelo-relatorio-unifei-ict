## Contexto

Seis metadados de instituição têm padrão embutido (`:790-801`) e nenhum dos seis arquivos de partida os declara. Cinco padrões estão certos para quem este modelo atende; `\course` não, porque Engenharia de Computação é um curso entre vários do instituto.

Ao desenhar esta change, dois fatos do `.sty` corrigiram o que a proposta supunha.

## Decisões

### 1. `\course` vem declarado; os outros cinco, comentados

O critério é o que o padrão faz com o autor típico. `\course` está errado para a maioria e, por isso, entra preenchido com valor de exemplo, como todo metadado que o autor precisa trocar. Os cinco restantes estão certos para todos os que este modelo atende e entram comentados, com o padrão ao lado: quem é do ICT vê que não precisa mexer, quem é de outro campus vê que pode.

### 2. A capa não imprime curso nem faculdade

`\@course` é impresso **só** em `:1235`, e `\@faculty` só em `:1233` — os dois dentro do bloco da folha de rosto. A capa (`:1201-1213`) imprime apenas `\@institution` e `\@location`.

O `Impact` da proposta dizia "a capa e a folha de rosto dos seis passam a imprimir o curso"; a capa nunca o imprimiu. Registrado aqui porque a verificação desta change — ler a página — precisa olhar a página certa, que é a **segunda**, e não a primeira.

### 3. `\stateacronym` passa a ser impresso na capa

Estava declarado, documentado no manual e ligado a nada. Ficava a escolha entre removê-lo e ligá-lo; a decisão é ligá-lo, com esta repartição:

```
capa             ITABIRA, MG                                 ← \@location, \@stateacronym
                 2026

folha de rosto   Itabira, Minas Gerais, 22 de agosto de 2026  ← inalterada, :1317
```

Abreviado onde a linha é curta e composta em versal; por extenso onde a linha já é corrida e a forma completa não estorva. A NBR 14724:2024 §4.2.1.1.1(f) pede o local da instituição na capa e não prescreve a forma, então a sigla é escolha do modelo, não exigência — e desambigua cidades homônimas.

Isto muda a página 1 dos seis tipos: mudança de saída, a verificar lendo a página.

## Alternativas descartadas

- **Remover `\stateacronym` junto com a linha do manual.** Descartada: o metadado é útil e já está documentado; ligá-lo custa uma linha e honra a documentação existente, em vez de apagar as duas coisas.
- **Trocar a sigla pelo estado por extenso em `:1317`.** Descartada: a folha de rosto tem linha corrida onde o nome completo não atrapalha, e a troca mexeria numa saída que hoje está correta.
- **Trocar o padrão de `\course` no `.sty` por vazio.** Descartada: faria a folha de rosto sair incompleta em vez de errada, o que é outra decisão. O padrão fica; o esqueleto é que passa a declarar.
