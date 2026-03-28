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
##Please check the path. If not set to the Data folder, you may need to specify"
# --- Save the combined figure as a high-resolution PDF ---
ggsave("/content/Data/phenotype_plots.pdf", plot = combined_plot,
       width = 12, height = 8, units = "in", dpi = 300, device = "pdf")

# Provide feedback
print("Success! The combined publication-quality figure 'phenotype_plots.pdf' has been generated and saved.")

```


```r
I have a file called Phenotype.csv containing clinical data. The columns include Age, Weight, Height, and Tumor_status (which contains two groups: 'Cancer' and 'Healthy'). Please write the complete, reproducible R code to create publication-quality plots comparing these two groups.
Here is exactly what I need:

Plot Type: Create three separate 'Box-Violin' plots (a violin plot with a narrow boxplot overlaid inside it) comparing 'Cancer' vs 'Healthy' for Age, Weight, and Height.
Statistics: Automatically perform a Wilcoxon statistical test comparing the two groups for each plot, and print the exact p-value directly on the charts using the ggpubr package.
Formatting (Nature Journal Style): Use a clean white background, no grid lines, and solid black axis lines. Make all text, numbers, and axis labels Arial, bold, completely black, and large enough to be easily readable. 
Colors: Use the ggsci package to apply the professional Nature Publishing Group (NPG) color palette for the groups.
Output: Combine these three plots side-by-side into one single image using the patchwork package. Include the code to save the final combined image as a high-resolution 300 DPI PDF.
```

```r

# **Estimate time 25 minutes**
# Install and load necessary packages
pkgs_to_install_for_this_task <- c("ggpubr", "patchwork", "ggsci")
new_pkgs_for_this_task <- pkgs_to_install_for_this_task[!(pkgs_to_install_for_this_task %in% installed.packages()["Package"])]
if(length(new_pkgs_for_this_task)) {
  install.packages(new_pkgs_for_this_task, dependencies = TRUE, repos = "https://cloud.r-project.org/")
}

# Load all required libraries
library(tidyverse)
library(ggsci)   # For NPG color palette
library(ggpubr)  # For stat_compare_means (Wilcoxon test and p-value display)
library(patchwork) # For combining plots

# Define the file path
pheno_path <- "/content/Data/Phenotype.csv"

# Load the dataset
pheno <- read.csv(pheno_path)

# Ensure Tumor_status is a factor for proper grouping
pheno$Tumor_status <- factor(pheno$Tumor_status, levels = c("Healthy", "Cancer"))

# --- Define a custom theme for Nature-like formatting ---
theme_nature_comparison <- function() {
  theme_classic() + # Start with a classic theme for a good base
    theme(
      plot.background = element_rect(fill = "white", color = NA), # White plot background
      panel.background = element_rect(fill = "white", color = NA), # White panel background
      panel.grid = element_blank(), # Remove grid lines
      axis.line = element_line(color = "black", linewidth = 0.5), # Solid black axis lines
      axis.ticks = element_line(color = "black", linewidth = 0.5), # Solid black axis ticks
      text = element_text(family = "sans", face = "bold", color = "black", size = 12), # Arial (sans-serif), bold, black, readable size
      plot.title = element_text(hjust = 0.5, face = "bold", size = 14), # Centered, bold title
      axis.title = element_text(face = "bold", size = 12), # Bold axis titles
      axis.text = element_text(color = "black", face = "bold", size = 10), # Black, bold axis text
      legend.title = element_blank(), # Remove legend title
      legend.position = "top", # Position legend at the top
      legend.text = element_text(size = 10, face = "bold"),
      plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") # Add some margin around the plot
    )
}

# --- Function to create Box-Violin plots with Wilcoxon test ---
create_box_violin_plot <- function(data, y_var, y_label) {
  ggplot(data, aes_string(x = "Tumor_status", y = y_var, fill = "Tumor_status")) +
    geom_violin(trim = FALSE, alpha = 0.6, linewidth = 0.5) + # Violin plot for distribution
    geom_boxplot(width = 0.2, fill = "white", outlier.shape = NA, linewidth = 0.5) + # Narrow white boxplot inside
    geom_jitter(color = "black", size = 0.8, alpha = 0.3, width = 0.15) + # Individual data points
    scale_fill_npg() + # Nature Publishing Group color palette
    labs(title = paste("Comparison of", y_label, "by Tumor Status"),
         x = "Tumor Status",
         y = y_label) +
    stat_compare_means(comparisons = list(c("Healthy", "Cancer")),
                       method = "wilcox.test",
                       label.y = max(data[[y_var]]) * 1.05, # Position p-value above max value
                       label = "p.format",
                       size = 4, # Font size for p-value
                       face = "bold", # Make p-value bold
                       color = "black") + # Make p-value black
    theme_nature_comparison()
}

# --- Create the three individual plots ---
plot_age <- create_box_violin_plot(pheno, "Age", "Age (Years)")
plot_weight <- create_box_violin_plot(pheno, "Weight", "Weight (kg)")
plot_height <- create_box_violin_plot(pheno, "Height", "Height (cm)")

# --- Combine plots side-by-side using patchwork ---
combined_comparison_plot <- plot_age + plot_weight + plot_height +
  plot_annotation(tag_levels = 'A') & 
  theme(plot.tag = element_text(size = 14, face = "bold", family = "sans")) # Style for the subplot tags

# --- Save the combined figure as a high-resolution PDF ---
ggsave("/content/Data/phenotype_comparison_plots.pdf", plot = combined_comparison_plot,
       width = 16, height = 7, units = "in", dpi = 300, device = "pdf")

# Provide feedback
print("Success! The combined comparison figure 'phenotype_comparison_plots.pdf' has been generated and saved.")
print("It includes three box-violin plots for Age, Weight, and Height, comparing 'Cancer' vs 'Healthy' groups.")
print("Each plot shows the p-value from a Wilcoxon test, uses the NPG color palette, and is formatted in a Nature-like style with bold, black text.")

```



```r
2. Prompt for the Volcano Plot (Main Figure)
Copy and paste this into Gemini:

"I have a file called DEGs.csv with columns for Gene_Symbol, log2FoldChange, and padj. Please write R code to create a professional Volcano Plot formatted for a Nature journal. 
Here is what I need:

Color the upregulated and downregulated genes in distinct, make the font bold and clear to read and professional colors (like the Nature Publishing Group color palette).
Automatically find the top 5 most statistically significant marker genes and label them with their gene names. Make sure the text labels do not overlap with each other.
Draw dashed cutoff lines for significance.
Keep the design minimalist: clean white background, no grid lines, and Arial font. Give me the code to save the final plot as a high-resolution PDF."
```

```r
**#Estimate time 10 mins**

# Install and load necessary packages for this task
pkgs_to_install_for_this_task <- c("ggrepel")
new_pkgs_for_this_task <- pkgs_to_install_for_this_task[!(pkgs_to_install_for_this_task %in% installed.packages()["Package"])]
if(length(new_pkgs_for_this_task)) {
  install.packages(new_pkgs_for_this_task, dependencies = TRUE, repos = "https://cloud.r-project.org/")
}

# Load all required libraries
library(tidyverse)
library(ggsci)
library(ggrepel) # For non-overlapping text labels

# Load the Differentially Expressed Gene (DEG) dataset
DEGdata <- read.csv("/content/Data/DEGs.csv")

# --- Data Preparation for Volcano Plot ---
# Define significance thresholds
log2FC_threshold <- 1
p_value_threshold <- 0.05

# Calculate -log10(padj) for plotting
DEGdata$log10_padj <- -log10(DEGdata$padj)

# Create a 'Direction' column for coloring
DEGdata <- DEGdata %>%
  mutate(Direction = case_when(
    padj < p_value_threshold & log2FoldChange > log2FC_threshold ~ "Upregulated",
    padj < p_value_threshold & log2FoldChange < -log2FC_threshold ~ "Downregulated",
    TRUE ~ "Not significant"
  ))

# Identify the top 5 most statistically significant genes (smallest padj)
top_genes <- DEGdata %>%
  filter(Direction != "Not significant") %>%
  arrange(padj) %>%
  head(5)

# --- Define a custom theme for Nature-like formatting ---
theme_nature_volcano <- function() {
  theme_classic() + # Start with a classic theme for a good base
    theme(
      plot.background = element_rect(fill = "white", color = NA), # White plot background
      panel.background = element_rect(fill = "white", color = NA), # White panel background
      panel.grid = element_blank(), # Remove grid lines
      axis.line = element_line(color = "black", linewidth = 0.5), # Solid black axis lines
      axis.ticks = element_line(color = "black", linewidth = 0.5), # Solid black axis ticks
      text = element_text(family = "sans", size = 10), # Generic sans-serif font (e.g., Arial, Helvetica)
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12), # Centered, bold title
      axis.title = element_text(face = "bold", size = 10), # Bold axis titles
      axis.text = element_text(color = "black", size = 9),
      legend.title = element_blank(), # Remove legend title
      legend.position = "top", # Position legend at the top
      legend.text = element_text(size = 9),
      plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm") # Add some margin around the plot
    )
}

# --- Create the Volcano Plot ---
volcano_plot <- ggplot(DEGdata, aes(x = log2FoldChange, y = log10_padj, color = Direction)) +
  geom_point(alpha = 0.8, size = 1) +
  scale_color_manual(values = c("Upregulated" = "#E41A1C", 
                                "Downregulated" = "#377EB8", 
                                "Not significant" = "gray80")) + # Nature-like colors
  geom_hline(yintercept = -log10(p_value_threshold), linetype = "dashed", color = "black", linewidth = 0.4) +
  geom_vline(xintercept = c(-log2FC_threshold, log2FC_threshold), linetype = "dashed", color = "black", linewidth = 0.4) +
  geom_text_repel(data = top_genes, aes(label = Gene_Symbol), 
                  size = 4, fontface = "bold", box.padding = 0.5, point.padding = 0.5, 
                  segment.color = 'black', min.segment.length = 0, max.overlaps = Inf) + # Label top genes
  labs(title = "Volcano Plot",
       x = "Log2 Fold Change",
       y = "-log10(Adjusted P-value)") +
  theme_nature_volcano()

# --- Save the Volcano Plot as a high-resolution PDF ---
ggsave("/content/Data/volcano_plot.pdf", plot = volcano_plot,
       width = 8, height = 7, units = "in", dpi = 300, device = "pdf")

# Provide feedback
print("Success! The professional Volcano Plot 'volcano_plot.pdf' has been generated and saved with bold and clear gene labels.")

```


```r
I have a file called DEGs.csv containing my gene expression data. Using the significant genes from this file, please write R code to perform a Biological Pathway Enrichment Analysis for humans. Please specifically include the KEGG database, GO Molecular Function (GO:MF), and GO Biological Process (GO:BP). 
After running the analysis, create a professional bar chart showing the top 10 most significant results across these databases. 
Formatting rule: Format this chart for a Nature journal. Order the bars from the most significant pathway at the top to the least significant at the bottom. Color the bars based on their p-value (e.g., dark blue for highly significant, light blue for less significant). Make the background completely clean (no grid lines), use solid black axis lines, and use Arial font. Finally, include the code to save this as a high-resolution 300 DPI PDF.
```

```r
**#Estimated time=10min**

# Load all required libraries
library(tidyverse)
library(clusterProfiler)
library(org.Hs.eg.db) # For human gene annotations
library(ggplot2)
library(dplyr)
library(ggsci) # For NPG color palette

# Load the Differentially Expressed Gene (DEG) dataset
DEGdata <- read.csv("/content/Data/DEGs.csv")

# --- 1. Identify Significant Genes ---
# Define significance thresholds
log2FC_threshold <- 1
p_value_threshold <- 0.05

significant_genes <- DEGdata %>%
  filter(padj < p_value_threshold & abs(log2FoldChange) > log2FC_threshold) %>%
  pull(Gene_Symbol) # Extract Gene Symbols of significant genes

# Ensure there are significant genes to proceed
if (length(significant_genes) == 0) {
  stop("No significant genes found based on the defined thresholds. Adjust thresholds or check data.")
}

# --- 2. Gene ID Conversion: Gene Symbol to Entrez ID ---
# Map gene symbols to Entrez IDs
entrez_ids <- bitr(significant_genes, 
                   fromType = "SYMBOL", 
                   toType = "ENTREZID", 
                   OrgDb = org.Hs.eg.db)

# Extract unique Entrez IDs
genes_for_enrichment <- unique(entrez_ids$ENTREZID)

# --- 3. Perform Enrichment Analysis ---

# KEGG Pathway Enrichment (Fixed: Removed 'readable = TRUE')
kegg_enrichment <- enrichKEGG(gene = genes_for_enrichment,
                              organism = 'hsa', 
                              pvalueCutoff = p_value_threshold,
                              qvalueCutoff = 0.2)

# Make KEGG readable (Convert Entrez IDs back to Gene Symbols)
if (!is.null(kegg_enrichment)) {
  kegg_enrichment <- setReadable(kegg_enrichment, OrgDb = org.Hs.eg.db, keyType="ENTREZID")
}

# GO Biological Process (BP) Enrichment
gobp_enrichment <- enrichGO(gene = genes_for_enrichment,
                             OrgDb = org.Hs.eg.db,
                             ont = "BP", 
                             pvalueCutoff = p_value_threshold,
                             qvalueCutoff = 0.2,
                             readable = TRUE)

# GO Molecular Function (MF) Enrichment
gomf_enrichment <- enrichGO(gene = genes_for_enrichment,
                             OrgDb = org.Hs.eg.db,
                             ont = "MF", 
                             pvalueCutoff = p_value_threshold,
                             qvalueCutoff = 0.2,
                             readable = TRUE)

# --- 4. Combine and Filter Results for Top 10 ---

# Convert results to data frames and add a 'Source' column safely
kegg_df <- if(is.null(kegg_enrichment)) data.frame() else as.data.frame(kegg_enrichment) %>% mutate(Source = "KEGG")
gobp_df <- if(is.null(gobp_enrichment)) data.frame() else as.data.frame(gobp_enrichment) %>% mutate(Source = "GO:BP")
gomf_df <- if(is.null(gomf_enrichment)) data.frame() else as.data.frame(gomf_enrichment) %>% mutate(Source = "GO:MF")

# Combine all significant results
combined_results <- bind_rows(kegg_df, gobp_df, gomf_df) %>%
  filter(p.adjust < p_value_threshold) # Filter again based on adjusted p-value

# Select the top 10 most significant results based on p.adjust
top10_results <- combined_results %>%
  arrange(p.adjust) %>%
  head(10)

# Ensure there are results to plot
if (nrow(top10_results) == 0) {
  stop("No significant pathways/GO terms found after enrichment analysis. Adjust thresholds or check data.")
}

# --- 5. Create Bar Chart ---

# Define a custom theme for Nature-like formatting
theme_nature_pathway <- function() {
  theme_classic() + 
    theme(
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA),
      panel.grid = element_blank(),
      axis.line = element_line(color = "black", linewidth = 0.5),
      axis.ticks = element_line(color = "black", linewidth = 0.5),
      text = element_text(family = "sans", face = "bold", color = "black", size = 10),
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12),
      axis.title = element_text(face = "bold", size = 10),
      axis.text.x = element_text(color = "black", face = "bold", size = 9),
      axis.text.y = element_text(color = "black", face = "bold", size = 9),
      legend.title = element_text(face = "bold", size = 9),
      legend.text = element_text(size = 8),
      legend.position = "right",
      plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm")
    )
}

# Order the pathways by significance (p.adjust) for plotting
top10_results$Description <- factor(top10_results$Description, 
                                    levels = rev(top10_results$Description[order(top10_results$p.adjust)]))

pathway_plot <- ggplot(top10_results, aes(x = Description, y = -log10(p.adjust), fill = p.adjust)) +
  geom_bar(stat = "identity") +
  coord_flip() + 
  scale_fill_gradient(low = "#5D93B5", high = "#1C4E80", name = "Adjusted \nP-value") + 
  labs(title = "Top 10 Enriched Pathways / GO Terms",
       x = "Pathway / GO Term",
       y = "-log10(Adjusted P-value)") +
  theme_nature_pathway() +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)))

print(pathway_plot)

# --- 6. Save the plot as a high-resolution PDF ---
ggsave("/content/Data/pathway_enrichment_plot.pdf", plot = pathway_plot,
       width = 10, height = 7, units = "in", dpi = 300, device = "pdf")

print("Success! The professional pathway enrichment plot has been generated and saved.")

```

```r
**Prompt for the for the Bubble Plot**
I have a file called DEGs.csv containing gene expression data. Please write the complete, reproducible R code to perform a Biological Pathway Enrichment Analysis for humans using the clusterProfiler package. Include the KEGG database, GO Molecular Function (GO:MF), and GO Biological Process (GO:BP). 
Here is exactly what I need:

Data Processing: Identify significant genes (padj < 0.05, |log2FC| > 1), convert them to Entrez IDs, run the enrichment analyses, and extract the top 10 most significant results combined across all three databases.
Plot Type: Create a highly professional, publication-quality Bubble Plot (Dot Plot) to visualize these top 10 results. 
Plot Mapping: The Y-axis should be the Pathway/GO Term name. The X-axis should be the Gene Ratio. The size of the bubbles should represent the number of genes (Count), and the color of the bubbles should represent the adjusted p-value (p.adjust) using a continuous gradient (e.g., from red for high significance to blue for lower significance).
Formatting (Nature Journal Style): Use a clean white background, no grid lines, and solid black axis lines. Make all text, numbers, and axis labels Arial (or sans-serif), bold, completely black, and large enough to be easily readable. 
Output: Include the code to save the final plot as a high-resolution 300 DPI PDF using ggsave.
```

```r
I have an enrichment analysis result dataframe that contains columns for Description (pathway name), p.adjust, Count, and Source (e.g., KEGG, GO:MF, GO:BP). 
Please write R code using ggplot2 to create a highly professional, publication-quality Bubble Plot with the following mappings:

X-axis: Source (The database the pathway comes from).
Y-axis: Description (The name of the pathway or GO term).
Bubble Size: Count (Number of genes).
Bubble Color: p.adjust (Continuous gradient from red for high significance to blue for lower significance).

Data Filtering: Please group the data by Source and extract the top 5 most significant terms (lowest p.adjust) from each database so the plot is balanced.
Formatting (Nature Journal Style): Use a clean white background with a faint dashed grid so the viewer can easily align the bubbles with the axes. Make all text, numbers, and axis labels Arial (or sans-serif), bold, completely black, and large enough to be easily readable. Save the final plot as a high-resolution 300 DPI PDF.
```

```r
# Load required libraries
library(tidyverse)
library(ggplot2)

# Assuming your enrichment results are stored in a dataframe called `combined_results`
# (which matches the clipboard data you provided)

# --- 1. Filter and extract Top 5 terms PER SOURCE ---
top_results_by_source <- combined_results %>%
  filter(p.adjust < 0.05) %>%
  group_by(Source) %>%
  arrange(p.adjust) %>%
  slice_head(n = 5) %>% # Take the top 5 most significant from KEGG, GO:BP, GO:MF, etc.
  ungroup()

# Ensure the Description is ordered by Source and then by p.adjust for neat plotting
top_results_by_source <- top_results_by_source %>%
  arrange(Source, desc(p.adjust)) %>%
  mutate(Description = factor(Description, levels = unique(Description)))

# --- 2. Define Publication-Ready Theme ---
theme_nature_source_bubble <- function() {
  theme_bw() + # Clean white background with a border
    theme(
      panel.grid.major = element_line(color = "grey85", linetype = "dashed", linewidth = 0.5), # Faint dashed grid
      panel.grid.minor = element_blank(),
      panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
      text = element_text(family = "sans", face = "bold", color = "black", size = 10),
      plot.title = element_text(hjust = 0.5, face = "bold", size = 13),
      axis.title = element_text(face = "bold", size = 11),
      axis.text.x = element_text(color = "black", face = "bold", size = 11), # Larger X-axis text for Source
      axis.text.y = element_text(color = "black", face = "bold", size = 10),
      legend.title = element_text(face = "bold", size = 10),
      legend.text = element_text(size = 9),
      legend.position = "right",
      plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm")
    )
}

# --- 3. Create the Bubble Plot ---
source_bubble_plot <- ggplot(top_results_by_source, aes(x = Source, y = Description)) +
  geom_point(aes(size = Count, color = p.adjust)) +
  scale_color_gradient(low = "#E64B35", high = "#4DBBD5", name = "Adjusted\nP-value") + # NPG Red to Blue
  scale_size_continuous(name = "Gene Count", range = c(3, 8)) + # Adjust bubble size range for visibility
  labs(title = "Top Enriched Pathways by Database",
       x = "Database Source",
       y = "Pathway / GO Term") +
  theme_nature_source_bubble()

print(source_bubble_plot)

# --- 4. Save the Plot ---
ggsave("/content/Data/pathway_source_bubble_plot.pdf", plot = source_bubble_plot,
       width = 10, height = 8, units = "in", dpi = 300, device = "pdf")

print("Success! The bubble plot categorized by Source has been generated and saved.")

```

