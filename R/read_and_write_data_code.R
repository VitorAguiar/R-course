## readxl
library(readxl)

morfo_excel <- "../data/dados_morfologicos.xlsx"

excel_sheets(morfo_excel)

altura_df <- read_excel(morfo_excel, na = "NA")

## base R

# write the altura data.frame to a file
# csv
write.csv(altura_df, "altura.csv")

# tab delimited
write.table(altura_df, "altura.txt", sep = "\t")

# space delimited
write.table(altura_df, "altura.txt")

# read it back
altura_df <- read.table("altura.txt")

# check the classes of each column with:
sapply(altura_df, class)

# some columns are factors because read.table has an argument stringsAsFactors=TRUE by default.

# illustrate the problem with factors


## readr
library(readr)

# write the altura data.frame to a file
write_csv(altura_df, "altura.csv")

# read it back
altura_df <- read_csv("altura.csv")

# check the classes of each column with:
sapply(altura_df, class)

# readr never converts strings into factors

# write the altura data.frame as a tab-delimited file
write_delim(altura_df, "altura.txt", delim = "\t")


## data.table
library(data.table)

# csv
altura_df <- fread("altura.csv")

# tab
altura_df <- fread("altura.txt") 

# notice that fread() guesses the separator correctly
# check the class of altura_df
# objects of class data.table are manipulated differently
# for now, let's transform it into a data.frame.
# you can do that with the function as.data.frame() or dplyr's as_data_frame()

# Read the files at:

http://ecologia.ib.usp.br/bie5782/doku.php?id=dados:start


