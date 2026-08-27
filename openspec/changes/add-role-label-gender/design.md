## Contexto

O modelo imprime rótulos de papel que ele mesmo gera, e todos são masculinos fixos. O caso mais
constrangedor está na documentação do próprio repositório: `Capitulos/cap3/cap3.tex:128-130` ensina

```latex
\supervisor{Prof. Dr. Nome do Orientador}
\cosupervisor{Prof. Dra. Nome da Coorientadora}
```

e o `modelo-tcc2.tex:59` traz a mesma linha comentada. Compilado — medido, não suposto — sai isto:

```
COORIENTADOR                              (folha de rosto)
Prof. Dra. Nome da Coorientadora

Prof. Dra. Nome da Coorientadora          (folha de aprovação)
Coorientador
```

O exemplo que o manual dá produz o rótulo errado sobre o nome que o próprio exemplo escolheu.

### Os sítios

| rótulo | onde | vem de |
|---|---|---|
| `\Unifei@papel` / `\Unifei@papelplural` | capa e folha de rosto (`:1525`), folha de aprovação do `generico` (`:1722`) | `\supervisor` |
| "Orientador" | banca (`:1742`) | `\supervisor` |
| "Orientador acadêmico" | folha do estágio (`:1704`) | `\supervisor` |
| "Coorientador" | folha de rosto (`:1529`) e folha de aprovação (`:1651`) | `\cosupervisor` |
| "Supervisor de campo" | folha do estágio (`:1708`) | `\empresasupervisor` |
| "Aluno estagiário" / "Alunos estagiários" | folha do estágio (`:1703`) | `\author` |
| "Autor" / "Autores" | capa (`:1508`) | `\author` |

Quatro pessoas, sete rótulos. O gênero é da pessoa, não do rótulo: os quatro primeiros descrevem a
mesma pessoa com palavras diferentes, e uma declaração por pessoa resolve os quatro.

### Duas restrições que o código impõe, e que decidem o desenho

**Um comando pode trazer várias pessoas.** `\supervisor{A\B}` é a forma documentada para disciplina
compartilhada, e `\Unifei@RegistroPorProfessor` (`:1631-1641`) emite **um bloco por nome, todos com o
mesmo rótulo**. Numa disciplina com uma professora e um professor, um dos dois blocos sai errado
qualquer que seja o valor único que se declare. Uma bandeira por comando não basta.

**Os rótulos não podem ser resolvidos no ponto de uso.** O bloco de `\AtBeginDocument` em `:829-842`
existe por isso, e o comentário acima dele registra o preço: o rótulo entra em `\unifeismallcaps`,
que aplica `\MakeUppercase` ao argumento, e um `\IfSubStr` ali dentro **trava a compilação em laço
infinito** — verificado por quem escreveu aquela linha. O rótulo do estagiário tem o mesmo problema
por outra via: é campo de `\Unifei@RegistroBloco`, que faz `\edef` no argumento.

Esse bloco já resolve a pluralização de dois rótulos, uma vez, quando os metadados já foram
declarados. É o lugar pronto para o gênero.

## Decisões

### 1. Argumento opcional com uma letra por pessoa

```latex
\supervisor[f]{Prof. Dra. Ana Silva}
\supervisor[fm]{Prof. Dra. Ana Silva\Prof. Dr. João Souza}
\cosupervisor[f]{Prof. Dra. Maria Costa}
```

A letra na posição *i* é o gênero do *i*-ésimo nome, `m` ou `f`. Sem argumento, tudo masculino — que
é a saída de hoje, para todo documento que já existe.

A alternativa era uma bandeira por comando, `[f]` valendo para o grupo inteiro. Ela custa o mesmo e
não resolve a disciplina compartilhada de gêneros diferentes, que é caso comum no ICT e é
justamente onde os dois rótulos aparecem lado a lado, um certo e um errado. A posição é lida no
laço que **já** percorre os nomes; o custo é ler o *i*-ésimo caractere de uma cadeia.

### 2. Quatro comandos ganham o argumento; `\bancamembro` não

`\supervisor`, `\cosupervisor`, `\empresasupervisor` e `\author`. São os quatro que alimentam rótulo
gerado pelo modelo.

`\bancamembro` fica de fora porque a sua titulação é texto livre do autor — o arquivo de partida já
traz `\bancamembro{Prof. Dra. Nome da Membra}{Doutora em Área}{Unifei}`, flexionado à mão porque é
o autor quem escreve. Não há rótulo gerado ali para consertar.

`\author` é do `book`, e ganhar argumento opcional significa redefini-lo. É a única redefinição de
comando do núcleo nesta change, e a verificação contra a baseline cobre exatamente o risco: sem o
argumento, todo documento existente tem de sair idêntico.

### 3. As formas vêm em pares literais, não de um sufixo

"Orientador"/"Orientadora", "Professor"/"Professora", "Coorientador"/"Coorientadora",
"Supervisor de campo"/"Supervisora de campo", "Autor"/"Autora", "Aluno estagiário"/"Aluna
estagiária".

Quase todas se formam acrescentando "a" — e "Aluno estagiário" não, muda duas palavras. Uma regra de
sufixação acertaria cinco casos e erraria o sexto em silêncio, que é o modo de falhar mais caro
deste repositório. Par literal é chato, é auditável, e é a mesma escolha que `fix-natureza-agreement`
acabou de fazer pelo mesmo motivo: as duas formas de uma concordância moram juntas.

### 4. A resolução entra no `\AtBeginDocument` que já existe

Nada de mecanismo novo. O bloco de `:829-842` passa a resolver, além do plural, o gênero, e a
produzir os rótulos finais como macros simples — que é o que o `\MakeUppercase` e o `\edef` a
jusante exigem.

Para os rótulos que variam por pessoa dentro do laço, o laço recebe a cadeia de letras e escolhe o
par no ponto de emissão de cada bloco. Confirmar por medição que isso não reintroduz o laço infinito
é tarefa explícita, não suposição: é o defeito que já mordeu este arquivo uma vez.

### 5. O padrão é masculino, e não há aviso

Manter o masculino como padrão deixa idêntica a saída de todo documento já escrito. Exigir a
declaração quebraria todos eles de uma vez, por um defeito que não viola norma alguma — a NBR
14724:2024 não prescreve rótulo nesses pontos.

E não há aviso de gênero não declarado. Um aviso que dispara em toda compilação de todo documento
correto é ruído, e ruído gasta a atenção que os avisos deste pacote precisam ter quando importam.

### 6. Grupo misto: o rótulo coletivo vai ao masculino plural

O rótulo da capa é um só para o grupo. Com `[ff]` sai "Orientadoras"; com `[fm]`, "Orientadores",
que é a regra do português para grupo misto. Os rótulos individuais da folha de aprovação, esses,
saem certos um a um — que é o ponto da decisão 1.

## Alternativas descartadas

- **Inferir o gênero de "Dra." no valor declarado.** Tentadora: todos os exemplos do manual trazem
  "Prof. Dr." ou "Prof. Dra.", e a inferência sairia de graça. Descartada porque o valor é texto
  livre — `\supervisor{Ana Silva}` não traz título nenhum, "Prof." abrevia os dois gêneros, e um
  autor que escreva "Profa." ou "Prof.ª" cai fora da heurística sem saber. Errar por adivinhação é
  pior que errar por omissão: o autor que declara `[f]` sabe o que declarou.
- **Comando de metadado separado, `\generoorientador{f}`.** Mais um comando público por papel, cada
  um a documentar, todos podendo ser esquecidos longe do nome a que se referem. O argumento opcional
  fica onde o nome está.
- **Uma bandeira por comando, em vez de uma letra por pessoa.** Ver decisão 1: mesmo custo, e deixa
  errado o caso em que o erro é mais visível.
- **Exigir a declaração de gênero nos tipos em que o papel é obrigatório**, como
  `fix-supervisor-guard-approval-sheet` fez com o nome. Descartada: lá a ausência produzia uma folha
  de aprovação sem quem orientasse, que é defeito normativo; aqui produz um rótulo no gênero errado,
  que não é. Quebrar todo documento existente por isso é desproporcional.
- **Linguagem neutra como terceira forma.** Fora de escopo, e por decisão institucional, não de
  modelo — como o `proposal.md` já registra.
