```r
print("hello world")
```

```r
pkgs <- c("tidyverse", "ggsci", "openxlsx", "googledrive")
```

```r
#Estimate time 20 minutes
install.packages(pkgs, dependencies = TRUE, repos = "https://cloud.r-project.org/")
```

```r
library(tidyverse)
library(ggsci)
library(openxlsx)
library(googledrive)
```

```r
# Define the file path
pheno_path <- "/content/Data/Phenotype.csv"

# Load the dataset
pheno <- read.csv(pheno_path)

# View the first few rows
head(pheno)

```

```r
# Check dimensions (rows, columns)
dim(pheno)
```

```r
# Display the structure of the dataframe
str(pheno)
```

```r
# Load the Differentially Expressed Gene (DEG) dataset
DEGdata <- read.csv("/content/Data/DEGs.csv")

# Preview the first 6 rows of the data
head(DEGdata)

```

```r
Copy and paste this into Gemini:

"I have a file called Phenotype.csv with columns for Age, Weight, and Height. I do not know how to code, so please write the complete R code for me to create a publication-quality figure formatted exactly for a Nature journal. 
I need you to create 5 distinct plots and combine them into one single, neat image:

Three simple histograms showing the distribution of Age, Weight, and Height. 
Two scatter plots showing the correlation between Age & Weight, and Height & Weight (please calculate and print the p-value directly on the plots).

Formatting rule: Make it look like a Nature paper. Use a clean white background, no grid lines, solid black axis lines, and Arial font. Use high-contrast, professional colors. Finally, give me the code to save it as a high-resolution 300 DPI PDF."
```

```r

# Install and load necessary packages
# Check if ggpubr and patchwork are installed, install if not.
pkgs_to_install_for_this_task <- c("ggpubr", "patchwork")
new_pkgs_for_this_task <- pkgs_to_install_for_this_task[!(pkgs_to_install_for_this_task %in% installed.packages()["Package"])]
if(length(new_pkgs_for_this_task)) {
  install.packages(new_pkgs_for_this_task, dependencies = TRUE, repos = "https://cloud.r-project.org/")
}

# Load all required libraries
library(tidyverse)
library(ggsci)
library(ggpubr) # For stat_cor
library(patchwork) # For combining plots
library(openxlsx)
library(googledrive)

# Define the file path
pheno_path <- "/content/Data/Phenotype.csv"

# Load the dataset
pheno <- read.csv(pheno_path)

# --- Define a custom theme for Nature-like formatting ---
# This theme sets up a clean white background, no grid lines, solid black axis lines,
# and attempts to use a sans-serif font (like Arial or Helvetica, if available).
theme_nature <- function() {
  theme_classic() + # Start with a classic theme for a good base
    theme(
      plot.background = element_rect(fill = "white", color = NA), # White plot background
      panel.background = element_rect(fill = "white", color = NA), # White panel background
      panel.grid = element_blank(), # Remove grid lines
      axis.line = element_line(color = "black", linewidth = 0.5), # Solid black axis lines
      axis.ticks = element_line(color = "black", linewidth = 0.5), # Solid black axis ticks
      text = element_text(family = "sans", size = 10), # Generic sans-serif font.
                                                    # For specific "Arial" font, you might need to install and load the `extrafont` package.
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12), # Centered, bold title
      axis.title = element_text(face = "bold", size = 10), # Bold axis titles
      axis.text = element_text(color = "black", size = 9), # Black axis text
      legend.position = "none", # No legend needed for these simple plots
      plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") # Add some margin around the plot
    )
}

# --- Create Histograms ---
# Using high-contrast, professional colors (selected from ggsci's 'tab10' palette)
hist_age <- ggplot(pheno, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "#1F77B4", color = "black", alpha = 0.8) +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency") +
  theme_nature()

hist_weight <- ggplot(pheno, aes(x = Weight)) +
  geom_histogram(binwidth = 5, fill = "#2CA02C", color = "black", alpha = 0.8) +
  labs(title = "Distribution of Weight", x = "Weight (kg)", y = "Frequency") +
  theme_nature()

hist_height <- ggplot(pheno, aes(x = Height)) +
  geom_histogram(binwidth = 5, fill = "#D62728", color = "black", alpha = 0.8) +
  labs(title = "Distribution of Height", x = "Height (cm)", y = "Frequency") +
  theme_nature()

# --- Create Scatter Plots ---
scatter_age_weight <- ggplot(pheno, aes(x = Age, y = Weight)) +
  geom_point(color = "#FF7F0E", alpha = 0.7, size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 0.5) + # Add linear regression line
  stat_cor(method = "pearson", aes(label = paste(..r.label.., ..p.label.., sep = "~", `)),
           p.accuracy = 0.001, r.accuracy = 0.01,
           label.x.npc = "left", label.y.npc = "top", size = 3) + # Display R and p-value
  labs(title = "Age vs Weight", x = "Age", y = "Weight (kg)") +
  theme_nature()

scatter_height_weight <- ggplot(pheno, aes(x = Height, y = Weight)) +
  geom_point(color = "#9467BD", alpha = 0.7, size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 0.5) + # Add linear regression line
  stat_cor(method = "pearson", aes(label = paste(..r.label.., ..p.label.., sep = "~", `)),
           p.accuracy = 0.001, r.accuracy = 0.01,
           label.x.npc = "left", label.y.npc = "top", size = 3) + # Display R and p-value
  labs(title = "Height vs Weight", x = "Height (cm)", y = "Weight (kg)") +
  theme_nature()

# --- Combine Plots using patchwork ---
# The / operator stacks plots vertically, and + arranges them horizontally.
# plot_annotation adds overall titles/tags. The '&' operator applies the theme to all sub-plots.
combined_plot <- (hist_age + hist_weight + hist_height) /
                 (scatter_age_weight + scatter_height_weight) +
  plot_annotation(tag_levels = 'A') & # Add labels (A, B, C, D, E) to each subplot
  theme(plot.tag = element_text(size = 12, face = "bold", family = "sans")) # Style for the subplot tags

# --- Save the combined figure as a high-resolution PDF ---
# The ggsave function saves the last plot or a specified plot object.
# units="in" specifies the units for width and height. dpi=300 is standard for print quality.
ggsave("phenotype_plots.pdf", plot = combined_plot,
       width = 15, height = 10, units = "in", dpi = 300, device = "pdf")

# Provide feedback to the user
print("The combined publication-quality figure 'phenotype_plots.pdf' has been generated and saved.")
print("It includes three histograms for Age, Weight, Height, and two scatter plots for Age vs Weight and Height vs Weight with correlation p-values.")
print("The figure is formatted with a clean white background, no grid lines, black axis lines, and high-contrast colors, aiming for a Nature-like style.")
print("A generic sans-serif font is used. If you require a specific 'Arial' font, you might need to install and configure the `extrafont` package in R.")

```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```

```r
print("hello world")
```
