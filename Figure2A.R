
setwd("/Users/kennieng/Downloads/")

# read file
fig2A <- read.csv("Figure_2A.csv", header = TRUE)

head(fig2A)
str(fig2A)

library(tidyr)
library(ggplot2)


# Rearrangement of data 
fig2A_long <- pivot_longer(
  fig2A,
  cols = c("Replicate.1", "Replicate.2", "Replicate.3"),
  names_to = "Replicate",
  values_to = "Succinate"
)


# grouping
fig2A_long$Strains <- factor(
  fig2A_long$Strains,
  levels = c(
    "Parental_Chassis_Sz",
    "Evolved_E_Chassis_Sz",
    "Parental_Chassis",
    "Evolved_E_Chassis"
  ),
  labels = c(
    "Parental_producer_Sz",
    "Evolved_producer_Sz",
    "Parental_chassis_z",
    "Evolved_chassis_z"
  )
)


# ploting graphs
ggplot(fig2A_long, aes(x = Strains, y = Succinate)) +
  geom_point(position = position_jitter(width = 0.1)) +
  stat_summary(fun = mean, geom = "bar", alpha = 0.6) +
  stat_summary(fun.data = mean_sdl, geom = "errorbar", width = 0.2) +
  ylab("Succinic acid (g/L)") +
  xlab("") +
  theme_bw()

