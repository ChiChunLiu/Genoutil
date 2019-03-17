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


# input ftp 
# output ascp

awk 'FS="\t", OFS="\t" { gsub("ftp.sra.ebi.ac.uk", "era-fasp@fasp.sra.ebi.ac.uk:"); print }' $1 | \
    cut -f3 | \
    awk -F ";" 'OFS="\n" {print $1, $2}' | \
    awk NF | \
    awk 'NR > 1, OFS="\n" {print "ascp -QT -l 300m -P33001 -i $HOME/Applications/Aspera\\ Connect.app/Contents/Resources/asperaweb_id_dsa.openssh" " " $1 " ."}' > $2

