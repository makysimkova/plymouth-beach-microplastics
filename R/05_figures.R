# Report figures 3 and 4, regenerated from the data as they appear in the submitted report.

report_site_labels <- c("Sutton Harbour Marina" = "Sutton Marina", "Yarmer Beach" = "Yarmer Beach")

# Figure 3 (base graphics, as in the report). Each panel has its own y-axis range;
# only the Sutton Marina axis is drawn.
png(path_figures("fig3_microplastics_by_site.png"), width = 9, height = 4.5, units = "in", res = 300)
par(mfrow = c(1, 2), oma = c(3, 3, 0, 0), mar = c(1, 2, 3, 1))
for (site in site_levels) {
  boxplot(microplastic ~ sample_type, data = filter(samples, location == site),
          col = sample_colours, main = report_site_labels[[site]],
          yaxt = if (site == site_levels[1]) "s" else "n", xaxt = "n", xlab = "", ylab = "")
}
mtext("Microplastic Abundance", side = 2, outer = TRUE, line = 1.5, font = 2)
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
plot.new()
legend("bottom", legend = names(sample_colours), fill = sample_colours,
       horiz = TRUE, bty = "n", cex = 1.1)
dev.off()

fig_regression <- ggplot(sediment, aes(litter, microplastic, colour = location)) +
  geom_point(alpha = 0.7, size = 2) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE) +
  scale_colour_manual(values = site_colours, labels = report_site_labels) +
  labs(x = "Litter Abundance", y = "Microplastic Abundance", colour = NULL)

save_fig(fig_regression, "fig4_litter_vs_microplastics.png")
