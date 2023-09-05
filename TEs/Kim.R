#cd /home/vincent/dtn/Traits/Rep
#wget https://raw.githubusercontent.com/flyseq/drosophila_assembly_pipelines/master/figure_data/figure5/rm_summary.csv
#Adding id

#libraries
library(dplyr)
library(ggplot2)
library(ggpubr)

#Importing Tables
rm_summary <- read.csv("~/dtn/Traits/TEs/rm_summary.csv")
head(rm_summary)
dnaPipeTE <- read.csv("~/DTN/dnaPipeTE/results.synth.txt", sep="")
head(dnaPipeTE)

#Formatting
##rm
###Removing species,total_bases, masked_bases and GC ... 
###Kepping only retrotransposons, DNA_transposons, RC_transposons
rm_summary <- rm_summary %>% select(c("retrotransposons",
                                      "DNA_transposons",
                                      "RC_transposons","id"))

###Renaming columns
levels(dnaPipeTE$Categ)
head(rm_summary)
colnames(rm_summary) <- c("Retrotransposons",
                          "DNA",
                          "Helitron",
                          "Id") #???
###Removing non common species
rm_summary <- rm_summary[!is.na(rm_summary$Id),]
###
rm_summary <- rm_summary %>% tidyr::pivot_longer(cols=c(1:3),
                                                 names_to=c("Categ"),
                                                 values_to=c("RM"))

##dnaPipeTE
dnaPipeTE <- dnaPipeTE %>% tidyr::complete(Id, Categ) #Useless ?
dnaPipeTE <- dnaPipeTE %>% group_by(Id, Categ) %>% summarize(dnaPipeTE=median(Nbp))
dnaPipeTE <- dnaPipeTE %>% tidyr::pivot_wider(id_cols=c("Id"), #c("Id","Categ") #VM 22/06
                                              names_from = "Categ",
                                              values_from="dnaPipeTE")
dnaPipeTE <- dnaPipeTE %>% mutate(Retrotransposons=LINE+LTR) %>% select(-c(LINE,LTR))
dnaPipeTE <- dnaPipeTE %>% tidyr::pivot_longer(cols=c(2:11),names_to=c("Categ"),values_to=c("dnaPipeTE"))

##
All <- inner_join(dnaPipeTE,rm_summary)

All$RM <- All$RM/1e6
All$dnaPipeTE <- All$dnaPipeTE/1e6




ggscatter(All, x="RM", y="dnaPipeTE", add="reg.line")+
  facet_wrap(.~Categ, nrow=4, scales = "free")+
  geom_abline(slope=1, linetype="dashed")+
  facet_wrap(.~Categ, nrow=4, scales = "free")+
  stat_cor(aes(label = ifelse(..p.value..<0.01,..rr.label..," ")),
           method = "pearson",
           size=3.5,
           label.x.npc = 0.8,
           label.y.npc = 0.8,
           color="darkred")+
  #ggrepel::geom_text_repel(aes(label=label),
  #              fontface = "italic",
  #              size=3.25)+
  theme_bw()+
  xlab("Kim et al. (2021), RepeatMasker")+
  ylab("This study, dnaPipeTE")


ggsave("~/gnd/TEs/Kim.png",
       units="cm",
       height=20,
       width=16)

#p.adj
cor.test(All$RM[All$Categ=="DNA"], All$dnaPipeTE[All$Categ=="DNA"])
cor.test(All$RM[All$Categ=="Helitron"], All$dnaPipeTE[All$Categ=="Helitron"])
cor.test(All$RM[All$Categ=="Retrotransposons"], All$dnaPipeTE[All$Categ=="Retrotransposons"])


p <- c(8.031e-06, 8.237e-07, 1.538e-06)
p.adjust(p,method="BH")
