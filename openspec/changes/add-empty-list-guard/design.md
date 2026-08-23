## Contexto

As quatro listas de ilustração emitem título e página mesmo quando não há item algum. O contorno atual é por comentário nos seis arquivos de partida, e não protege o autor de um trabalho real que ainda não inseriu ilustrações ou que as retirou na revisão.

Três premissas com que esta change foi registrada caíram por medição, e estão anotadas no `proposal.md`: o `\@starttoc` não pode ser pulado (ele abre o stream de escrita), pular o título já basta (o `\@starttoc` sozinho não custa página), e "arquivo vazio" nunca é verdade (o `book.cls` grava um `\addvspace` por capítulo). O que segue são as decisões que restaram.

## Decisões

### 1. Lista pulada emite `\PackageWarning` nomeando a lista

Não emitir e calar deixa o autor que esperava a lista sem saber por que ela sumiu.

O que torna o aviso barato aqui é que **o pacote nunca emite lista por iniciativa própria**: não há chamada implícita em `\maketitle`, em `\folhaaprovacao` nem em lugar nenhum. Toda chamada presente no documento foi escrita por alguém. Logo o aviso não é ruído — ele responde a um pedido que não pôde ser atendido.

E, como os seis arquivos de partida trazem as quatro chamadas **comentadas**, esqueleto recém-copiado não emite aviso algum. O aviso aparece exatamente quando alguém descomenta e ainda não tem figura, que é o momento em que ele serve.

O mesmo critério vale para o glossário vazio em `fix-glossary-build`, e as duas devem sair iguais — é a mesma pergunta feita a dois mecanismos.

### 2. A detecção é por contador, não por leitura de arquivo

`\counterwithout{figure}{chapter}` e `{table}` (`:455-456`) e `within=none` nos tipos gerados (`:1131`) garantem que nenhum dos quatro contadores zera ao longo do documento. O valor no fim do documento é, portanto, o total, e o mesmo teste serve aos quatro tipos sem caso especial.

A flag vai ao `.aux`, que o latexmk já rerroda por conta própria.

Isto também neutraliza o `$aux_dir = 'build'`: como nada é lido de arquivo auxiliar, não há caminho de pasta de saída para o `\openin` resolver.

## Em aberto

**Como alcançar `\listofquadros` e `\listofgraficos`.** Elas não são do modelo: vêm do newfloat, via `\DeclareFloatingEnvironment` (`:1131`), com `\float@listhead` indefinido e nenhum gancho do pacote sobre elas — confirmado por `\show`, que expande `\listofquadros` para `\@nameuse{listofquadro}`. Uma guarda escrita nos `\renewcommand` do modelo (`:1605`, `:1615`) cobre metade das listas.

As duas só *parecem* iguais às do modelo porque `\titleformat{\chapter}` (`:1586`) aplica versal, Exo2 e azul a todo `\chapter*`, inclusive ao que o newfloat emite.

## Alternativas descartadas

- **Não chamar `\@starttoc` quando a lista está vazia.** Descartada por medição: em documento que **tem** uma figura, sem `\@starttoc` o `.lof` continua ausente depois da primeira e da segunda passada; com ele, sai com 94 bytes já na primeira. `\addcontentsline` descarta em silêncio quando o stream não está aberto, então a guarda ingênua tranca a lista desligada para sempre.
- **Testar se o arquivo auxiliar está vazio.** Descartada por medição: um documento com um capítulo e nenhuma figura já tem `.lof` de 20 bytes, contendo `\addvspace {10\p@ }` — o `book.cls` grava um por capítulo. O teste daria falso positivo em qualquer documento com uma divisão sequer, e a versão correta exigiria procurar `\contentsline` no arquivo, isto é, parsing.
- **Silêncio total ao pular a lista.** Descartada pelo argumento da decisão 1: como toda chamada é explícita, calar esconde um pedido não atendido. O precedente de `document-type/spec.md:137` — elemento opcional ausente compila sem aviso — não se aplica, porque lá o elemento ausente é o que o autor **não** pediu.
