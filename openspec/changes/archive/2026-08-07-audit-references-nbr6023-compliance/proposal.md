## Why

`referencias.bib` is the template's worked example of correct NBR 6023:2018 reference data — students copy its patterns. Auditing every entry against the guide (UFV *Normalização de trabalhos acadêmicos*, 2025, atualizada conforme NBR 14724/2024, NBR 6023/2018, NBR 10520/2023) and against biber's actual parsed output (`build/modelo-relatorio.bbl`) found real, reproducible bugs: institutional author names that get silently mis-split into personal-name components (given/family/prefix) instead of rendering as one unbroken entity name, plus one NBR self-reference citing a superseded edition year with a field pattern inconsistent with its sibling entries. Left uncorrected, these teach the wrong pattern to every future report author who copies them.

## What Changes

- Fix `techreport1`, `online1`, `manual1`, and `brasil2023`: wrap each institutional `author` field in double braces (`{{...}}`) so biber treats the name as one atomic unit instead of parsing it as `given`/`family`/`prefix` — confirmed broken today by inspecting `build/modelo-relatorio.bbl` (e.g. `techreport1` currently renders as family="Pesquisa X", given="Instituto", prefix="de" — i.e. would cite as "Pesquisa X, Instituto de" instead of "INSTITUTO DE PESQUISA X").
- Fix `nbr6028:2003`: rename to `nbr6028:2021` (NBR 6028's current edition is 2021, not 2003 — confirmed against the UFV guide), and switch its `institution` field to `author = {{Associação Brasileira de Normas Técnicas}}` to match the pattern already used by the sibling `nbr6023:2018` and `nbr14724:2024` entries.
- Fix the typo in `Capitulos/cap2/cap2.tex:249`: "NBR 14724:224" → "NBR 14724:2024" (the bib key `nbr14724:2024` itself is already correct — only the surrounding prose has the typo).
- Update any citation of the `nbr6028:2003` key (if present) to the renamed `nbr6028:2021` key.

## Capabilities

### New Capabilities
- `bibliography-accuracy`: the example `referencias.bib` renders every institutional author as its complete entity name (never mis-split into personal-name parts), and every ABNT self-reference in the file cites that norm's currently valid edition.

### Modified Capabilities
(none — no existing specs in this repo yet)

## Impact

- `referencias.bib`: 5 entries edited (4 brace fixes, 1 rename + field + year fix).
- `Capitulos/cap2/cap2.tex`: 1 typo fix; possible key-reference update if `nbr6028:2003` is cited anywhere by its old key (currently it is not, per `grep`).
- No `.sty` or document-structure changes. Requires a recompile to confirm the corrected entries render as expected in the bibliography and in-text citations.
