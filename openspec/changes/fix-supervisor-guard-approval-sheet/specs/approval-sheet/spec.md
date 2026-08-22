## ADDED Requirements

### Requirement: Rótulo de papel sem nome não é emitido na folha de aprovação

A folha de aprovação SHALL NOT imprimir o rótulo de um papel — orientador, coorientador, professor responsável, supervisor de campo — quando o metadado correspondente não tiver sido declarado.

Quando o papel for indispensável ao tipo de documento, a ausência do metadado SHALL interromper a compilação com mensagem do pacote nomeando o que falta, em vez de produzir uma folha com rótulo sem nome.

Membro de banca declarado com campos em branco SHALL continuar rendendo um bloco corretamente formatado, conforme já previsto para a folha preparada antes de os nomes serem conhecidos. A distinção é entre metadado **não declarado** e metadado **declarado em branco**.

#### Scenario: Relatório de disciplina sem professor declarado

- **WHEN** o documento é do tipo `generico` e não declara `\supervisor`
- **THEN** a folha de aprovação sai sem bloco e sem rótulo de professor, e não com o rótulo sozinho

#### Scenario: Monografia sem orientador declarado

- **WHEN** o documento é do tipo `tcc2`, `dissertacao` ou `tese` e não declara `\supervisor`
- **THEN** o modelo nomeia o metadado que falta, em vez de emitir uma folha de aprovação sem quem oriente

#### Scenario: Banca declarada com campos em branco

- **WHEN** o documento chama `\bancamembro` com argumentos vazios
- **THEN** o bloco correspondente sai formatado e vazio, como hoje, para preenchimento posterior
