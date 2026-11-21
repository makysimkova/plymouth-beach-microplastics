# Clean the raw sample sheet and attach macro-litter counts to sediment samples.
# Output: data/processed/samples_clean.csv (one row per sample, 24 rows).

micro_raw <- read_csv(path_raw("microplastics.csv"), show_col_types = FALSE)
litter    <- read_csv(path_raw("macro_litter.csv"), show_col_types = FALSE)

# "N50°15.836' W003°51.696'" -> decimal degrees
dm_to_decimal <- function(coord, hemisphere) {
  pattern <- paste0(hemisphere, "\\s*(\\d+)°\\s*([0-9.]+)'")
  parts   <- str_match(coord, pattern)
  value   <- as.numeric(parts[, 2]) + as.numeric(parts[, 3]) / 60
  if (hemisphere %in% c("S", "W")) -value else value
}

samples <- micro_raw |>
  rename(sample_type = `water/sediment`) |>
  mutate(
    location    = recode(beach, thurlestone = "Yarmer Beach", marina = "Sutton Harbour Marina"),
    location    = factor(location, levels = site_levels),
    sample_type = str_to_title(sample_type),
    lat         = dm_to_decimal(coordinates, "N"),
    lon         = dm_to_decimal(coordinates, "W"),
    # THW0/THL0 were recorded with the Sutton Harbour GPS reading by mistake;
    # their true position is unknown, see data/README.md.
    across(c(lat, lon), ~ if_else(sample %in% c("THW0", "THL0"), NA_real_, .x))
  ) |>
  left_join(
    litter |> select(transect = ID, shore_height = transect, litter),
    by = "transect"
  ) |>
  mutate(shore_height = factor(shore_height, levels = c("low strand", "high strand", "vegetation line"))) |>
  select(sample, location, sample_type, transect, shore_height, lat, lon, salinity, microplastic, litter)

stopifnot(
  nrow(samples) == 24,
  sum(samples$sample_type == "Sediment") == 18,
  all(!is.na(samples$litter[samples$sample_type == "Sediment"]))
)

write_csv(samples, path_processed("samples_clean.csv"))

sediment <- filter(samples, sample_type == "Sediment")
water    <- filter(samples, sample_type == "Water")
