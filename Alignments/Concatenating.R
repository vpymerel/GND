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

###Min, , and median###

#Min GC concatenate
head(sorted_cub_table, 50)
Aln0 <- paste(head(sorted_cub_table, 50)$genes,".noStop_noFS",sep="")
Aln0 <-paste(Aln0,collapse=" ") ##As a string

#Max GC concatenate
Aln2 <- paste(tail(sorted_cub_table, 50)$genes,".noStop_noFS",sep="")
Aln2 <- paste(Aln2,collapse=" ")

#Median GC concatenate
Median <- median(sort(sorted_cub_table$GC3))
Index <- which.min(abs((sorted_cub_table$GC3 - Median))) #Index of closest gene
Aln1 <- paste(sorted_cub_table[(Index-24):(Index+25),]$genes,".noStop_noFS",sep="")
Aln1 <- paste(Aln1,collapse=" ")

cpt = 0

for (i in c(Aln0,Aln1,Aln2)){
	fileConn<-file(paste("Aln",as.character(cpt),".txt",sep=""))
	writeLines(i, fileConn)
	close(fileConn)
	
	cpt=cpt+1
}


############################

###########Others###########
#Other
Min = sorted_cub_table$GC3[25]
Max = sorted_cub_table$GC3[length(sorted_cub_table$GC3)-25]
Step = (Max - Min)/18 
Seq = seq(Min+Step, Max-Step, by=Step)
length(Seq)

cpt = 3

for (i in Seq){

	Index <- which.min(abs((sorted_cub_table$GC3 - i))) #Index of closest gene
	Aln <- paste(sorted_cub_table[(Index-24):(Index+25),]$genes,".noStop_noFS",sep="")
	Aln <- paste(Aln,collapse=" ")

	fileConn<-file(paste("Aln",as.character(cpt),".txt",sep=""))
	writeLines(Aln, fileConn)
	close(fileConn)

	cpt = cpt +1
}

###########Random###########
for (cpt in seq(20,29)){


	Aln <- paste(sample(sorted_cub_table$genes,50),".noStop_noFS",sep="")
	Aln <- paste(Aln,collapse=" ")

	fileConn<-file(paste("Aln",as.character(cpt),".txt",sep=""))
	writeLines(Aln, fileConn)
	close(fileConn)

}

