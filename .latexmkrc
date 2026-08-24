$pdf_mode = 5;
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$out_dir = 'build';
$aux_dir = 'build';
$clean_ext = 'bbl run.xml synctex.gz acn acr alg slo sls slg ist';

# Glossarios: sem estas regras o .acn e o .slo nunca viram .acr e .sls, e cada
# \printglossary fica sem conteudo. Sao duas, e nao tres, porque o glossario
# 'main' esta desligado (opcao nomain no UnifeiICTReport.sty).
#
# O driver e o makeglossaries em Perl, e nao o makeglossaries-lite: o -lite
# recusa a opcao -d ("Lua doesn't natively provide a function to change
# directory"), e com $aux_dir = 'build' os auxiliares nunca estao ao lado do
# .tex. A instalacao completa do TeX Live, que o manual pede, traz o Perl.
#
# O fileparse e o que resolve o $aux_dir: o latexmk entrega ao gancho o caminho
# completo do arquivo de dependencia, e o -d sai dali. Codificar 'build' aqui
# amarraria a regra ao valor definido tres linhas acima.
add_cus_dep('acn','acr',0,'run_makeglossaries');
add_cus_dep('slo','sls',0,'run_makeglossaries');
sub run_makeglossaries {
    my ($base, $path) = fileparse($_[0]);
    return system("makeglossaries", "-d", $path, $base);
}
