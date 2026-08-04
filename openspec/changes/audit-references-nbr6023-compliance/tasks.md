## 1. Fix institutional author bracing

- [x] 1.1 In `referencias.bib`, wrap `techreport1`'s `author` field in double braces: `{{Instituto de Pesquisa X}}`.
- [x] 1.2 Wrap `online1`'s `author` field: `{{Instituto Nacional de Estatística}}`.
- [x] 1.3 Wrap `manual1`'s `author` field: `{{Equipe de Desenvolvimento do Sistema Y}}`; check whether the separate `organization = {Corporação Y}` field is still intended alongside it (visual check in task 4).
- [x] 1.4 Wrap `brasil2023`'s `author` field: `{{Governo do Brasil}}` (currently uncited — fix anyway since it's example content students may copy).

## 2. Fix NBR 6028 entry

- [x] 2.1 Rename the bib key `nbr6028:2003` to `nbr6028:2021`.
- [x] 2.2 Change `year = {2003}` to `year = {2021}`.
- [x] 2.3 Replace `institution = {Associação Brasileira de Normas Técnicas}` with `author = {{Associação Brasileira de Normas Técnicas}}`, matching the `nbr6023:2018`/`nbr14724:2024` pattern.
- [x] 2.4 `grep -rn "nbr6028:2003"` across `Capitulos/` and `modelo-relatorio.tex`; update any citation to the new `nbr6028:2021` key (none found as of this audit, but re-check since the file may have changed).

## 3. Fix cap2.tex typo

- [x] 3.1 In `Capitulos/cap2/cap2.tex:249`, change "NBR 14724:224" to "NBR 14724:2024" (the `\cite{nbr14724:2024}` key itself is already correct).

## 4. Verify

- [x] 4.1 Recompile `modelo-relatorio.tex` with `latexmk`.
- [x] 4.2 Inspect `build/modelo-relatorio.bbl` for the four re-braced entries — confirm each now has a single `family={{...}}` field with no separate `given`/`prefix`, matching the already-correct `ibge2020`/`nbr6023:2018` pattern.
- [x] 4.3 Visually check the compiled PDF's citations and bibliography list for `techreport1`, `online1`, `manual1`, `nbr6028:2021` — each should show the complete institution name, not an inverted personal-name-style fragment.
- [x] 4.4 Confirm `manual1`'s bibliography entry looks correct with both `author` and `organization` present (task 1.3) — adjust if it reads as duplicated.
