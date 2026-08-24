## 1. A correção

- [x] 1.1 Acrescentar `\singlespacing` no topo da `minipage` de `\quote` (`:997-1008`), antes do `\normalsize\small`, de modo a cobrir o texto citado **e** a citação bibliográfica ao pé.
- [x] 1.2 Atualizar o comentário de `:989-996`, que descreve a aparência do bloco e hoje lista quatro características sem mencionar o espacejamento. Nomear o §7.1.1 e os quatro destaques que ele exige, para que a próxima leitura veja o que está sendo cumprido.
- [x] 1.3 **Não** tocar em `:938`. Ver `design.md` §3 — medido, não é pré-requisito, e mudaria a saída de todo documento existente.

## 2. Verificar lendo a página

- [x] 2.1 Compilar um documento com uma citação longa e medir a entrelinha dentro do bloco. Alvo: 13,60pt, contra os 20,40pt de hoje e os 21,75pt do corpo. O modo de medir está em `design.md`: imprimir `\the\baselineskip` dentro e fora.
- [x] 2.2 Ler a página. O bloco encolhe verticalmente; confirmar que continua recuado da margem esquerda, em letra menor e sem aspas — os quatro destaques do §7.1.1 ao mesmo tempo, e não três.
- [x] 2.3 Confirmar que legenda de figura (13,60pt), fonte de ilustração (13,60pt) e nota de rodapé (12,00pt) não mudaram. Estavam corretas antes e têm de continuar; são os números de referência registrados no `proposal.md`.
- [x] 2.4 Compilar `manual.tex` e ler as páginas que usam `\quote`. É mudança de saída num documento versionado.

## 3. Documentação

- [x] 3.1 Documentar no manual, onde `\quote` é apresentado, que a citação longa sai em espaço simples por exigência do §7.1.1, junto dos outros três destaques. É o tipo de coisa que o autor não deve ter de saber, mas que evita que alguém "corrija" o bloco achando que ficou apertado.

## 4. Ao arquivar

- [ ] 4.1 Criar a capability `direct-citation` em `openspec/specs/` a partir do delta. Ela é a primeira a governar a NBR 10520:2023 neste repositório; `bibliography-accuracy` cobre a 6023, que é outra coisa.
- [ ] 4.2 Registrar em change própria a conferência da **natureza do trabalho** e das **referências**, que o §5.2 também excetua do espacejamento 1,5 e que esta change não mediu. A natureza é gerada dentro do pacote; as referências vêm do biblatex.

## Registro de aplicação

Um `\singlespacing` no topo da `minipage` resolveu os dois casos de uma vez, como o `design.md` §2 previa. `:938` não foi tocado.

Medido no documento de teste, imprimindo `\the\baselineskip` em cada contexto:

| contexto | antes | depois |
|---|---|---|
| corpo do texto | 21,75pt | 21,75pt |
| dentro do `\quote` | 20,40pt | **13,60pt** |
| legenda de figura | 13,60pt | 13,60pt |
| fonte de ilustração | 13,60pt | 13,60pt |
| nota de rodapé | 12,00pt | 12,00pt |

Lendo a página: o bloco encolhe e continua recuado da margem esquerda, em letra menor e sem aspas — os quatro destaques do §7.1.1 ao mesmo tempo. A indicação da fonte ao pé do bloco acompanhou o espaçamento simples, que é o que a decisão §2 pedia.

`manual.tex` tem `\quote` no capítulo 4, e a página composta foi lida: o bloco sai visivelmente mais compacto que o texto ao redor. É mudança de saída num documento versionado, e está dita no manual — o parágrafo que apresenta o comando agora nomeia os quatro destaques e o §7.1.1, e avisa que o bloco é compacto de propósito, para que ninguém o "conserte".

Os seis arquivos de partida mantêm a paginação.
