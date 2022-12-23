#install.packages("coRdon")
#install.packages("seqinr")

library("seqinr") # sequences manipulation
library("coRdon")


###################################################################################################################
#### reference of comparison among codon usage bias indices: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5805967/
#### link to coRdon package usage: https://www.bioconductor.org/packages/devel/bioc/manuals/coRdon/man/coRdon.pdf
#### reference for ENC prime (Novembre) : https://academic.oup.com/mbe/article/19/8/1390/997706
###################################################################################################################

#### before running the script, make sure the fasta format is without spaces:
# for i in *cleaned.ali-gb90;do sed "s/ //g" $i >$i\_sspace;done

FAM_files=Sys.glob("*formatted")
length(FAM_files)

#fonction GC ############# seqinr ##################
GC_pct<-function(x){
  GC(getSequence(x))
}
#fonction GC3 
GC3_pct<-function(x){
  GC3(getSequence(x))
}

#fonction CUB analysis ############# coRdon  ##################
CUB_analysis<-function(k){
  align_seqinr<-read.fasta(file=k, as.string = FALSE)
  align_coRdon<-readSet(file=k) 
  print(k)
  
  GC<-as.data.frame(do.call(rbind,lapply(align_seqinr, GC_pct)))
  GC3<-as.data.frame(do.call(rbind,lapply(align_seqinr, GC3_pct)))
  codon_table<-codonTable(align_coRdon)
  enc<- ENCprime(codon_table)
  MCB<-MCB(codon_table)
  scuo<-SCUO(codon_table)
  
  cub<- cbind(names(align_coRdon),enc,MCB,scuo,GC,GC3)
  names(cub)<-c("species","ENCprime","MCB","SCUO", "GC","GC3")

  #write.table(cub, file = paste(k,"_cub2.txt",sep=""), append = FALSE, quote = FALSE, sep = "\t",na = "NA", dec = ".", row.names = TRUE,col.names = TRUE)
  return(cbind(cub,k))
  }

cub_k<-lapply(FAM_files, CUB_analysis) ## run the CUB analysis function on the files (FAM_files[1:22]

################ data analysis #######################
cub_table<-do.call(rbind,cub_k) #dataframe contening CUB stats for all genes 
names(cub_table)<-c("species","ENCprime","MCB","SCUO", "GC","GC3","genes")
write.table(cub_table,file = "cub_table.txt",sep="\t",na = "NA", dec = ".", row.names = FALSE,col.names = TRUE)

cub_table<-read.table(file = "cub_table.txt", dec = ".",h=TRUE)

head(cub_table)
length(unique(cub_table$genes))
length(which(cub_table$ENCprime<0))


################ Choosing genes for concatenates #######################
cub_table<-read.table(file = "cub_table.txt", dec = ".",h=TRUE)

#Solving a NA problem
##For 4 genes, only gaps remain for some sequences after filtering, generating NA
##These sequences (and not genes) are excluded
summary(is.na(cub_table))
cub_table[is.na(cub_table$GC3),]


cub_table <- cub_table[!is.na(cub_table$GC3),]

##sorting
sorted_cub_table <- cub_table[order(cub_table$GC3),]

##Random concatenates
#min(cub_table$GC3, na.rm=T)
#sorted_cub_table[sorted_cub_table$GC3==min(cub_table$GC3, na.rm=T),]
#max()

#Low GC concatenate
head(sorted_cub_table, 20)

#High GC concatenate
tail(sorted_cub_table, 20)

#Median
median(


##


###### filter for outliers (ENC prime estimates <20)
filtered_cub_table<-subset(cub_table,ENCprime>20)
summary(filtered_cub_table)
write.table(filtered_cub_table,file = "filtered_cub_table.txt",sep="\t",na = "NA", dec = ".", row.names = FALSE,col.names = TRUE,append = FALSE)

#scp 

