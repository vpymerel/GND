library(ggplot2)
library(ape)
library(phytools)
library(cowplot)

df <- read.csv("~/DTN/INFO.csv", header=FALSE)[,c(1,12,13)]
colnames(df) <- c("Id","GS","Source")
head(df)

df <- df[!is.na(df$GS),]

df[df$GS==min(df$GS),]
df[df$GS==max(df$GS),]

ggplot(df, aes(x=GS))+
  geom_histogram()+
  theme_cowplot()+
  ylab("Number of species")+
  theme(text = element_text(size=11),
        axis.text = element_text(size=11))
ggsave("/home/vincent/DTN/Traits/GS/GS.png",
       units="cm",
       height=10,
       width=16)

shapiro.test(df$GS)  
summary(df$GS,na.rm=T)

#tree <- read.tree("/home/vmerel/DTN/Tree/root_droso_tree_MF")
#tree <- read.tree("/home/vmerel/gnd/Tree/ultrametric_tree")
tree <- read.tree("/home/vmerel/gnd/Tree/droso_ultrametric_tree")
tree <-  drop.tip(tree, c("Dnigromelanica",  #OK
                          "helvetica", #OK
                          "Dlowei", #OK
                          "madeirensis", #OK
                          "Drhopaloa"))#OK
df$GS <- log(df$GS)
GS_vec <- df$GS
names(GS_vec) <- df$Id
phylosig(tree, GS_vec, method = "lambda", test = TRUE) 

#
tree.bm <- corBrownian(1, phy=tree, form=~Id)
 plop <- gls(GS~1,
    correlation=tree.bm,
    data=df)

tree.ou <- corMartins(value=1000, phy=tree, form=~Id)
plop <- gls(GS~1,
    correlation=tree.ou,
    data=df)
#
bm <- fitContinuous(phy=tree, dat=GS_vec, model = 
                      "BM")
ou <- fitContinuous(phy=tree, dat=GS_vec, model = 
                      "OU")

bm$opt$aicc
ou$opt$aicc
exp(
  (min(bm$opt$aicc, ou$opt$aicc)-max(bm$opt$aicc, ou$opt$aicc))/2
)

pchisq(3.806766,1,lower.tail=F)
pchisq(2*(ou$opt$lnL - bm$opt$lnL),1,lower.tail=F)
