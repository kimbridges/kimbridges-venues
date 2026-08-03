# What is in this folder, and what is not

_Added 2026-07-29, after two sets of deck definitions were found sitting in one
project with nothing saying which was which. That absence is how a phenology
mismatch went unnoticed for a month._

## These files are METHOD OUTPUT, not a printed kit

`deck_universal.csv`, `deck_taxonomist.csv` and `deck_ecologist.csv` are what
`discover_decks()` returned when it was pointed at an aggregated record. They are
the deck-discovery method's **answer for a corpus**: the facets a collector
archetype actually fills, with a first draft of Hawaii-appropriate values written
in by hand.

**None of them has ever been printed.**

## The kit that was printed lives one level up

`../QR_field_notes.csv` is the deck Kim printed, punched, assembled and
photographed on 2026-07-28. It is also what ships as `vouchr`'s example data
(`inst/extdata/QR_field_notes.csv`), and it is the vocabulary the book's prose and
figures use, so that the figures agree with the photographs.

Every payload decoded out of `photos/Example_1.jpg` appears in that file:

    Collected by: KW Bridges, YH Lau     (teal deck)
    Determined by: KW Bridges            (purple deck)
    Life Form: Shrub                     (pink deck)
    Abundance: Common                    (grey deck)
    Phenology: No Flowers                (yellow deck)
    Number: KWB 1243                     (loose identity card)

## The two are SUPPOSED to differ

This is not drift to be tidied away. It is the book's own argument sitting in the
filesystem: facets travel, value-sets are local, and the method hands back *your*
community's answer rather than someone else's. Forcing these files into agreement
with the printed kit would quietly contradict the thesis and would destroy a
discovery output to make one collector's working deck look canonical.

Two specific differences, both expected:

- **Phenology.** The printed deck asks about flowers (Abundant / Scattered / None)
  because that is what Kim's collecting needs. A discovery run over a broad corpus
  returns the standard phenophases instead.
- **Abundance.** The printed kit has an abundance deck; `decks/` does not. The
  method surfaces a facet when the corpus shows collectors filling it, and a
  collector adds a deck when the work calls for one. Neither is wrong.

## The rule

Do not reconcile the contents. Keep the provenance legible. If a third set of deck
files ever appears here, say in this file where it came from and whether it was
ever printed, because that one sentence is the whole difference between a record
and a pile of CSVs.
