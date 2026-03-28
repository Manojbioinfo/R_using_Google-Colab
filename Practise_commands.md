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
#Estimate time 25 minutes
# Install and load necessary packages
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

# Define the file path
pheno_path <- "/content/Data/Phenotype.csv"

# Load the dataset
pheno <- read.csv(pheno_path)

# --- Define a custom theme for Nature-like formatting ---
theme_nature <- function() {
  theme_classic() + 
    theme(
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA),
      panel.grid = element_blank(), 
      axis.line = element_line(color = "black", linewidth = 0.5), 
      axis.ticks = element_line(color = "black", linewidth = 0.5), 
      text = element_text(family = "sans", size = 10), 
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12), 
      axis.title = element_text(face = "bold", size = 10), 
      axis.text = element_text(color = "black", size = 9), 
      legend.position = "none", 
      plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") 
    )
}

# --- Create Histograms ---
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
  geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 0.5) + 
  # FIXED LINE BELOW: Removed the stray backtick and simplified the label format
  stat_cor(method = "pearson", label.x.npc = "left", label.y.npc = "top", size = 4) + 
  labs(title = "Age vs Weight", x = "Age", y = "Weight (kg)") +
  theme_nature()

scatter_height_weight <- ggplot(pheno, aes(x = Height, y = Weight)) +
  geom_point(color = "#9467BD", alpha = 0.7, size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 0.5) + 
  # FIXED LINE BELOW: Removed the stray backtick and simplified the label format
  stat_cor(method = "pearson", label.x.npc = "left", label.y.npc = "top", size = 4) + 
  labs(title = "Height vs Weight", x = "Height (cm)", y = "Weight (kg)") +
  theme_nature()

# --- Combine Plots using patchwork ---
combined_plot <- (hist_age | hist_weight | hist_height) /
                 (scatter_age_weight | scatter_height_weight) +
  plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(size = 14, face = "bold", family = "sans"))

# --- Save the combined figure as a high-resolution PDF ---
ggsave("/content/Data/phenotype_plots.pdf", plot = combined_plot,
       width = 12, height = 8, units = "in", dpi = 300, device = "pdf")

# Provide feedback
print("Success! The combined publication-quality figure 'phenotype_plots.pdf' has been generated and saved.")

```

```r
2. Prompt for the Volcano Plot (Main Figure)
Copy and paste this into Gemini:

"I have a file called DEGs.csv with columns for Gene_Symbol, log2FoldChange, and padj. Please write R code to create a professional Volcano Plot formatted for a Nature journal. 
Here is what I need:

Color the upregulated and downregulated genes in distinct, professional colors (like the Nature Publishing Group color palette).
Automatically find the top 5 most statistically significant marker genes and label them with their gene names. Make sure the text labels do not overlap with each other.
Draw dashed cutoff lines for significance.
Keep the design minimalist: clean white background, no grid lines, and Arial font. Give me the code to save the final plot as a high-resolution PDF."
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
