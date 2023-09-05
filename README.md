# GND

You will find in this repository scripts and data corresponding to **Publication Title** (**Publication link**). Please find below a description of directories content.

## Assemblies

- quast_busco_results.csv: raw data regarding homemade assemblies statistics (N50, ...);
- Assemblies.Rmd: to produce a table with assembly statistics and a figure with BUSCO statistics.

## Tree

- root_droso_tree_MF: the rooted tree;
- trees_comparison.R:  to compare the produced phylogeny with the one from [Suvorov et al., 2020](https://doi.org/10.1016/j.cub.2021.10.052).;
- Tree.Rmd: some R code to display the tree together with Genome size and TE content.

## TEs

- dnaPipeTE.Rmd: to estimate TE content, from reads processing to actual estimation using dnaPipeTE;
- Kim.R: to compare TE abundance estimates with [Kim et al., 2021](https://doi.org/10.7554/eLife.66405).

## Phylogenetic inertia

## ancov

- Traits.Rmd: to build ancov traits file;
- Run.md: to run ancov;
- Traces.md: to check convergence;
- Analyses.md: just a bit of formatting of ancov output before giving it a look;
- PGLS: a PGLS analysis to compare.

## Alignments

- Preprocessing.md: to produce upper case multifasta (upper case, dealing with "!" encoded frameshifts, ...);
- Concatenating.R & Concatenated.md: to create concatenate according to %GC3;
- get_GC3.R: to get mininmum, maximum and median %GC3 of a concatenate  from list of genes.

## GC_CU (GC and Codon Usage)

- Script.R: to calcultate: GC, GC3, ENC', MCB, and SCUO from alignments.

## dN_dS

### mapNH 

- Install.md;
- Test.md;
- base.bpp and map_dNdS.bpp biopp parameter files;
- Run.md: to calculte dN/dS of concatenates;
- Analyses.md

### coevol

- Install.md;
- Traits.Rmd: to build coevol traits file;
- Run.md: to calculte dN/dS of concatenates;
- Traces.md: to check convergence;
- Analyses.md: a bit of formatting code, then plot code. 

### mapNH - coevol correlation


## Supplementary 

- Supplementary_tables.tex: to produce Suppelementary_tables.pdf;
- Supplementary_tables.csv;
- Supplementary_figure.odt.

## To Do

- Add **Publication Title** and **Publication link**;
- read this: Relaxation of purifying selection suggests low effective population size in eusocial Hymenoptera and solitary pollinating bees;
- root in the correlation ?