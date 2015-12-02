## readxl
library(readxl)

morfo_excel <- "../data/dados_morfologicos.xlsx"

excel_sheets(morfo_excel)

janeiro <- read_excel(morfo_excel, 1, na = "NA")
head(janeiro)

## base R

# write the janeiro data.frame to a file
# csv
write.csv(janeiro, "../data/janeiro.csv")

# tab delimited
write.table(janeiro, "../data/janeiro.txt", sep = "\t")

# space delimited
write.table(janeiro, "../data/janeiro.txt")

# read it back
janeiro <- read.table("../data/janeiro.txt")

# check the classes of each column with:
sapply(janeiro, class)

# some columns are factors because read.table has an argument stringsAsFactors=TRUE by default.

# illustrate the problem with factors

## readr
library(readr)

# write the janeiro data.frame to a file
write_csv(janeiro, "../data/janeiro.csv")

# read it back
janeiro <- read_csv("../data/janeiro.csv")

# check the classes of each column with:
sapply(janeiro, class)

# readr never converts strings into factors

# write the janeiro data.frame as a tab-delimited file
write_delim(janeiro, "../data/janeiro.txt", delim = "\t")

# read directly from the web
# Gencode mouse gene annotation file
# this takes 1.7Gb of RAM on my Mac laptop
ftp_gtf <- "ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_mouse/release_M7/gencode.vM7.annotation.gtf.gz"
mouse_annot <- read_delim(ftp_gtf, delim = "\t", comment = "##", col_names = FALSE) 

## data.table
library(data.table)

# csv
janeiro <- fread("../data/janeiro.csv")

# tab
janeiro <- fread("../data/janeiro.txt") 

# notice that fread() guesses the separator correctly
# check the class of janeiro
# objects of class data.table are manipulated differently
# for now, let's transform it into a data.frame.
# you can do that with the function as.data.frame() or dplyr's as_data_frame()

# vcf file
library(magrittr)

header <- 
  scan("~/mouse_500k_snps.vcf", what = "character", sep = "\n", nlines = 100) %>%
  .[grep("^##", .)]

mouse_vcf <- fread("~/mouse_500k_snps.vcf", header = TRUE, skip = length(header))


# try to read the files at:
http://ecologia.ib.usp.br/bie5782/doku.php?id=dados:start


## the seqinr package

library(seqinr)

ftp_fasta <- "ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_mouse/release_M7/gencode.vM7.transcripts.fa.gz"
download.file(ftp_fasta, destfile = "../data/mouse_transcripts.fasta.gz")

mouse_seqs <- read.fasta("../data/mouse_transcripts.fasta.gz", 
                         forceDNAtolower = FALSE, as.string = TRUE, 
                         set.attributes = FALSE)
```