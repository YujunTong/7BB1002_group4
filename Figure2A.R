library(shiny)
library(DESeq2)
library(tidyverse)
library(ggplot2)
library(fdrtool)
library(DT)


getwd()

setwd("/Users/kennieng/Desktop/count/")

counts_dir <- ("/Users/kennieng/Desktop/count")

list.files("output")



files <- list.files(counts_dir, pattern = "_counts.txt$", full.names = TRUE)



if (length(files) == 0) {
  stop("No *_counts.txt files found. Check your folder path or file names.")
}


files <- sort(files)

print(paste("Found", length(files), "HTSeq files."))


read_htseq <- function(file) {
  sample_id <- gsub("_counts.txt", "", basename(file))
  df <- read.table(file, header = FALSE, col.names = c("gene", sample_id))
  df <- df[!grepl("^__", df$gene), ]  # remove HTSeq summary rows
  return(df)
}

df_list <- lapply(files, read_htseq)

merged <- reduce(df_list, full_join, by = "gene")

merged <- merged[order(merged$gene), ]

write.table(
  merged,
  file = "count_matrix.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

cat("Merged matrix saved as: count_matrix.tsv\n")
































