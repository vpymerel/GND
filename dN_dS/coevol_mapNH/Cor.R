library(ape)
library(tidytree)

args = commandArgs(trailingOnly=TRUE)
#args[1] = "Aln6"
#cd /beegfs/data/merel/GND/dN_dS

#################mapNH##############
mapNH_dS <- read.tree(
  paste(
    "mapNH/Runs/",
    args[1],
    "/",
    args[1],
    ".countsdS.dnd", sep=""))
mapNH_dS_tbl <- as_tibble(mapNH_dS)


mapNH_dN <- read.tree(
  paste(
    "mapNH/Runs/",
    args[1],
    "/",
    args[1],
    ".countsdN.dnd", sep=""))
mapNH_dN_tbl <- as_tibble(mapNH_dN)

omega_mapNH = mapNH_dN_tbl$branch.length/mapNH_dS_tbl$branch.length

mapNH_df <- data.frame(
  node = mapNH_dN_tbl$node,
  omega_mapNH = omega_mapNH
)
##################################

#################coevol##############

coevol_tree <- read.tree(
  paste(
    "coevol/Runs/",
    args[1],
    "/",
    args[1],".1.postmeanomega.tre", sep=""))

coevol_tbl <- as_tibble(coevol_tree) %>%
  tidyr::separate(col=label, sep="_", into=c("label","mean","min","max"), fill="left")

omega_coevol <- as.numeric(coevol_tbl$mean)

coevol_df <- data.frame(
  node = coevol_tbl$node,
  omega_coevol = omega_coevol
)
##################################

#binding
df <- full_join(mapNH_df,coevol_df,by="node")

#################branch.length##############
tree <- read.tree("/beegfs/data/merel/GND/dN_dS/mapNH/Test/Tree.nwk")
tree_tbl <- as_tibble(mapNH_dS) %>%
  select(branch.length, node)
#binding
df <- dplyr::full_join(df,tree_tbl,by="node")
##################################

df$Aln=args[1]

write.table(df, 
            paste(
              "coevol_mapNH/",
              args[1],
              ".csv", sep=""),
              quote=F,
              row.names=F, 
              col.names=F)



#coevol_tbl[coevol_tbl$mean==max(coevol_tbl$mean),]
#plot(omega_mapNH, omega_coevol)
#plot(mapNH_df$omega_mapNH[mapNH_df$node!=83], coevol_df$omega_coevol[coevol_df$node!=83])

#Lm <- lm(mapNH_df$omega_mapNH[mapNH_df$node!=83] ~ coevol_df$omega_coevol[coevol_df$node!=83])
#summary(Lm)