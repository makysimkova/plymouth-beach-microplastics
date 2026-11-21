# Data

Collected on 6–7 June 2025 at Yarmer Beach, Thurlestone (`thurlestone`) and Sutton Harbour Marina, Plymouth (`marina`). Licensed under CC BY 4.0.

## `raw/microplastics.csv`
One row per sample (24 rows: 18 sediment, 6 water).

| Column | Description |
|---|---|
| `sample` | Sample code: site (`TH`/`MA`) + strandline (`W` water, `L` low strand, `M` high strand, `V` vegetation line) + distance along transect in m (0/25/50) |
| `beach` | `thurlestone` = Yarmer Beach, `marina` = Sutton Harbour Marina |
| `water/sediment` | Sample type |
| `transect` | Macro-litter transect ID (sediment only; links to `macro_litter.csv`) |
| `coordinates` | GPS position, degrees and decimal minutes |
| `salinity` | Salinity in ppt (parts per thousand), water samples only |
| `microplastic` | Microplastic count. Water: particles in a 600 ml subsample, mean of two observers. Sediment: particles in a 10 ml pipetted subsample from 50 g of sediment |

**Known issue:** `THW0` and `THL0` (Yarmer Beach) were recorded with the Sutton Harbour Marina GPS reading (identical to `MAW0`). Their true position is unknown, so their coordinates are set to `NA` in `processed/samples_clean.csv`. The raw file is left as recorded. No analysis uses coordinates.

## `raw/macro_litter.csv`
Macro-litter items (plastic and other materials) found within 1 m on either side of each 50 m transect.

| Column | Description |
|---|---|
| `ID` | Transect ID (matches `transect` above) |
| `beach` | Site |
| `transect` | Strandline: low strand, high strand, vegetation line |
| `litter` | Number of litter items |

## `raw/interobserver_counts.csv`
Microplastic counts on 13 filters from Yarmer Beach water samples, counted independently by two observers (`obs1`, `obs2`). They are used for the inter-observer reliability test. The observer names were replaced by `obs1`/`obs2` and empty spreadsheet columns were removed; the counts are unchanged.

## `processed/samples_clean.csv`
Written by `R/01_clean_merge.R`. It has:
- site names
- sample type
- strandline
- decimal-degree coordinates (`lat`, `lon`; WGS84)
- salinity
- microplastic count
- the litter count of the sample's transect, for sediment samples
