## MODIFIED Requirements

### Requirement: Existe um arquivo de partida por tipo de documento, que compila sem edição

O repositório SHALL conter um arquivo de partida por tipo de documento admitido pela opção `tipo=`, com o tipo já declarado, os metadados exigidos por aquele tipo presentes e preenchidos com valor de exemplo, e os opcionais comentados com a explicação ao lado.

Metadado que o pacote preenche com padrão embutido SHALL aparecer no arquivo de partida, e não ser deixado implícito: preenchido com valor de exemplo quando o padrão estiver errado para a maior parte dos autores que o modelo atende, comentado com o padrão ao lado quando estiver certo. Um padrão silencioso produz saída plausível e errada, que não falha e não avisa.

Cada arquivo de partida SHALL compilar sem edição e sem erro, e SHALL produzir apenas páginas com conteúdo. Nenhum elemento cujo conteúdo dependa do que o autor ainda não escreveu pode ser chamado: listas de ilustrações, listas de tabelas, glossários e bibliografia ficam comentados enquanto não houver o que listar.

Nenhum arquivo de partida SHALL conter conteúdo de demonstração — texto de exemplo, ilustrações de amostra ou referências fictícias — nem apontar para arquivo que o contenha. É ponto de partida, não documento pronto a ser esvaziado.

Os arquivos de partida não importam arquivos externos: cada um é um documento completo em um arquivo só.

#### Scenario: Arquivo de partida recém-copiado

- **WHEN** o autor copia um arquivo de partida e compila sem alterar nada
- **THEN** a compilação termina sem erro e produz capa, folha de rosto e os elementos exigidos pelo tipo, sem nenhuma página de título seguida de vazio

#### Scenario: Metadado exigido pelo tipo

- **WHEN** um tipo exige um metadado que outro não exige
- **THEN** o arquivo de partida daquele tipo já o traz preenchido com valor de exemplo, e não comentado

#### Scenario: Metadado com padrão embutido no pacote

- **WHEN** o pacote imprime um metadado a partir de um padrão embutido, sem exigir declaração
- **THEN** o arquivo de partida o traz visível — preenchido se o padrão não serve à maioria, comentado com o padrão ao lado se serve —, para que o autor decida em vez de herdar sem saber

#### Scenario: Bibliografia antes de haver referências

- **WHEN** o autor ainda não criou seu arquivo de referências
- **THEN** o arquivo de partida não produz bibliografia alguma, e traz junto da chamada comentada a instrução de criar o próprio arquivo `.bib` — nunca apontando para o arquivo de referências fictícias que serve aos exemplos do manual

#### Scenario: Elemento desativado à espera de conteúdo

- **WHEN** uma chamada aparece comentada no arquivo de partida
- **THEN** vem acompanhada do que ela faz, de quando descomentá-la e do que acontece se for descomentada antes de haver conteúdo, para que não seja confundida com sobra esquecida

#### Scenario: Tipo novo admitido pela opção de pacote

- **WHEN** uma change acrescenta um valor à opção `tipo=`
- **THEN** um arquivo de partida correspondente passa a existir na mesma change
