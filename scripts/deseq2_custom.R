# Load the library.
library(DESeq2)

# Set up the conditions based on the experimental setup.
cond_1 = rep("cond1", 2)
cond_2 = rep("cond2", 2)

# Read the data from the standard input.
countData = read.table("stdin", header=TRUE, sep="\t", row.names=1)

# Build the dataframe from the conditions
samples = names(countData)
condition = factor(c(cond_1, cond_2))
colData = data.frame(samples=samples, condition=condition)

# Create DESEq2 dataset.
dds = DESeqDataSetFromMatrix(countData=countData, colData=colData, design = ~condition)

# Set the reference to be compared
dds$condition = relevel(dds$condition, "cond1")

# Run deseq
dds = DESeq(dds)

# Format the results.
res = results(dds)
sorted = res[with(res, order(padj, -log2FoldChange)), ]

# Filter the results based on the thresholds.
significant_genes <- subset(sorted, abs(log2FoldChange) > 2 & padj < 0.05)
upregulated_genes <- subset(significant_genes, log2FoldChange > 2)
downregulated_genes <- subset(significant_genes, log2FoldChange < -2)

# Turn it into a dataframe to have proper column names.
significant.df = data.frame("id"=rownames(significant_genes),significant_genes)
upregulated.df = data.frame("id"=rownames(upregulated_genes),upregulated_genes)
downregulated.df = data.frame("id"=rownames(downregulated_genes),downregulated_genes)


# Write the differently expressed genes to a files
write.table(significant.df, file="significant_genes.txt", sep="\t", col.names=NA, quote=FALSE)
write.table(upregulated.df, file="upregulated_genes.txt", sep="\t", col.names=NA, quote=FALSE)
write.table(downregulated.df, file="downregulated_genes.txt", sep="\t", col.names=NA, quote=FALSE)

# Get normalized counts and write this to a file
nc = counts(dds, normalized=TRUE)

# Turn it into a dataframe to have proper column names.
dt = data.frame("id"=rownames(nc), nc)

# Save the normalized data matrix.
write.table(dt, file="norm-matrix-deseq2.txt", sep="\t", row.names=FALSE, col.names=TRUE, quote=FALSE)



