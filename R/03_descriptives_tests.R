# Descriptive statistics, site comparisons (Kruskal-Wallis) and litter-microplastic correlation.
# Litter is recorded once per transect and analysed at the sediment-sample level,
# as in the report (each transect count appears for its three sediment samples).
# Outputs: outputs/tables/descriptives.csv, site_tests.csv

describe <- function(data, variable, label) {
  data |>
    group_by(location) |>
    summarise(
      n      = n(),
      median = median({{ variable }}),
      iqr    = IQR({{ variable }}),
      min    = min({{ variable }}),
      max    = max({{ variable }}),
      .groups = "drop"
    ) |>
    mutate(measure = label, .before = 1)
}

descriptives <- bind_rows(
  describe(water,    microplastic, "Microplastics, water"),
  describe(sediment, microplastic, "Microplastics, sediment"),
  describe(sediment, litter,       "Macro-litter")
)
write_csv(descriptives, path_tables("descriptives.csv"))

kruskal_row <- function(formula, data, label) {
  kw <- kruskal.test(formula, data = data)
  tibble(test = "Kruskal-Wallis", comparison = label,
         statistic = unname(kw$statistic), df = unname(kw$parameter), p_value = kw$p.value)
}

spearman <- suppressWarnings(cor.test(sediment$litter, sediment$microplastic, method = "spearman"))

site_tests <- bind_rows(
  kruskal_row(litter ~ location,       sediment, "Macro-litter by site"),
  kruskal_row(microplastic ~ location, water,    "Water microplastics by site"),
  kruskal_row(microplastic ~ location, sediment, "Sediment microplastics by site"),
  tibble(test = "Spearman", comparison = "Litter vs sediment microplastics",
         statistic = unname(spearman$estimate), df = NA_real_, p_value = spearman$p.value)
)
write_csv(site_tests, path_tables("site_tests.csv"))
