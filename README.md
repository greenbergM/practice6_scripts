# practice6_scripts
Some scripts for RNA-seq practice

## Contents

- `hisat_script.sh`: Bash script for automated indexing and aligning multiple reads.

```bash
bash hisat_script.sh
```

- `featureCounts.R`: Script uses Rsubread package to create dataframe with gene counts

```bash
R -f featureCounts.R
```

- `deseq2_custom.R`: Script based on the teacher's deseq2 script, allowing for separately saving all significantly expressed genes, alongside upregulated and downregulated significantly expressed genes. It also creates a normalized count table.

```bash
cat <file_with_counts> | R -f deseq2_custom.R
```
