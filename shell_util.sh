# AncestryMap snp file to tsv
awk -vOFS=$'\t' '{print $2,$4,$5","$6}' file.snp | bgzip -c > file.tsv.gz
tabix -s1 -b2 -e2 file.tsv.gz


