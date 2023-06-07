
#cd /beegfs/data/merel/GND/dN_dS/mapNH/Runs/Aln24

library(ape)
library(tidytree)
library(caper)

args = commandArgs(trailingOnly=TRUE)

#traits 
Traits <- read.delim("/beegfs/data/merel/GND/ancov/Traits.tsv")
Traits <- Traits %>% dplyr::select(-c("Dev"))

dN <- read.tree(
  paste(args[1],
        ".countsdN.dnd",
        sep=""))
dN_tbl <- as_tibble(dN)
colnames(dN_tbl)[3] <- "dN"

head(dN_tbl)

dS <- read.tree(
  paste(args[1],
        ".countsdS.dnd",
        sep=""))
dS_tbl <- as_tibble(dS)  
colnames(dS_tbl)[3] <- "dS"

head(dS_tbl)

dNdS <- left_join(dN_tbl, dS_tbl, by=c("parent","node","label")) %>% mutate(omega=dN/dS)

#keeping only last branches
dNdS <- dNdS[!is.na(dNdS$label),]

head(dNdS)

#binding
colnames(Traits)[1] <- "label"
Traits$label <- as.character(Traits$label)
df <- left_join(dNdS, Traits,by="label")
head(df)


#Importing tree
tree <- read.tree("/beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk")
tree$node.label <- NULL #VM

#An empty data.frame to fill
dfE <- data.frame(
  proxy = character(),
  categ = character(),
  p = numeric(),
  cc = numeric())

Categs = c("GS","DNA","Helitron","LINE","LTR","SINE","TEs")

for (Categ in Categs){
  
  Proxy <- df$omega
  Y <- df[,colnames(df) %in% Categ]
  
  data <- cbind(df$label, Proxy, log(Y))
  colnames(data) <- c("ID","Yaxis","Xaxis")
  data <- as.data.frame(data)
  
  data$Yaxis <- as.numeric(data$Yaxis)
  data$Xaxis <- as.numeric(data$Xaxis)
  
  pgls_data = comparative.data(
    tree,
    data, 
    ID, 
    vcv=TRUE)
  
  PGLS <- pgls(Yaxis ~ Xaxis, pgls_data) #lambda='ML', delta='ML'
  summary_PGLS <- summary(PGLS)
  
  PGLs_P <- summary_PGLS$coefficients[2,4]
  PGLs_COR <- summary_PGLS$coefficients[2,1]
  tmp <- data.frame(proxy = "omega",
                    categ = Categ,
                    p = PGLs_P,
                    cc = PGLs_COR)
  
  dfE <- rbind(dfE,tmp)
}

#Adding aln
dfE$Aln = args[1]

#adjusting pvalues for tables
dfE$p_adj <- p.adjust(dfE$p, method="BH")


write.table(dfE, "df.csv", quote=F, row.names=F, col.names=F)

