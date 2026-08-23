## Contexto

O `.latexmkrc` não configura regra para o `makeglossaries`, então `.acn` e `.slo` nunca viram `.acr` e `.sls`, e cada `\printglossary` produz uma página em branco. O `proposal.md` traz a medição do caso vazio, feita depois de a change ser registrada, e que invalidou a suposição de que o `.acn` sequer seria escrito.

## Decisões

### 1. Glossário sem entrada emite `\PackageWarning` nomeando a lista pulada

Mesma decisão, mesmo critério e mesma redação de `add-empty-list-guard`: o pacote nunca imprime glossário por iniciativa própria, então toda chamada de `\printglossary` presente no documento foi escrita por alguém, e calar esconde um pedido que não pôde ser atendido. Nos seis arquivos de partida as duas chamadas vêm comentadas, então esqueleto recém-copiado continua silencioso.

As duas changes tratam mecanismos diferentes — o bloco de listas do `.sty` e o pacote `glossaries` — e por isso as guardas não podem morar no mesmo lugar. O **comportamento visível**, esse, tem de ser o mesmo: é a mesma pergunta feita ao autor, e responder diferente em cada lista ensinaria uma regra que não vale.

### 2. O driver é o `makeglossaries` Perl

Não por preferência: o `makeglossaries-lite` **recusa a opção `-d`**, e o modelo compila com `$aux_dir = 'build'`, de modo que os auxiliares nunca estão ao lado do `.tex`. A mensagem do próprio script:

```
The '-d' option isn't available for this light-weight version.
(Lua doesn't natively provide a function to change directory.)
You will need to use the Perl version instead
or just change directory before running this script.
```

Verificado contra o `build/` real: `makeglossaries -d build manual` produz `manual.acr` (441 B) e `manual.sls` (297 B); `makeglossaries-lite -d build manual` produz nada e sai com erro.

A dependência de Perl não é objeção: o capítulo 2 promete instalação **completa** do TeX Live (`cap2.tex:11`), que traz o Perl no Windows, e o Perl é padrão nos demais sistemas.

Verificado ponta a ponta: com o `.acr` no lugar, a página 8 de `build/manual.pdf` — que saía inteiramente em branco — passa a trazer a lista de abreviaturas e a de símbolos com os itens efetivamente citados no texto.

### 3. O glossário `main` é desligado com `nomain`

O `glossaries` é carregado em `:350` com `acronym` e `symbols`, e mais o `main` implícito. O `main` **nunca foi usado, nunca foi documentado e não tem comando exposto** — e é ele que faz o `makeglossaries` avisar `File 'manual.glo' is empty` a cada compilação.

A decisão vem da Regra de Platina do projeto: o manual instrui o uso do pacote, lista todos os comandos e exemplifica. Capacidade que existe e não é documentada não tem terceira saída — ou vira documentação com exemplo, ou deixa de ser oferecida. Manter o `main` disponível e mudo é a única opção que a regra proíbe.

Como o escopo desta change é fazer o ciclo de compilação rodar, e não acrescentar elemento pós-textual, a saída aqui é desligar. Consequência para o manual, dentro desta change: o **glossário (§4.2.3.2)** entra na seção "O que este modelo não oferece" do capítulo 3 (`cap3.tex:188-197`), ao lado de errata, lombada e índice.

### 4. A regra é `add_cus_dep`, uma por tipo, com `fileparse` para achar o `$aux_dir`

Testada contra `$aux_dir = 'build'` em documento isolado, com os dois glossários e `nomain`:

```perl
add_cus_dep('acn','acr',0,'run_makeglossaries');
add_cus_dep('slo','sls',0,'run_makeglossaries');
sub run_makeglossaries {
    my ($base, $path) = fileparse($_[0]);
    return system("makeglossaries", "-d", $path, $base);
}
```

`latexmk` completou cinco passadas por conta própria e as duas listas saíram impressas com os itens citados. São **duas** regras, e não três, porque o `main` está desligado pela decisão 3.

O `fileparse` é o que resolve o `$aux_dir`: o latexmk entrega ao gancho o caminho completo do arquivo-fonte da dependência, e é dele que sai o `-d`. Codificar `build` na regra amarraria o `.latexmkrc` ao próprio valor que ele define três linhas acima.

### 5. A guarda do glossário vazio é em LaTeX, não no latexmk

Medido no modelo real: **apagar o `.acr` não remove a página em branco**. Qualquer número de `\printglossary` sem entrada custa uma página — uma só, não uma por chamada — e ela aparece com ou sem o arquivo gerado.

```
0 chamadas ............ 2 páginas
1 chamada  ............ 3 páginas
2 chamadas ............ 3 páginas
2 chamadas, sem .acr .. 3 páginas
```

Isso elimina de saída a solução mais barata que se poderia imaginar — fazer a regra do latexmk não emitir, ou apagar, o `.acr` de sete bytes. A página não vem do arquivo. A guarda mora em volta do `\printglossary`, no `.sty`, e é ela que emite também o `\PackageWarning` da decisão 1.

### 6. `$clean_ext` ganha os auxiliares de glossário

Os produzidos, verificados numa compilação limpa com `nomain`:

```
acn  acr  alg     siglas
slo  sls  slg     símbolos
ist               estilo, gerado por \makeglossaries
```

Sem `glo`, `gls` e `glg`, que só existiriam com o glossário `main` ligado.

## Alternativas descartadas

- **`makeglossaries-lite`.** Descartada por incompatibilidade medida com `$aux_dir`, não por preferência de linguagem.
- **Fazer o latexmk entrar em `build/` antes de chamar o `-lite`.** Descartada: troca uma dependência de Perl, que a instalação completa do TeX Live já satisfaz, por fragilidade de diretório na regra de compilação.
- **Implementar o glossário pós-textual do §4.2.3.2 e manter o `main`.** Descartada **desta** change por escopo, não por mérito: é funcionalidade nova, no `\backmatter`, ao lado de `\apendices` e `\anexos`, e fecharia uma ausência real da norma. Fica como candidata a change própria.
- **Manter o `main` como está.** Descartada pela Regra de Platina: capacidade oculta é o mesmo defeito de botão morto, visto do outro lado.
