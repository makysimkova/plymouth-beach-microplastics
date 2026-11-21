# Multiple linear regression of sediment microplastics on site and macro-litter.
# Outputs: outputs/tables/lm_coefficients.csv, lm_fit.csv, outputs/figures/figS1_lm_diagnostics.png

sed_lm <- lm(microplastic ~ location + litter, data = sediment)

write_csv(tidy(sed_lm, conf.int = TRUE), path_tables("lm_coefficients.csv"))

residual_shapiro <- shapiro.test(residuals(sed_lm))
lm_fit <- glance(sed_lm) |>
  select(r.squared, adj.r.squared, statistic, p.value, df, df.residual, nobs) |>
  mutate(shapiro_w = unname(residual_shapiro$statistic), shapiro_p = residual_shapiro$p.value)
write_csv(lm_fit, path_tables("lm_fit.csv"))

png(path_figures("figS1_lm_diagnostics.png"), width = 8, height = 8, units = "in", res = 200)
par(mfrow = c(2, 2))
plot(sed_lm)
dev.off()
