
# Script: Data Loading

# 1. Creating standard reproducible project directories
dirs <- c("data/raw", "data/processed", "output/tables", "output/figures", "scripts")
sapply(dirs, dir.create, recursive = TRUE, showWarnings = FALSE)

file.create("data/raw/.gitkeep")
file.create("data/processed/.gitkeep")
file.create("output/tables/.gitkeep")
file.create("output/figures/.gitkeep")

# 2. Required Packages
library(tidyverse)
library(here)
library(readxl)
library(DBI)
library(RPostgres)
library(dplyr)

# =====================================================================
# 3. Load Raw Data Files
# =====================================================================

# Load public PPAC crude price data
ppac_raw <- read_excel(here("data", "raw", "datarawppac_crude_price.xlsx"))

# Load local Compustat quarterly data
compustat_raw <- read_csv(here("data", "raw", "datarawcompustat_india_quarterly.csv")) |>
  select(gvkey, conm, gsector, fyearq, fqtr, datadate, oiadpq, saleq)


# WRDS Extraction Query Template (dbplyr format)


# wrds_extraction_template <- function() {
#   library(dbplyr) 
#   library(RPostgres)
#   wrds <- dbConnect(
#     Postgres(),
#     host = 'wrds-pgdata.wharton.upenn.edu',
#     port = 9737,
#     dbname = 'wrds',
#     sslmode = 'require',
#     user = 'wrds_username'
#   )
#   
#   compustat_query <- tbl(wrds, in_schema("comp", "g_fundq")) |>
#     filter(fyearq >= 2015, fyearq <= 2025) |>
#     select(gvkey, conm, gsector, fyearq, fqtr, datadate, oiadpq, saleq)
#   
#   compustat_raw <- compustat_query |> collect()
#   dbDisconnect(wrds)
#   return(compustat_raw)
# }


# 5. View the first few rows of each dataset in the console
head(compustat_raw)
head(ppac_raw)