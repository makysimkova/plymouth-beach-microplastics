# Inter-observer reliability of microplastic counts (13 Yarmer Beach water filters).
# Output: outputs/tables/icc.csv

counts <- read_csv(path_raw("interobserver_counts.csv"), show_col_types = FALSE)

icc_table <- lapply(c("consistency", "agreement"), function(type) {
  fit <- icc(counts[, c("obs1", "obs2")], model = "twoway", type = type, unit = "single")
  tibble(
    type     = type,
    icc      = fit$value,
    ci_lower = fit$lbound,
    ci_upper = fit$ubound,
    f        = fit$Fvalue,
    p_value  = fit$p.value,
    n        = fit$subjects
  )
}) |> bind_rows()

write_csv(icc_table, path_tables("icc.csv"))
