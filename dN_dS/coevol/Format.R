library(tidyr)
library(dplyr)

args = commandArgs(trailingOnly=TRUE)

pp <- read.delim("pp.csv", row.names=NULL, comment.char="#")
colnames(pp)[1] <- "proxy"
pp <- pp %>% pivot_longer(names_to="Categ",2:8,values_to="pp")

cc <- read.delim("cc.csv", row.names=NULL, comment.char="#")
colnames(cc)[1] <- "proxy"
cc <- cc %>% pivot_longer(names_to="Categ",2:8,values_to="cc")

df <- left_join(pp,cc, by=c("proxy","Categ"))
df$Aln <- args[1]

write.table(df, "df.csv", quote=F, row.names=F, col.names=F)