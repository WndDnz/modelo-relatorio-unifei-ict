## Why

O `document-type` declara o `tcc2` regido pela **ABNT NBR 14724:2024** e, ao mesmo tempo, dispensa nele o resumo em língua estrangeira. A norma não abre essa porta: seu §4.1 lista os elementos do trabalho acadêmico e marca

> Resumo em língua estrangeira **(obrigatório)**

sem qualificar por tipo de trabalho. O TCC2 é monografia completa — o documento final, defendido em banca —, e a norma trata dissertação, tese e monografia de graduação sob o mesmo regime.

O problema não é só a divergência: é que ela **não estava registrada**. Este repositório documenta com cuidado os desvios deliberados da norma — D1 a D4 têm justificativa em `design.md` e comentário espelhado no `.sty`, precisamente para que ninguém os "corrija" depois. Este desvio, maior que os quatro, não tinha nenhum dos dois. A assimetria é pior que a decisão: um desvio registrado é uma escolha, um desvio silencioso é indistinguível de um descuido.

A mensagem de erro que o pacote já emite para os tipos que exigem abstract cita exatamente o parágrafo que o `tcc2` estava contrariando:

```latex
{O tipo '\Unifei@doctype' exige \string\abstractseclang{...}.
 A NBR 14724:2024 \string\S 4.2.1.8 torna o resumo em língua
 estrangeira elemento obrigatório.}
```

## What Changes

- O resumo em língua estrangeira passa a ser **obrigatório no `tcc2`**, como já é em `dissertacao` e `tese`. Faltando, a compilação para nomeando o que falta — o mesmo tratamento que a área de concentração já recebe.
- `tcc1` **não muda**: segue com o abstract opcional. Não é desvio, é outra norma — ver "Decisões".
- `generico` e `estagio` **não mudam**: seguem a NBR 14724 "no que couber" e "e similares", sem vínculo estrito com a lista de elementos.

## Decisões

**Por que `tcc1` fica de fora.** O TCC1 é projeto de pesquisa, regido pela **NBR 15287:2025**, não pela 14724. Verificado no texto da norma: a palavra *resumo* **não ocorre uma única vez** nas 13 páginas da 15287. Seus elementos pré-textuais são folha de rosto (obrigatório), lista de ilustrações, lista de tabelas, lista de abreviaturas e siglas, lista de símbolos e sumário. Não há resumo a exigir — nem vernáculo, nem estrangeiro.

Manter o abstract opcional no `tcc1` portanto não diverge de nada. O que o modelo faz **a mais** que a 15287 é emitir sempre o resumo na língua do texto, que a norma tampouco pede; é oferta, não violação, e fica fora do escopo desta change.

**Nenhum desvio novo é criado, e nenhum resta.** Depois desta change, a obrigatoriedade do abstract está alinhada com a norma que rege cada tipo: 14724 §4.2.1.8 para `tcc2`, `dissertacao` e `tese`; 15287 (silente) para `tcc1`; sem vínculo estrito para `generico` e `estagio`. Não há D5 a registrar — a alternativa era registrar o desvio, e ela foi descartada em favor da conformidade.

## Capabilities

### Modified Capabilities

- `document-type`: dois requisitos mudam. *O resumo é obrigatório e o abstract depende do tipo* passa a incluir o `tcc2` entre os tipos que exigem o abstract. E *Os três tipos de monografia compartilham o layout mas não o comportamento* deixa de listar a obrigatoriedade de abstract entre o que os diferencia — depois desta change eles não diferem mais nisso. O segundo só foi notado na conferência do sync, e está registrado na tarefa 4.1.

## Fora de escopo

- **A verificação das palavras-chave em língua estrangeira.** O pacote valida `\abstractseclang` mas não `\keywordsseclang`, embora a norma trate as palavras-chave como parte do elemento resumo. É meia verificação, e o defeito **já existe** para `dissertacao` e `tese` — não é introduzido aqui. Change própria.
- **O resumo que o modelo emite no `tcc1` sem que a 15287 o peça**, mencionado acima.

## Impact

- `UnifeiICTReport.sty`: uma linha no ramo `tcc2` da cascata de tipos (`:192–195`), mais o comentário que registra a base normativa. A validação de `:870–878` já existe e passa a alcançar o `tcc2` sem alteração.
- `README.md`: a linha `tcc2` da tabela "o que muda entre eles" diz *opcional* na coluna abstract.
- `openspec/specs/document-type/spec.md`, via delta.
- Sem efeito sobre a folha de aprovação, a capa ou os demais metadados.
- **Interage com `rewrite-usage-guide`**, cuja tarefa 3.7 documenta a obrigatoriedade do abstract por tipo. Aplicar esta change antes evita que o manual nasça descrevendo o comportamento antigo.
