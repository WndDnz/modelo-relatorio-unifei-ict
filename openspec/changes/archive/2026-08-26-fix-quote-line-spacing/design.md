## Contexto

A citação direta com mais de três linhas sai em espaço um e meio, contra a NBR 10520:2023 §7.1.1 e a NBR 14724:2024 §5.2, que a excetuam do espacejamento do corpo. Medido: 20,40pt dentro do bloco contra os 13,60pt da entrelinha simples do `\small`.

As três decisões abaixo saíram de uma medição só, num documento de teste que compara os candidatos lado a lado.

## Decisões

### 1. `\singlespacing`, a interface do `setspace`

Os dois candidatos dão exatamente o mesmo resultado:

```
corpo do texto                              21.75pt
hoje, dentro do \quote                       20.40pt
com \singlespacing                           13.60pt
com \baselinestretch local + \selectfont      13.60pt
```

Empatados no efeito, decide o idioma. O `setspace` já é carregado em `:348`, e `\singlespacing` é a interface dele. `\baselinestretch` na mão é a forma que exige `\selectfont` para valer, e esquecê-lo é falha silenciosa — o tipo de defeito que este repositório paga caro.

### 2. A citação bibliográfica entra no mesmo grupo

O `\footnotesize\cite` ao pé do bloco (`:1004`) hoje também sai esticado: 18,0pt onde o simples seria 12,0pt. Ele é a indicação de fonte da citação, parte do bloco, e não texto corrido.

Um `\singlespacing` no topo da `minipage` cobre os dois de uma vez. Separar em dois grupos seria mais código para produzir a mesma página.

### 3. `:938` não é tocado

`\renewcommand{\baselinestretch}{1.5}` define o espacejamento global na mão, tendo o `setspace` carregado — mistura conhecida por surpreender. A tentação é arrumar de passagem.

Não se arruma. Medido: `\singlespacing` dentro do bloco dá 13,60pt **mesmo com o global definido na mão**, então não há defeito a corrigir aqui para esta change funcionar. Trocar `:938` por `\onehalfspacing` mudaria o espacejamento de todo documento existente, para obter a mesma página, em nome de idioma. É mudança de saída sem ganho de saída, e não pertence a uma change de conformidade normativa.

## Alternativas descartadas

- **`\baselinestretch` local com `\selectfont`.** Descartada por idioma, não por efeito: mede o mesmo 13,60pt. Exige o `\selectfont` para valer, e a omissão dele não dá erro — falha em silêncio.
- **Deixar a citação bibliográfica em 1,5.** Descartada: ela é parte do bloco citado, e o §5.2 excetua "fontes e legendas" do espacejamento do corpo pelo mesmo motivo. Além disso, custaria mais código.
- **Trocar `:938` pela interface do `setspace` na mesma change.** Descartada pela medição acima: não é pré-requisito de nada aqui, e mudaria a saída de todo documento existente.
