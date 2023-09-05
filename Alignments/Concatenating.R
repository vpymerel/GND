################ Choosing genes for concatenates #######################
library("dplyr")

cub_table<-read.table(file = "cub_table.txt", dec = ".",h=TRUE)

#Solving a NA problem
##For 4 genes, only gaps remain for some sequences after filtering, generating NA
#less 
##These sequences (and not genes) are excluded
summary(is.na(cub_table))
cub_table[is.na(cub_table$GC3),]
cub_table <- cub_table[!is.na(cub_table$GC3),]

#median per gene
cub_table <- cub_table %>% group_by(genes) %>% summarize(GC3=median(GC3))
##sorting
sorted_cub_table <- cub_table[order(cub_table$GC3),]

#Other
Min = sorted_cub_table$GC3[7]
Max = sorted_cub_table$GC3[length(sorted_cub_table$GC3)-7]
Step = (Max - Min)/9 
Seq = seq(Min, Max, by=Step)
length(Seq)

cpt = 0

for (i in Seq){

	Index <- which.min(abs((sorted_cub_table$GC3 - i))) #Index of closest gene
	Aln <- paste(sorted_cub_table[(Index-6):(Index+7),]$genes,".noStop_noFS",sep="")
	Aln <- paste(Aln,collapse=" ")

	fileConn<-file(paste("Aln",as.character(cpt),".bis.txt",sep=""))
	writeLines(Aln, fileConn)
	close(fileConn)

	cpt = cpt +1
}

###########Random###########
for (cpt in seq(10,19)){


	Aln <- paste(sample(sorted_cub_table$genes,14),".noStop_noFS",sep="")
	Aln <- paste(Aln,collapse=" ")

	fileConn<-file(paste("Aln",as.character(cpt),".bis.txt",sep=""))
	writeLines(Aln, fileConn)
	close(fileConn)

}

