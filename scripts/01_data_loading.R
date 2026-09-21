
# Script 01: Data Loading & WRDS Documentation


library(here)
library(readxl)
library(readr)
library(dplyr)

# 1.  Load Local Raw Data Files

# Load public PPAC crude price data
ppac_path <- here("data/raw", "datarawppac_crude_price.xlsx")
ppac_raw <- read_excel(ppac_path)

# Load restricted Compustat India quarterly panel (local file)
compustat_path <- here("data/raw", "datarawcompustat_india_quarterly.csv")
compustat_raw <- read_csv(compustat_path)


# 2. ACADEMIC DOCUMENTATION: Live WRDS Extraction Template 
# (Commented out; provided for transparency & auditing purposes)

# library(DBI)
# library(RPostgres)
# library(rstudioapi)
# 
# # Connect securely to WRDS (prompts for password securely in the console)
# wrds <- DBI::dbConnect(
#   RPostgres::Postgres(),
#   host = "wrds-pgdata.wharton.upenn.edu",
#   port = 9737,
#   dbname = "wrds",
#   sslmode = "require",
#   user = "YOUR_WRDS_USERNAME",
#   password = rstudioapi::askForPassword("Enter your WRDS password")
# )
# 
# # Test whether the connection can execute a query
# DBI::dbGetQuery(wrds, "SELECT 1 AS connection_test")
# 
# # Build the SQL query for Compustat Global Quarterly 
# # Filters: 2015-2025, India (fic = 'IND'), Industrial (indfmt = 'INDL'), Consolidated (consol = 'C')
# compustat_query <- "
# SELECT a.gvkey, a.conm, b.gsector, a.fyearq, a.fqtr, a.datadate, a.oiadpq, a.saleq
# FROM comp.g_fundq AS a
# LEFT JOIN comp.g_company AS b ON a.gvkey = b.gvkey
# WHERE a.datadate BETWEEN '2015-01-01' AND '2025-12-31'
# AND a.indfmt = 'INDL'
# AND a.consol = 'C'
# AND a.fic = 'IND'
# AND b.costat = 'A'
"
# 
# # Pull data into R (live extraction alternative)
# # compustat_raw <- DBI::dbGetQuery(wrds, compustat_query)
# 
# # Disconnect cleanly
# # DBI::dbDisconnect(wrds)