# ==============================================================================
# Script: TCGA-DLBC Phenotype Data Cleaning and Anonymization
# Goal: Extract specific clinical variables, recode tumor status, and anonymize IDs
# ==============================================================================

# 1. Environment Setup
rm(list=ls())
library(openxlsx)
final_df=read.xlsx("DEGs.xlsx")
write.csv(final_df, "DEGs.csv", row.names = FALSE)

# 2. Load the Dataset
# Ensure the .rds file is in your working directory or provide the full path
data <- readRDS("Pheno_TCGA-DLBC.rds_DNAm_withbarcode.rds")

# 3. Data Extraction and Cleaning
# We create a new dataframe with only the required columns and clean data types
final_df <- data.frame(
  PatientID    = data$patient_id,
  Age          = as.numeric(data$age_at_initial_pathologic_diagnosis),
  Height       = as.numeric(data$height_cm_at_diagnosis),
  Weight       = as.numeric(data$weight_kg_at_diagnosis),
  Gender       = data$gender,
  Tumor_status = data$tumor_status,
  stringsAsFactors = FALSE
)

# 4. Recode Tumor Status labels
# Converts "WITH TUMOR" to "Cancer" and all other statuses (e.g., TUMOR FREE) to "Healthy"
final_df$Tumor_status <- ifelse(final_df$Tumor_status == "WITH TUMOR", "Cancer", "Healthy")
final_df$Tumor_status <- as.factor(final_df$Tumor_status) # Convert to factor for analysis

# 5. Anonymize Patient IDs
# Generates unique random IDs in the format PID-XXXXX
set.seed(123) # Ensures the same random IDs are generated every time you run the code
n_patients <- nrow(final_df)
final_df$PatientID <- paste0("PID-", sample(10000:99999, n_patients, replace = FALSE))

# 6. Preview the Cleaned Data
print("Preview of the processed dataset:")
head(final_df)

# 7. Export the Result
# We save the file as 'Phenotype.csv' for downstream analysis
write.csv(final_df, "Phenotype.csv", row.names = FALSE)

# Confirmation message
message("Success: 'Phenotype.csv' has been created with ", n_patients, " records.")
