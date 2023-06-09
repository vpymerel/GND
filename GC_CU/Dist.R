#scp merel@pbil-gates.univ-lyon1.fr:/beegfs/data/merel/GND/Alignments/cub_table.txt /home/vmerel/Desktop/Tmp/
################ Choosing genes for concatenates #######################
library("dplyr")
library("ggplot2")
library("randomcoloR")
library("stringr")

cub_table<-read.table(file = "/home/vmerel/Desktop/Tmp/cub_table.txt", dec = ".",h=TRUE)

#Solving a NA problem
##For 4 genes, only gaps remain for some sequences after filtering, generating NA
#less 
##These sequences (and not genes) are excluded
summary(is.na(cub_table))
cub_table[is.na(cub_table$GC3),]
cub_table <- cub_table[!is.na(cub_table$GC3),]

#median per gene
cub_table <- cub_table %>% group_by(genes) %>% summarize(GC3=median(GC3))

summary(cub_table$GC3<0.55)
hist(cub_table$GC3)

plot <- ggplot(cub_table,
       aes(x = GC3))+
  geom_histogram()+
  geom_vline(xintercept = mean(cub_table$GC3),
             color="black")+
  geom_vline(xintercept = median(cub_table$GC3),
             color="red")+
  xlab("%GC3") +
  ylab("Count")+
  theme_bw()

ggsave(filename = "/home/vmerel/gnd/GC_CU/Dist.png",
       width=10,
       height=10,
       units="cm")

#Verifying overlap
##sorting
sorted_cub_table <- cub_table[order(cub_table$GC3),]


##Other
Min = sorted_cub_table$GC3[7]
Max = sorted_cub_table$GC3[length(sorted_cub_table$GC3)-7]
Step = (Max - Min)/9
Seq = seq(Min, Max, by=Step) #Min and max are included
length(Seq)


cpt = 0

for (i in Seq){
  
  Index <- which.min(abs((sorted_cub_table$GC3 - i))) #Index of closest gene

  Y = 200 - cpt * 20
  
  COLOR=randomColor()
  MEDIAN=i
  MIN=sorted_cub_table$GC3[Index-6]
  MAX=sorted_cub_table$GC3[Index+7]
  
  plot <- plot + geom_vline(xintercept = MEDIAN,
                            color = COLOR,
                            linetype="twodash")
  #plot <- plot + geom_rect(xmin = MIN, xmax = MAX, ymin = 0, ymax = 250,
  #                        color=COLOR,
  #                       alpha=0.009)
  plot <- plot + geom_segment(x=MIN,
                              xend=MAX,
                              y=Y,
                              yend=Y,
                              color=COLOR)
  
  cpt = cpt + 1 
}
  
plot
