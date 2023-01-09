# A script to get GC3 from built concatenate
library("dplyr", quietly=T, warn.conflicts=F)
library("stringr", quietly=T, warn.conflicts=F)

args = commandArgs(trailingOnly=TRUE)

cub_table <- read.table(file = "/beegfs/data/merel/GND/Alignments/cub_table.txt",
                        dec = ".",
                        h=TRUE)


#Solving a NA problem
##For 4 genes, only gaps remain for some sequences after filtering, generating NA
#less 
##These sequences (and not genes) are excluded
#summary(is.na(cub_table))
#cub_table[is.na(cub_table$GC3),]
cub_table <- cub_table[!is.na(cub_table$GC3),]

#median per gene
cub_table <- cub_table %>% group_by(genes) %>% summarize(GC3=median(GC3))
##sorting
sorted_cub_table <- cub_table[order(cub_table$GC3),]


gene_list <- read.delim(args[1], header=F)
gene_list <- strsplit(as.character(gene_list$V1),split=" ")[[1]]
#removing : ".noStop_noFS"
gene_list <- str_remove(gene_list,".noStop_noFS")


df <- sorted_cub_table[grep(
  paste(gene_list,collapse = "|"),sorted_cub_table$genes),]

ToPrint <- paste(min(df$GC3),
                 max(df$GC3),
                 median(df$GC3),
                 collapse=" ")
print(ToPrint, quote=F)

#Rscript get_GC3.R /beegfs/data/merel/GND/Alignments/Aln0.txt