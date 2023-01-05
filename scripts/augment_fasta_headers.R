library(tidyverse)
library(ShortRead)

# change wd to where BLAST outputs live
setwd("./BLAST")

# get file lists
samfile <- "./BLAST/top_BLAST_hits_NCBI_VIRUS.txt"
fasta_file <- "./BLAST/top_BLAST_hits_NCBI_VIRUS.fasta"

# load files
read_in <- function(x){read_delim(x,col_names = FALSE)}
samfile <- read_in(samfile)
fasta <- readFasta(fasta_file)

# get virus name dictionary
virus_names <- read_in("virus_ids.txt")
accessions <- virus_names$X1

virus_names <- readLines("virus_ids.txt") %>%
  str_split(" ",2) %>% 
  map_chr(2)

virus_names <- data.frame(accession=accessions,
                          ncbi_name=virus_names) 

build_dictionary <- 
  function(x){
    x %>% 
      select(X1,X2) %>% 
      rename("X1"="read_id",
             "X2"="accession") %>% 
      left_join(virus_names) %>% 
      mutate(full_name = paste0(read_id," | ",accession," | ",ncbi_name))
  }

new_headers <- build_dictionary(samfile)



# remove any duplicated rows in header dictionary
new_headers <- new_headers %>% 
  map(unique.data.frame)

# add new fasta labels
fasta@id <- 
  new_headers %>% 
  pluck("full_name") %>% 
  BStringSet()

# save file
writeFasta(object = fasta,file = file.path("./final_renamed.fasta"))



