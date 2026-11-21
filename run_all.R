# Reproduces every table and figure from data/raw/.
# Run from the project root:  Rscript run_all.R

scripts <- c(
  "00_setup.R",
  "01_clean_merge.R",
  "02_interobserver.R",
  "03_descriptives_tests.R",
  "04_regression.R",
  "05_figures.R"
)

for (script in scripts) {
  message("Running ", script)
  source(file.path("R", script))
}
