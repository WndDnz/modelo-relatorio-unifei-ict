# usage-guide Specification

## Purpose

Governa o que o repositório entrega a quem vai **usar** o modelo, e não o que o pacote faz — os arquivos de partida, um por tipo de documento, e o manual que os acompanha.

Existe porque a documentação ficou duas changes atrás da implementação: seis tipos de documento, folha de aprovação derivada do tipo, banca, área de concentração e abstract de obrigatoriedade variável foram entregues sem que uma linha do texto explicasse como usá-los. Não foi descuido, e sim ausência de regra — nenhuma change tinha como tarefa verificável documentar o que entregava.

## Requirements

### Requirement: Existe um arquivo de partida por tipo de documento, que compila sem edição

O repositório SHALL conter um arquivo de partida por tipo de documento admitido pela opção `tipo=`, com o tipo já declarado, os metadados exigidos por aquele tipo presentes e preenchidos com valor de exemplo, e os opcionais comentados com a explicação ao lado.

Cada arquivo de partida SHALL compilar sem edição e sem erro, e SHALL produzir apenas páginas com conteúdo. Nenhum elemento cujo conteúdo dependa do que o autor ainda não escreveu pode ser chamado: listas de ilustrações, listas de tabelas, glossários e bibliografia ficam comentados enquanto não houver o que listar.

Nenhum arquivo de partida SHALL conter conteúdo de demonstração — texto de exemplo, ilustrações de amostra ou referências fictícias — nem apontar para arquivo que o contenha. É ponto de partida, não documento pronto a ser esvaziado.

Os arquivos de partida não importam arquivos externos: cada um é um documento completo em um arquivo só.

#### Scenario: Arquivo de partida recém-copiado

- **WHEN** o autor copia um arquivo de partida e compila sem alterar nada
- **THEN** a compilação termina sem erro e produz capa, folha de rosto e os elementos exigidos pelo tipo, sem nenhuma página de título seguida de vazio

#### Scenario: Metadado exigido pelo tipo

- **WHEN** um tipo exige um metadado que outro não exige
- **THEN** o arquivo de partida daquele tipo já o traz preenchido com valor de exemplo, e não comentado

#### Scenario: Bibliografia antes de haver referências

- **WHEN** o autor ainda não criou seu arquivo de referências
- **THEN** o arquivo de partida não produz bibliografia alguma, e traz junto da chamada comentada a instrução de criar o próprio arquivo `.bib` — nunca apontando para o arquivo de referências fictícias que serve aos exemplos do manual

#### Scenario: Elemento desativado à espera de conteúdo

- **WHEN** uma chamada aparece comentada no arquivo de partida
- **THEN** vem acompanhada do que ela faz, de quando descomentá-la e do que acontece se for descomentada antes de haver conteúdo, para que não seja confundida com sobra esquecida

#### Scenario: Tipo novo admitido pela opção de pacote

- **WHEN** uma change acrescenta um valor à opção `tipo=`
- **THEN** um arquivo de partida correspondente passa a existir na mesma change

### Requirement: O manual documenta todo comando que o pacote oferece ao autor

Todo comando, ambiente, opção de pacote e metadado que `UnifeiICTReport.sty` expõe ao autor de um documento SHALL estar documentado no manual, com a forma de chamada, o efeito e a condição de obrigatoriedade quando ela variar por tipo. O que entra é o que o pacote oferece ao autor, e o prefixo não basta para decidir: além dos internos (`\Unifei@`, `\@`), ficam de fora os comandos que o pacote apenas redefine para si — parâmetros de layout herdados do LaTeX ou de outro pacote, e nomes de referência cruzada do `hyperref`. Entram os nomes gerados em tempo de execução por `\novotipoilustracao`, que não existem como definição no `.sty` e são igualmente do autor. A change que documentar SHALL registrar o critério aplicado, para que a fronteira seja verificável.

Uma change que acrescente, remova ou altere a forma de chamada de qualquer um deles SHALL atualizar o manual no mesmo escopo — a documentação não é trabalho posterior.

#### Scenario: Comando novo entregue por uma change

- **WHEN** uma change acrescenta um comando destinado ao autor
- **THEN** o manual passa a descrevê-lo na mesma change, e não em uma seguinte

#### Scenario: Comando cuja obrigatoriedade depende do tipo

- **WHEN** um metadado é exigido em alguns tipos de documento e opcional em outros
- **THEN** o manual diz em quais tipos ele é exigido, e o que acontece quando falta onde é exigido

#### Scenario: Comando cujo nome impresso difere do nome digitado

- **WHEN** o nome que o modelo imprime para um elemento difere do nome do comando que o produz
- **THEN** o manual apresenta os dois lado a lado e explica a razão da diferença, em vez de documentar apenas um dos dois

#### Scenario: Comando removido ou com forma de chamada alterada

- **WHEN** uma change remove um comando ou muda sua forma de chamada
- **THEN** nenhuma passagem do manual continua ensinando a forma antiga

### Requirement: Afirmação normativa nomeia a norma que efetivamente rege

Toda passagem do manual que atribua uma exigência a uma norma ABNT SHALL nomear a norma que de fato rege aquele elemento, e SHALL manter distintos os assuntos que normas distintas cobrem — em particular a citação no documento (NBR 10520) e a elaboração das referências (NBR 6023), que a redação anterior fundia.

Norma citada no corpo do manual SHALL ter entrada correspondente em `referencias.bib`.

#### Scenario: Elemento regido por norma diferente da principal

- **WHEN** o manual descreve um elemento regido por norma diferente da que rege o documento como um todo
- **THEN** a passagem nomeia essa norma, em vez de atribuir tudo à norma principal do tipo

#### Scenario: Desvio deliberado da norma visível ao leitor

- **WHEN** o modelo diverge da norma de propósito, de forma perceptível na saída
- **THEN** o manual declara o desvio e sua razão, em vez de apresentar o comportamento como se fosse o que a norma exige

#### Scenario: Conformidade obtida por meio indireto

- **WHEN** o modelo cumpre uma exigência da norma por um mecanismo interno que usa outro vocabulário
- **THEN** o manual o apresenta como conformidade, e não como desvio, distinguindo-o dos desvios deliberados

### Requirement: O manual documenta o que o pacote não oferece

Elemento que a norma aplicável liste e que o pacote não implemente SHALL ser declarado ausente no manual, em vez de omitido.

#### Scenario: Elemento previsto pela norma e não implementado

- **WHEN** a norma lista um elemento — obrigatório ou opcional — que o pacote não oferece comando algum para produzir
- **THEN** o manual declara a ausência, para que o autor a descubra antes de escrever e não ao procurar o comando

### Requirement: O manual demonstra as duas formas de organizar os arquivos

O modelo admite organizar as divisões do texto em arquivos separados ou escrever tudo em um arquivo só. Ambas SHALL estar demonstradas por artefato existente e compilável, e não apenas descritas: o próprio manual, organizado em arquivos importados, é a demonstração da primeira; os arquivos de partida, completos em um arquivo, são a demonstração da segunda.

Nenhum artefato de exemplo SHALL existir só para ilustrar uma dessas formas.

#### Scenario: Autor decide como organizar o trabalho

- **WHEN** o autor procura no manual como dividir seu texto em arquivos
- **THEN** o manual mostra o comando de importação em uso e aponta para si mesmo e para os arquivos de partida como os dois exemplos reais, ambos compiláveis

### Requirement: O README apresenta e direciona; o manual instrui

O README SHALL apresentar o modelo, listar os tipos de documento, indicar qual arquivo copiar e como compilar, e apontar para o manual.

Instrução detalhada de uso — forma de chamada, obrigatoriedade por tipo, justificativa normativa, exemplo comentado — SHALL viver apenas no manual. Nenhum conteúdo SHALL ser mantido em ambos: quando os dois precisarem tratar do mesmo assunto, o README o resume em uma frase e remete.

Instrução mínima escrita como comentário dentro de um arquivo de partida, no ponto em que é acionável, não conta como duplicação: ela e o tratamento do manual são registros diferentes do mesmo assunto.

#### Scenario: Assunto que interessa aos dois

- **WHEN** um assunto precisa aparecer no README e no manual
- **THEN** o README o trata em uma frase e remete ao manual, em vez de repetir o tratamento detalhado

#### Scenario: Mudança em comportamento já documentado

- **WHEN** uma change altera comportamento documentado
- **THEN** existe um único lugar a atualizar, porque o outro apenas remete
