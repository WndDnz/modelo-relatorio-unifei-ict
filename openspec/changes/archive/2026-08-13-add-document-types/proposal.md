## Why

O modelo atende hoje a um documento só. A folha de aprovação tem um parâmetro de tipo (`\folhaaprovacao[disciplina|estagio|tcc|dissertacao]`), mas ele governa apenas o layout daquela folha — todo o resto do documento é idêntico em qualquer caso. Isso não corresponde à gama de trabalhos que o ICT produz, e a taxonomia atual está com a forma errada em dois pontos:

- `tcc` funde dois documentos **regidos por normas diferentes**. Desde o PPC de 2023, o TCC do ICT é dividido em duas etapas: TCC1 é um planejamento, TCC2 é a conclusão do trabalho. O TCC1 segue a estrutura de projeto de pesquisa da **ABNT NBR 15287:2025**; o TCC2 é monografia, regida pela **ABNT NBR 14724:2024**. São documentos distintos, não graus de acabamento do mesmo documento.
- `dissertacao` aparece como irmão de `tcc`, quando dissertação, tese e TCC2 são o mesmo documento (monografia) com grau pretendido diferente.

Além disso, o tipo determina muito mais do que a folha de aprovação. Ele decide se a folha de aprovação **existe**, quantos resumos o trabalho tem, qual a natureza, quem consta na folha e quais metadados são exigidos. Enquanto for parâmetro de um comando só, cada uma dessas decisões fica espalhada e nenhuma é verificável.

Três defeitos concretos no que já está implementado, revelados ao levantar a composição real de cada tipo:

1. **O orientador não entra na banca.** Os tipos com banca renderizam só a lista de `\bancamembro`, mas a banca do ICT é *orientador + no mínimo dois membros externos*. Do jeito atual o autor precisa declarar o orientador uma segunda vez, duplicando o `\supervisor` já usado na capa.
2. **O relatório de estágio não tem o estagiário.** São três assinaturas — aluno estagiário, professor orientador e supervisor de campo —, e o modelo emite duas.
3. **`\supervisor` é valor único.** Disciplinas compartilhadas têm mais de um professor responsável, e cada um precisa do seu bloco.

## What Changes

- O tipo de documento passa a ser **opção de pacote, na forma chave-valor**: `\usepackage[tipo=tcc1]{UnifeiICTReport}`. Seis valores: `generico` (padrão), `estagio`, `tcc1`, `tcc2`, `dissertacao`, `tese`. A chave existe para que um valor digitado errado produza erro deste pacote, nomeando os aceitos — com a forma curta, ele seria indistinguível de um idioma e sairia como erro do babel.
- `tcc2`, `dissertacao` e `tese` selecionam o mesmo layout (monografia) mas **não são aliases puros**: diferem no grau pretendido e na obrigatoriedade de abstract e de área de concentração.
- A folha de aprovação deixa de receber o tipo por parâmetro e passa a consultar o tipo do documento. Ela some por completo no TCC1 quando não houve banca.
- **As linhas de assinatura saem de todos os tipos.** A folha passa a registrar composição da banca e data de aprovação, sem espaço para assinar — que é a prática das universidades desde que as defesas passaram a ser digitais, e o que se observa nas teses recentes publicadas no repositório da Unifei.
- A composição da folha passa a refletir cada tipo: professor(es) da disciplina; estagiário + orientador + supervisor de campo; orientador + membros externos.
- `\supervisor` passa a comportar mais de um professor, na mesma forma que a capa já aceita para vários autores, e o rótulo do papel passa a derivar do tipo — "Professor" no relatório genérico, "Orientador" nos demais.
- **Mudança incompatível, assumida:** `\folhaaprovacao` deixa de aceitar o tipo por parâmetro, e os valores antigos não sobrevivem como forma depreciada. `tcc` não é mapeável — divide-se em `tcc1` e `tcc2`, regidos por normas diferentes —, e a folha de aprovação foi criada no mesmo dia desta change, sem base instalada real. A forma antiga passa a falhar ensinando a nova.
- Novos metadados: grau pretendido, área de concentração e linha de pesquisa, com obrigatoriedade dependente do tipo.
- O abstract passa a ser opcional em todos os tipos, exceto dissertação e tese.
- A estrutura textual prescrita pela NBR 15287 §4.2.2 para o TCC1 é **documentada**, não gerada — ela não altera a configuração do sumário.

Não entra: o artigo científico, que substitui integralmente a monografia no TCC2 quando essa é a forma escolhida, e tem modelo à parte; e a Ata de Defesa, que já existe em forma eletrônica.

## Capabilities

### New Capabilities

- `document-type`: a seleção do tipo de documento por opção de pacote, os seis valores admitidos, a norma que rege cada um, e o que cada tipo determina — natureza, existência da folha de aprovação, resumos e metadados exigidos.

### Modified Capabilities

- `approval-sheet`: deixa de receber o tipo por parâmetro próprio e passa a consultar o tipo do documento; perde as linhas de assinatura; ganha a composição correta por tipo (orientador dentro da banca, estagiário no relatório de estágio, múltiplos professores no genérico); passa a poder não existir, no TCC1 sem banca.

## Impact

- `UnifeiICTReport.sty`: bloco de opções (`\DeclareOption`/`\ProcessOptions`, linhas ~18–38); `\supervisor` e os metadados vizinhos (~529); `\Unifei@AssinaturaBloco` e os quatro layouts de `\folhaaprovacao` (~1048–1180); `\makeabstracts` (~1008), que hoje emite os dois resumos incondicionalmente.
- `modelo-relatorio.tex`: a opção no `\usepackage`, os metadados novos e a chamada da folha sem parâmetro.
- `README.md`: a tabela de tipos e o que cada um exige.
- Interage com `approval-sheet` (spec principal, modificada aqui) e com `appendix-annex`, que **não muda**: a NBR 15287 §4.2.3.3/§4.2.3.4 usa exatamente a mesma regra de apêndices e anexos da 14724, então o que já existe serve ao TCC1 sem alteração.
- Sem efeito sobre ilustrações, legendas, citações ou referências.
