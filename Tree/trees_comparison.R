#install.packages("ape")
library("ape")
# https://rdrr.io/cran/ape/man/drop.tip.html ### to remove or extract some tips from a phylogeny

install.packages("TreeDist")
library("TreeDist")
# test Robinson Foulds

#install.packages("dendextend")
library("dendextend")
# visualization differences and similarities 

#############################################################

Theo_droso_tree_supermat<- read.tree(file ="/Users/annabelle/Documents/recherche/alignements_flies/root_droso_MF_for_comparison")
tip_Theo_to_remove<-c("D_guanche","D_subobscura","D_athabasca","D_mercatorum_39*")
Theo_droso_tree_supermat<-drop.tip(Theo_droso_tree_supermat,tip_Theo_to_remove, trim.internal = TRUE, subtree = FALSE,root.edge = 0, rooted = TRUE, collapse.singles = TRUE,interactive = FALSE)
Theo_droso_tree_supermat$tip.label
plot(Theo_droso_tree_supermat)

Suvorov_tree<- read.tree(file ="/Users/annabelle/Downloads/drosophila_introgression_data/tree/iqtree.tre")
plot(Suvorov_tree)
Suvorov_tree$tip.label
grep("mercatorum",Suvorov_tree$tip.label)

Van_der_Linde_tree<- read.tree(file ="/Users/annabelle/Documents/recherche/VincentM/Van_der_linde_tree")
Van_der_Linde_tree$tip.label

######## creation of subtrees to compare

## remove * from the labels of my data
AH_data<-grep("*",Theo_droso_tree_supermat$tip.label,fixed=TRUE) #grep('*', noms,fixed = TRUE)
#noms[grep('*', noms, fixed = TRUE)(edited)]
Theo_droso_tree_supermat$tip.label[AH_data]<-substr(Theo_droso_tree_supermat$tip.label[AH_data],1,(nchar(Theo_droso_tree_supermat$tip.label[AH_data]))-1)
Theo_droso_tree_supermat$tip.label[5]<-"D_mercatorum"

tip_Theo_to_keep<-c("S_lebanonensis","D_arizonae","D_mojavensis","D_navojoa","D_hydei","D_americana","D_novamexicana","D_virilis","D_montana","D_robusta","D_grimshawi",                       
"D_albomicans","D_nasuta","Z_africanus","Z_gabonicus","Z_indianus","D_busckii","D_affinis","D_athabasca","D_azteca","D_lowei","D_miranda",                      
"D_persimilis","D_pseudoobscura","D_bifasciata","D_obscura","D_guanche","D_subobscura","D_ananassae","D_pallidosa","D_bipectinata","D_parabipectinata",                
"D_malerkotliana","D_pseudoananassae","D_ercepeae","D_serrata","D_kikkawai","D_biarmipes","D_suzukii","D_takahashii",
"D_erecta","D_teissieri","D_yakuba","D_mauritiana","D_simulans","D_sechellia","D_melanogaster","D_eugracilis","D_rhopaloa","D_elegans",                        
"D_ficusphila","D_equinoxialis","D_paulistorum","D_willistoni","D_prosaltans")
subtree_Theo<-keep.tip(Theo_droso_tree_supermat, tip_Theo_to_keep)

tip_Suvorov_to_keep<-c("S_lebanonensis","D_arizonae","D_mojavensis","D_navojoa","D_hydei","D_americana","D_novamexicana","D_virilis","D_montana","D_robusta","D_grimshawi",                       
"D_albomicans","D_nasuta","Z_africanus","Z_gabonicus","Z_indianus_16GNV01","D_busckii","D_affinis","D_athabasca","D_azteca","D_lowei","D_miranda",                      
"D_persimilis","D_pseudoobscura","D_bifasciata","D_obscura","D_guanche","D_subobscura","D_ananassae","D_parapallidosa","D_bipectinata","D_parabipectinata",                
"D_malerkotliana_malerkotliana","D_pseudoananassae_pseudoananassae","D_ercepeae","D_serrata","D_kikkawai","D_biarmipes","D_suzukii","D_takahashii",
"D_erecta","D_teissieri_273_3","D_yakuba","D_mauritiana","D_simulans","D_sechellia","D_melanogaster","D_eugracilis","D_rhopaloa","D_elegans",                        
"D_ficusphila","D_equinoxialis","D_paulistorum","D_willistoni","D_prosaltans")
length(tip_Suvorov_to_keep)

subtree_Suvorov<-keep.tip(Suvorov_tree, tip_Suvorov_to_keep)
#change names to be conform with my dataset for comparison !!!! note that I replace D. parapallidosa by D. pallidosa (close species??)
subtree_Suvorov$tip.label[16]<-substr(subtree_Suvorov$tip.label[16],1,(nchar(subtree_Suvorov$tip.label[16]))-8) #"Z_indianus_16GNV01"
subtree_Suvorov$tip.label[42]<-substr(subtree_Suvorov$tip.label[42],1,(nchar(subtree_Suvorov$tip.label[42]))-6) #D_teissieri_273_3
subtree_Suvorov$tip.label[34]<-substr(subtree_Suvorov$tip.label[34],1,(nchar(subtree_Suvorov$tip.label[34]))-16) #D_pseudoananassae_pseudoananassae
subtree_Suvorov$tip.label[33]<-substr(subtree_Suvorov$tip.label[33],1,(nchar(subtree_Suvorov$tip.label[33]))-14) #D_malerkotliana_malerkotliana
subtree_Suvorov$tip.label[30]<-"D_pallidosa" #D_parapallidosa
subtree_Suvorov$tip.label
plot(subtree_Suvorov)

tip_Linde_to_keep<-intersect(Theo_droso_tree_supermat$tip.label,Van_der_Linde_tree$tip.label)
  #c("D_nasuta","D_albomicans","Z_indianus","D_mojavensis","D_mercatorum","D_hydei","D_virilis",
#"D_americana","D_montana","D_melanica","D_nigromelanica","D_micromelanica","D_lacertosa","D_robusta","D_grimshawi",
#"D_busckii","D_erecta", "D_teissieri","D_yakuba","D_mauritiana","D_simulans","D_sechellia","D_melanogaster",
#"D_lutescens","D_takahashii","D_mimetica","D_biarmipes","D_eugracilis","D_ficusphila","D_lucipennis","D_elegans",
#"D_kikkawai","D_serrata", "D_ananassae","D_pallidosa","D_phaeopleura","D_malerkotliana","D_bipectinata","D_ercepeae",
#"D_varians","D_persimilis","D_pseudoobscura","D_affinis","D_azteca","D_obscura","D_bifasciata","D_guanche","D_nebulosa",
#"D_willistoni","D_paulistorum","D_equinoxialis","S_lebanonensis")  
length(tip_Linde_to_keep)
subtree_Theo_to_Linde<-keep.tip(Theo_droso_tree_supermat, tip_Linde_to_keep)
subtree_Linde_to_Theo<-keep.tip(Van_der_Linde_tree, tip_Linde_to_keep)

####### comparison of the trees

comparePhylo(subtree_Theo, subtree_Suvorov, plot = TRUE, force.rooted = TRUE,use.edge.length = TRUE)
RobinsonFoulds(subtree_Theo,subtree_Suvorov)
VisualizeMatching(RobinsonFouldsMatching,subtree_Theo,subtree_Suvorov)

ultra_subtree_Suvorov<-force.ultrametric(subtree_Suvorov)
ultra_subtree_Theo<-force.ultrametric(subtree_Theo)
is.ultrametric(ultra_subtree_Suvorov)

dend_S <- as.dendrogram(ultra_subtree_Suvorov)
dend_T <- as.dendrogram(ultra_subtree_Theo)
dl <- dendlist(dend_T,dend_S)
tanglegram(dl, sort = TRUE, common_subtrees_color_lines = TRUE, highlight_distinct_edges  = TRUE, highlight_branches_lwd = FALSE,margin_inner = 9,main_left = "our tree",main_right="Suvorov's tree")
 

## test without D_ercepeae
subtree_Theo2<-drop.tip(subtree_Theo,"D_ercepeae", trim.internal = FALSE, subtree = FALSE,root.edge = 0, rooted = TRUE, collapse.singles = TRUE,interactive = FALSE)
subtree_Suvorov2<-drop.tip(subtree_Suvorov,"D_ercepeae", trim.internal = FALSE, subtree = FALSE,root.edge = 0, rooted = TRUE, collapse.singles = TRUE,interactive = FALSE)
comparePhylo(subtree_Theo2, subtree_Suvorov2, plot = TRUE, force.rooted = TRUE,use.edge.length = TRUE)
RobinsonFoulds(subtree_Theo2,subtree_Suvorov2)
ultra_subtree_Suvorov2<-force.ultrametric(subtree_Suvorov2)
ultra_subtree_Theo2<-force.ultrametric(subtree_Theo2)
is.ultrametric(ultra_subtree_Suvorov2)

dend_S2 <- as.dendrogram(ultra_subtree_Suvorov2)
dend_T2 <- as.dendrogram(ultra_subtree_Theo2)
dl2 <- dendlist(dend_T2,dend_S2)
tanglegram(dl2, sort = TRUE, common_subtrees_color_lines = TRUE, highlight_distinct_edges  = TRUE, highlight_branches_lwd = FALSE,margin_inner = 9,main_left = "our tree",main_right="Suvorov's tree")

########## comparison Theo's tree with Van der Linde
RobinsonFoulds(subtree_Theo_to_Linde, subtree_Linde_to_Theo) #16
comparePhylo(subtree_Theo_to_Linde, subtree_Linde_to_Theo, plot = TRUE, force.rooted = TRUE,use.edge.length = TRUE)
ultra_subtree_Theo_to_Linde<-force.ultrametric(subtree_Theo_to_Linde)
ultra_subtree_Linde_to_Theo<-force.ultrametric(subtree_Linde_to_Theo)
dend_VDL<-as.dendrogram(ultra_subtree_Linde_to_Theo)
dend_T_vdl<-as.dendrogram(ultra_subtree_Theo_to_Linde)
dl3<-dendlist(dend_T_vdl,dend_VDL)
tanglegram(dl3, sort = TRUE, common_subtrees_color_lines = TRUE, highlight_distinct_edges  = TRUE, highlight_branches_lwd = FALSE,margin_inner = 9,main_left = "our tree",main_right="Van der Linde tree")

length(intersect(Theo_droso_tree_supermat$tip.label,Van_der_Linde_tree$tip.label))

