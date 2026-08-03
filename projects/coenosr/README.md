# coenosr

<!-- badges: start -->
<!-- badges: end -->

**coenosr** is a faithful reconstruction in R of the methodology embodied in the
1991 **COENOS** program — a compiled-Pascal tool for numerical phytosociology in
the Braun-Blanquet tradition, written by Adolf Ceska. COENOS sorts a raw
species-by-relevé table into a structured two-way table of *differential species
groups*, forming groups by inside/outside frequency rules and ordering them by
reciprocal averaging.

The original COENOS source is lost. The program still runs (under a DOS
emulator), but its method can no longer be read from the code. **coenosr**
recovers that method so it can be done again — legibly, in modern R, and
*verifiably*: the package is developed against tables the original program
produced, preserved here as bundled example data and decoded ground-truth
oracles.

## Status

Early development. This release provides:

- `read_rel()` — read a COENOS `.REL` relevé file into a tidy long table.
- `constancy()` — per-species occurrence counts.

Still to come: differential group formation (the inside/outside frequency
rules), reciprocal-averaging ordering, and the sorted two-way table output.

## Installation

```r
# install.packages("remotes")
remotes::install_github("kimbridges/coenosr")
```

## Example

```r
library(coenosr)

rel <- read_rel(system.file("extdata", "DIEREN.REL", package = "coenosr"))
rel
#> <coenos_rel> 18 relevés × 116 species, 356 occurrences

head(constancy(rel))
```

## Validation

The package ships three example datasets (`DIEREN.REL`, `ELLEN.REL`, and
`SET1.DAT` — the last a CRLF-formatted relevé file using a numeric cover scale)
and three decoded ground-truth tables (`*_s00_species.csv`) recovered from
COENOS's own `.S00` restart files. Each oracle records, per species, the exact
constancy, role, and group membership the 1991 program assigned. The test suite
checks `read_rel()` against all three oracles, so correctness is measured
against the real
program's output rather than asserted.

## Provenance

COENOS and its example datasets originate with Adolf Ceska's vegetation work.
This reconstruction is part of a small "lost technology" recovery effort; the
method is described in an accompanying specification developed alongside the
package.

## License

MIT © 2026 coenosr authors. The bundled example datasets derive from the
original COENOS distribution and are included for validation and demonstration.
