## ADDED Requirements

### Requirement: Lista opcional sem itens não é emitida

Lista de elementos que a NBR 14724:2024 trata como elemento opcional — lista de ilustrações (§4.2.1.9), lista de tabelas (§4.2.1.10) e as listas por tipo de ilustração (§5.8) — SHALL deixar de ser emitida quando não houver item algum a listar. Não emitir significa não imprimir título, não consumir página e não gerar entrada no sumário.

A ausência de itens SHALL ser detectada pelo próprio pacote, e não delegada ao autor sob a forma de uma chamada que ele precise lembrar de comentar.

#### Scenario: Documento sem nenhuma ilustração do tipo

- **WHEN** o documento chama a lista de um tipo de ilustração e nenhum elemento daquele tipo existe no texto
- **THEN** nenhuma página é emitida para aquela lista, e o sumário não a menciona

#### Scenario: Ilustrações retiradas na revisão

- **WHEN** um documento que tinha ilustrações passa a não ter nenhuma, sem que a chamada da lista seja removida
- **THEN** a lista deixa de ser emitida na compilação seguinte, sem exigir edição do arquivo do autor

#### Scenario: Lista com pelo menos um item

- **WHEN** existe ao menos um elemento a listar
- **THEN** a lista é emitida como hoje, sem alteração de estilo, de cabeçalho ou de posição
