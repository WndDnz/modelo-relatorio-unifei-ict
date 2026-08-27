## Contexto

A folha de aprovação emite blocos de professor sem consultar flag de presença alguma, e com o metadado vazio produz rótulo sobre linha em branco — uma função atribuída a ninguém, numa página cuja finalidade é registrar quem aprovou. A folha de rosto não tem o defeito: ela consulta `\if@supervisorpresent` em `:1279`.

O levantamento feito ao desenhar esta change encontrou **quatro** sítios, não três, e os quatro cobrem os seis tipos:

```
:1450  orientador acadêmico   (estagio)
:1451  supervisor de campo    (estagio)     ← metadado sem flag de presença
:1461  professor/orientador   (generico)
:1497  orientador na banca    (tcc1, tcc2, dissertacao, tese)
```

## Decisões

### 1. A obrigatoriedade do orientador deriva do tipo

| tipo | orientador | comportamento sem o metadado |
|---|---|---|
| `generico` | opcional | omite o bloco e o rótulo |
| `estagio` | **obrigatório** | `\PackageError` nomeando o metadado |
| `tcc1` | **obrigatório** | idem |
| `tcc2` | **obrigatório** | idem |
| `dissertacao` | **obrigatório** | idem |
| `tese` | **obrigatório** | idem |

O `generico` é o único opcional porque não é só relatório de disciplina: serve a manual, memorial e outros documentos que diferem no conteúdo mas não na forma, e que não têm professor responsável no sentido usual. O `manual.tex` deste repositório é o caso vivo disso.

A repartição é a mesma de `areaobrig` e `absobrig` (`:157-158`), que já derivam obrigatoriedade do tipo — esta change acrescenta duas flags no mesmo molde, não um mecanismo novo.

### 2. O supervisor de campo é obrigatório no estágio

A folha de estágio é assinada por três partes — estagiário, orientador acadêmico e supervisor de campo. Sem o terceiro ela não registra o que existe para registrar, então `\empresasupervisor` entra na mesma cobrança do orientador.

Consequência prática: **`\if@empresasupervisorpresent` não precisa ser criada.** O erro dispara antes de a folha ser composta, então o sítio `:1451` nunca roda com valor vazio. Uma tarefa a menos.

### 3. O coorientador passa a constar da folha de aprovação

Hoje `\cosupervisor` só aparece na folha de rosto. Passa a sair também na folha de aprovação, logo abaixo do orientador, com rótulo próprio, **quando declarado** — continua opcional, e a flag `:814-816`, que já existe, passa a ser consultada num segundo lugar.

### 4. A guarda sobra em um sítio só

Com cinco dos seis tipos cobertos por erro, três dos quatro sítios deixam de ser alcançáveis com valor vazio:

```
:1450  coberto pelo erro do estagio
:1451  coberto pelo erro do estagio
:1497  coberto pelo erro dos quatro tipos com banca
:1461  ÚNICO que precisa de \if@supervisorpresent
```

O diff é: duas flags de obrigatoriedade, dois blocos de erro no `\AtBeginDocument` já existente, uma guarda, e a emissão do coorientador. Não são quatro guardas.

### 5. A cobrança mora no `\AtBeginDocument`

Pelo motivo que o comentário em `:866-869` já registra: cobrar antes de o preâmbulo inteiro ter sido lido acusaria falta de metadado que o autor declara duas linhas abaixo. É onde `areaobrig` e `absobrig` cobram, e onde estas cobram também.

Efeito colateral aceito: **`tcc1` sem banca não emite folha de aprovação** (D3), mas ainda assim exigirá `\supervisor`. É coerente — projeto de pesquisa tem orientador havendo defesa ou não — e fica registrado aqui porque não é óbvio lendo o código depois.

## Alternativas descartadas

- **Omitir em todos os seis tipos.** Descartada porque entrega folha de aprovação de tese sem orientador: compila limpo, sai plausível, e quem descobre é a banca. É exatamente o modo de falha que este repositório registra como o mais caro.
- **Exigir nos seis.** Descartada pelo `generico`, que é o tipo padrão e atende documentos sem professor responsável. O `manual.tex` cairia no erro.
- **Bloco em branco para o supervisor de campo, no molde do `\bancamembro`.** Descartada: o campo em branco da banca é deliberado e documentado (`approval-sheet/spec.md:135-136`) porque a folha é preparada antes de os nomes serem conhecidos, e a defesa acontece depois. O supervisor de campo é conhecido no primeiro dia do estágio; não há janela análoga.

## Limitação registrada, fora do escopo

O pacote **não tem flexão de gênero** nos rótulos. `\Unifei@papel` (`:160-161`, `:748-754`) alterna apenas singular e plural, e os rótulos são masculinos fixos — "Orientador", "Professor", "Aluno estagiário". O bloco do coorientador que esta change acrescenta sairá como "Coorientador" independentemente de quem seja, pelo mesmo motivo que a folha de rosto já imprime "ORIENTADOR". É pré-existente, não é desvio da norma — a NBR 14724:2024 não prescreve rótulo algum aqui — e não é resolvido por esta change.
