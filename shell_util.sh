# AncestryMap snp file to tsv
awk -vOFS=$'\t' '{print $2,$4,$5","$6}' file.snp | bgzip -c > file.tsv.gz
tabix -s1 -b2 -e2 file.tsv.gz

# AncestryMap dedup SNP
# merge snp file with geno file
paste $1.snp $1.geno >> tmp.snp_geno
# prepend line-num, find dup, cut line-num out, print even line
nl $1 | uniq -f1 -D | cut -f1 | sed -n 'n;p'

# print if a column value equals
awk '$1 == "findtext" {print $3}'
