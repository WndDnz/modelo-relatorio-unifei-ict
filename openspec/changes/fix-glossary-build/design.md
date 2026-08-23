## Contexto

O `.latexmkrc` não configura regra para o `makeglossaries`, então `.acn` e `.slo` nunca viram `.acr` e `.sls`, e cada `\printglossary` produz uma página em branco. O `proposal.md` traz a medição do caso vazio, feita depois de a change ser registrada, e que invalidou a suposição de que o `.acn` sequer seria escrito.

Este documento registra a decisão já tomada. As demais continuam em aberto.

## Decisões

### 1. Glossário sem entrada emite `\PackageWarning` nomeando a lista pulada

Mesma decisão, mesmo critério e mesma redação de `add-empty-list-guard`: o pacote nunca imprime glossário por iniciativa própria, então toda chamada de `\printglossary` presente no documento foi escrita por alguém, e calar esconde um pedido que não pôde ser atendido. Nos seis arquivos de partida as duas chamadas vêm comentadas, então esqueleto recém-copiado continua silencioso.

As duas changes tratam mecanismos diferentes — o bloco de listas do `.sty` e o pacote `glossaries` — e por isso as guardas não podem morar no mesmo lugar. O **comportamento visível**, esse, tem de ser o mesmo: é a mesma pergunta feita ao autor, e responder diferente em cada lista ensinaria uma regra que não vale.

## Em aberto

- **`makeglossaries` ou `makeglossaries-lite`.** O primeiro é Perl, o segundo é Lua e vem com o TeX Live. A escolha decide se o modelo compila numa instalação mínima, que é o que o capítulo 2 do manual promete. Nesta máquina os dois binários existem, o que **não** responde a pergunta.
- **Como declarar as três regras sem repetir três vezes**, honrando `$aux_dir`.
- **A guarda do glossário vazio**, que é desta change desde a medição — o `.acr` de sete bytes com `\null` custa uma página em branco numerada mesmo depois de o passo de compilação entrar.
- **`$clean_ext`**, que hoje não lista os auxiliares de glossário.
