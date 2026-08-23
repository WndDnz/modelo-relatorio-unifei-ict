## Why

Trabalhos acadêmicos passaram a ser escritos com apoio de ferramentas de inteligência artificial generativa, e instituições vêm exigindo que esse uso seja declarado. A ABNT não tem, hoje, norma que o reja: a NBR 14724:2024 não prevê o elemento, e nenhuma das normas que este modelo atende o menciona.

A aposta desta change é que isso muda — que a declaração de uso de IA vira elemento previsto, como a ficha catalográfica e a folha de aprovação são hoje. Registrá-la agora tem duas vantagens sobre esperar: o modelo atende desde já a exigência institucional que já existe em alguns programas, e chega à eventual norma com implementação rodada em vez de com pressa.

**A justificativa é declaradamente não normativa, e isso precisa estar dito no artefato**, porque este repositório atribui comportamento a parágrafo de norma como regra de trabalho, e um elemento sem norma que o sustente é a exceção. Ela é registrada aqui de propósito, e não escondida numa change maior.

Por isso esta change é separada de `add-optional-elements`, ainda que os dois elementos entrem na mesma região do documento e devam ser desenhados juntos: lá, cada elemento tem parágrafo que o exige e formato que a norma prescreve; aqui, não há nem um nem outro, e o modelo terá de escolher os dois.

## What Changes

O modelo passa a oferecer a página de Declaração de uso de Inteligência Artificial, como elemento opcional.

A decidir no design, e não aqui:

- **Onde entra.** Pré-textual, junto de errata e folha de aprovação, ou pós-textual, junto de apêndices e anexos. A escolha diz se a declaração é condição de leitura do trabalho ou informação complementar sobre como ele foi feito.
- **O que a página contém.** Texto livre do autor, formulário estruturado — ferramenta, versão, finalidade, trechos afetados — ou uma forma mista com campos sugeridos. Um formulário orienta quem não sabe o que declarar, e engessa quem sabe.
- **Se o modelo propõe texto padrão.** Um texto de exemplo é o que mais ajuda o autor e o que mais arrisca ser copiado sem leitura. O precedente da casa é o `\bancamembro` com campos em branco: forma correta, conteúdo do autor.
- **Como sobreviver à norma que ainda não existe.** Quando e se a ABNT normalizar o elemento, o formato provavelmente será outro. O desenho deve deixar isso barato: nome de comando que não prometa conformidade, e desvio registrado, no molde de D1–D4.
- **Se é opcional sempre.** Nenhum tipo a exige hoje. Se algum programa do ICT vier a exigi-la, a obrigatoriedade derivada do tipo já é o padrão da casa.

## Capabilities

### Added Capabilities

- `ai-usage-declaration`: elemento novo, sem norma que o reja e sem parentesco com os elementos existentes. Colocá-lo numa capability normativa faria um requisito sem norma conviver com requisitos que citam parágrafo, e a distinção entre os dois é justamente o que importa preservar aqui.

## Fora de escopo

- **Os elementos opcionais previstos pela norma**, que são de `add-optional-elements`.
- **Qualquer afirmação sobre conformidade ABNT do elemento.** Não há norma; o manual tem de dizer isso onde o documenta, e não deixar o leitor supor.

## Impact

- `UnifeiICTReport.sty` e o manual.
- Os seis arquivos de partida, se a declaração vier comentada como ponto de partida.
- Um desvio novo a numerar, do tipo "o modelo oferece o que a norma não prevê" — o inverso dos D1–D4 existentes, que são casos de o modelo divergir do que ela prevê.
