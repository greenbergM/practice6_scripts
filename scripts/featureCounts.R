library('Rsubread')

setwd('/Users/polylover/bioinf/practice_bioinf/practice6/feature_counts/')

ferm01 <- ('/Users/polylover/bioinf/practice_bioinf/practice6/hisat2_output/ferm0_1_out.bam')
ferm02 <- ('/Users/polylover/bioinf/practice_bioinf/practice6/hisat2_output/ferm0_2_out.bam')
ferm301 <- ('/Users/polylover/bioinf/practice_bioinf/practice6/hisat2_output/ferm30_1_out.bam')
ferm302 <- ('/Users/polylover/bioinf/practice_bioinf/practice6/hisat2_output/ferm30_2_out.bam')

all <- c(ferm01, ferm02, ferm301, ferm302)

fc <- featureCounts(files = all, 
              annot.ext = '/Users/polylover/bioinf/practice_bioinf/practice6/feature_counts/annotation.gtf', 
              isGTFAnnotationFile = T)
write.table(
  x=data.frame(fc$annotation[,c("GeneID")],
               fc$counts,
               stringsAsFactors=FALSE),
  file="counts.txt",
  quote=FALSE,
  sep="\t",
  row.names=FALSE)