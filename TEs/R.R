library(ggplot2) #5/10/26
library(ape)
library(phytools)
library(dplyr)
library(kableExtra)

#Importing Table
dnaPipeTE <- read.csv("/home/vmerel/DTN/dnaPipeTE/results.synth.txt", sep="")
head(dnaPipeTE)

###30/12/21###
#vive les mb
dnaPipeTE$Nbp <- dnaPipeTE$Nbp/1e6

#Median of replicates
dnaPipeTE <- dnaPipeTE %>%
  dplyr::group_by(Id,Categ) %>%  dplyr::summarize(Nbp=median(Nbp))

#Selecting TEs and adding a TE (i.e. "All" category)
dnaPipeTE <- dnaPipeTE %>%
  tidyr::pivot_wider(id_cols = Id , #c(Id,Categ) Vm: 23/06
                     names_from =  Categ,
                     values_from = Nbp)

dnaPipeTE <- dnaPipeTE %>%
  dplyr::select(c(DNA, Helitron, LINE, LTR, SINE)) %>%
  dplyr::mutate(
    TEs=DNA+Helitron+LINE+LTR+SINE) 

dnaPipeTE <- dnaPipeTE %>% tidyr::pivot_longer(2:7,
                                               names_to = "Categ",
                                               values_to = "Nbp")

#######

dnaPipeTE_sum <- dnaPipeTE %>% group_by(Categ) %>% summarize(Mean=mean(Nbp),
                                                             Median=median(Nbp),
                                                             Sd=sd(Nbp),
                                                             Min=min(Nbp),
                                                             Max=max(Nbp))
dnaPipeTE_sum[,-1] <-round (dnaPipeTE_sum[,-1],2) #the "-1" excludes column 1
head(dnaPipeTE_sum)
# Re-order the levels
dnaPipeTE_sum$Categ <- factor(
  as.character(dnaPipeTE_sum$Categ), levels=c("DNA",
                                              "Helitron",
                                              "LINE",
                                              #"Low_Complexity",
                                              "LTR",
                                              #"na",
                                              #"others",
                                              #"rRNA",
                                              #"Satellite",
                                              #"short_SR",
                                              "SINE",
                                              "TEs"#, VM 23.06
                                              #"All"
                                              ) )
# Re-order the data.frame
dnaPipeTE_sum <- dnaPipeTE_sum[order(dnaPipeTE_sum$Categ),]
dnaPipeTE_sum$Categ  <- gsub('_', ' ', dnaPipeTE_sum$Categ)

colnames(dnaPipeTE_sum)[1]=" "

knitr::kable(dnaPipeTE_sum,
             "latex",
             caption = "\\textbf{Distributions of abundance for the different TE categories (in Mb).}",
             escape=F) %>%
  kable_styling(position = "center") %>% 
  row_spec(row = 6, background = "lightgray")

#Checking
######################################################"DNA"
mean(dnaPipeTE$Nbp[dnaPipeTE$Categ=="DNA"])
median(dnaPipeTE$Nbp[dnaPipeTE$Categ=="DNA"])
sd(dnaPipeTE$Nbp[dnaPipeTE$Categ=="DNA"])
min(dnaPipeTE$Nbp[dnaPipeTE$Categ=="DNA"])
max(dnaPipeTE$Nbp[dnaPipeTE$Categ=="DNA"])

mean(dnaPipeTE$Nbp[dnaPipeTE$Categ=="Satellite"])
######################################################

dnaPipeTE_id <- dnaPipeTE %>% group_by(Id) %>% summarize(Sum=sum(Nbp))


#Phylogenetic inertia
tree <- read.tree("/home/vmerel/DTN/Tree/root_droso_tree_MF")

df = data.frame(Trait=character(),
                Lambda=numeric(),
                p=numeric())

dnaPipeTE$Categ <- factor(dnaPipeTE$Categ)

for (Level in levels(dnaPipeTE$Categ)){
  Trait <- dnaPipeTE$Nbp[dnaPipeTE$Categ==Level]
  names(Trait) <- dnaPipeTE$Id[dnaPipeTE$Categ==Level]
  Test = phylosig(tree,
                  Trait,
                  method = "lambda",
                  test = TRUE)
  tmp=data.frame(
    Trait=Level,
    Lambda=round(Test$lambda,digits=2),
    p=round(Test$P,2))
  df= rbind(df,tmp)
  
}

# Re-order the levels
df$Trait <- factor(
  as.character(df$Trait), levels=c("DNA",
                                   "Helitron",
                                   "LINE",
                                   #"Low_Complexity",
                                   "LTR",
                                   #"na",
                                   #"others",
                                   #"rRNA",
                                   #"Satellite",
                                   #"short_SR",
                                   "SINE",
                                   "TEs"#, #VM, 23.06
                                   #"All"
                                   )  )
# Re-order the data.frame
df <- df[order(df$Trait),]
df$Trait  <- gsub('_', ' ', df$Trait)
df$p_adj=p.adjust(df$p, method="BH")

colnames(df)[1]=" "
colnames(df)[2]="$\\lambda$"
knitr::kable(df, "latex",
             caption = "\\textbf{Test of phylogenetic inertia on the abundance of the different TE categories (Pagel's $\\lambda$)}",
             row.names=F,
             escape=F)%>%
  kable_styling(position = "center") %>% row_spec(row = 6, background = "lightgray")
