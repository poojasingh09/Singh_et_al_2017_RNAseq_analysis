##/export/bio/R/R-3.2.1/bin/R

#source("http://bioconductor.org/biocLite.R")
#biocLite("DEXSeq")
library("DESeq2", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library/")
#biocLite("BiocParallel")
library("BiocParallel", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library/")

sessionInfo()
packageVersion("DESeq2")

BPPARAM = MulticoreParam(workers=5)

setwd("./")

# reads files
#countFiles = list.files(".", pattern="counts$", full.names=TRUE)
#countFiles

directory <- "."
#sampleFiles <- grep(".counts",list.files(directory),value=TRUE)


# import sample table
#sampleTable <- read.table("paper1_speciesinfo2.txt", header=T)

#start analysis
#dds = DESeqDataSetFromHTSeqCount(countFiles, sampleData=sampleTable, design= ~ condition)

#dds <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, directory = directory, design= ~ condition)
#dds <- dds[ rowSums(counts(dds)) > 5, ]

#run analysis

#dds <- DESeq(dds) 

#res <- results(dds)
#write.table(res, file = "DESeq_allsamples_fullresults.txt", sep = "\t", quote=F)

#save data
#save(dds, file="./DESeq2_all.RData")

#########
load("./DESeq2_all.RData")
#########


#plot dispersion plot
#png("dispersion_plot.png")
#plotDispEsts(dds)
#dev.off()

#matrix of normalized counts

#rld <- rlog(dds) 
#vsd <- varianceStabilizingTransformation(dds)
#matrix <- (assay(rld))
#write.table(matrix, file = "DESeq_NormalizedCounts.txt", sep = "\t", quote=F)

#########################################################################

#plot SD of transformed data using shifted logarithm transformation

#library("vsn") 
#notAllZero <- (rowSums(counts(dds))>5)


#png("DESeq_meanSDplot_normalized_shiftedlog.png") 
#meanGpPlot(log2(counts(dds,normalized=TRUE)[notAllZero,] + 1))
#dev.off()

#png("DESeq_meanSDplot_normalized_regularizedlog.png")
#meanGpPlot(assay(rld[notAllZero,]))
#dev.off()

#png("DESeq_meanSDplot_normalized_varianceStabilizingTransformation.png")
#meanGpPlot(assay(vsd[notAllZero,]))
#dev.off()

##########################################################################

#heatmap of normalized counts

#library("pheatmap") 
#select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:20]
#nt <- normTransform(dds)
#log2.norm.counts <- assay(nt)[select,] 
#df <- as.data.frame(colData(dds)[,("condition")]) 

#png("heatmap_20_highest_expr_genes_log2normalized.png")
#pheatmap(log2.norm.counts, cluster_rows=FALSE, show_rownames=FALSE, cluster_cols=FALSE, annotation_col=df)
#dev.off()

#png("heatmap_20_highest_expr_genes_rld.png")
#pheatmap(assay(rld)[select,], cluster_rows=FALSE, show_rownames=FALSE, cluster_cols=FALSE, annotation_col=df)
#dev.off()

#png("heatmap_20_highest_expr_genes_vsd.png")
#pheatmap(assay(vsd)[select,], cluster_rows=FALSE, show_rownames=FALSE, cluster_cols=FALSE, annotation_col=df)
#dev.off()

#########################################################################

#make contrasts

res_ChGp <- results(dds, contrast=c("condition", "Ch", "Gp"), alpha=0.05)
write.table(res_ChGp, file = "ChGp_DESeq_fullresults_0.05.txt", sep = "\t", quote=F)

########################################################################

#summarise results

res_ChGp1 <- results(dds, contrast=c("condition", "Ch", "Gp"), alpha=0.01)
write.table(res_ChGp1, file = "ChGp_DESeq_fullresults_0.01.txt", sep = "\t", quote=F)

#summary of results

#sum <- summary(res_ChGp)
#write.table(sum, file = "ChGp_DESeq_summary_0.05.txt", sep = "\t", quote=F)

genesDE <- sum(res_ChGp$padj < 0.05, na.rm=TRUE)
write.table(genesDE, file = "ChGp_DESeq_genesDE_0.05.txt", sep = "\t", quote=F)

#sum1 <- summary(res_ChGp1)
#write.table(sum1, file = "ChGp_DESeq_summary_0.01.txt", sep = "\t", quote=F)

genesDE1 <- sum(res_ChGp1$padj < 0.01, na.rm=TRUE)
write.table(genesDE1, file = "ChGp_DESeq_genesDE_0.01.txt", sep = "\t", quote=F)

##########################################################################

#plot MA plot

png("DEseq_MAplot_ChGp_0.05.png")
plotMA(res_ChGp, main="DESeq2_0.05", ylim=c(-2,2))
dev.off()

png("DEseq_MAplot_ChGp_0.01.png")
plotMA(res_ChGp1, main="DESeq2_0.01", ylim=c(-2,2))
dev.off()

##########################################################################

#heatmaps of sample to samples distances: clustering

#png("DEseq_clustering_heatmap_ofsamples_rld.png")
#sampleDists <- dist(t(assay(rld)))
#library("RColorBrewer") 
#sampleDistMatrix <- as.matrix(sampleDists) 
#rownames(sampleDistMatrix) <- paste(rld$condition, rld$type, sep="-") 
#colnames(sampleDistMatrix) <- NULL 
#colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255) 
#pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDists, col=colors)
#dev.off()


#png("DEseq_clustering_heatmap_ofsamples_vsd.png")
#sampleDists <- dist(t(assay(vsd)))
#library("RColorBrewer") 
#sampleDistMatrix <- as.matrix(sampleDists) 
#rownames(sampleDistMatrix) <- paste(rld$condition, rld$type, sep="-") 
#colnames(sampleDistMatrix) <- NULL 
#colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255) 
#pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDists, col=colors)
#dev.off()

#######################################################################


#principal component plot of samples

#png("PCA_samples_rld.png")
#plotPCA(rld, intgroup=("condition"))
#dev.off()

#png("PCA_samples_vsd.png")
#plotPCA(vsd, intgroup=("condition"))
#dev.off()

#netapp/home/tmp/RtmpAeSB6R/downloaded_packages

