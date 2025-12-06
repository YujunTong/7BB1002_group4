# install_deseq2.R


# Install DESeq2 (latest compatible with R 3.6.1) + fdrtool

# Use a CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install BiocManager if needed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Set Bioconductor version suitable for R 3.6 (around 3.10)
BiocManager::install(version = "3.10", ask = FALSE)

# Install DESeq2 (Bioconductor will choose the compatible version for R 3.6.1)
BiocManager::install("DESeq2", ask = FALSE)

# Install fdrtool from CRAN
if (!requireNamespace("fdrtool", quietly = TRUE)) {
  install.packages("fdrtool")
}

# Print versions so you can record them
cat("R version:\n"); print(R.version.string)

if (requireNamespace("DESeq2", quietly = TRUE)) {
  cat("DESeq2 version:\n"); print(packageVersion("DESeq2"))
} else {
  cat("DESeq2 is NOT installed correctly.\n")
}

if (requireNamespace("fdrtool", quietly = TRUE)) {
  cat("fdrtool version:\n"); print(packageVersion("fdrtool"))
} else {
  cat("fdrtool is NOT installed correctly.\n")
}


