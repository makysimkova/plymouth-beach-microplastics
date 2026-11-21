# Packages, paths and shared plotting settings used by every script.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(tidyr)
  library(stringr)
  library(ggplot2)
  library(patchwork)
  library(irr)
  library(broom)
  library(here)
})

path_raw       <- function(...) here("data", "raw", ...)
path_processed <- function(...) here("data", "processed", ...)
path_figures   <- function(...) here("outputs", "figures", ...)
path_tables    <- function(...) here("outputs", "tables", ...)

site_levels <- c("Sutton Harbour Marina", "Yarmer Beach")

site_colours   <- c("Sutton Harbour Marina" = "#FF6F91", "Yarmer Beach" = "#FF9F43")
sample_colours <- c("Sediment" = "#5F9E93", "Water" = "#4682B4")

theme_set(
  theme_minimal(base_size = 13) +
    theme(
      panel.grid.minor = element_blank(),
      strip.text       = element_text(face = "bold"),
      legend.position  = "bottom"
    )
)

save_fig <- function(plot, filename, width = 7, height = 4.5) {
  ggsave(path_figures(filename), plot, width = width, height = height, dpi = 300, bg = "white")
}
