#!/bin/bash

# Configuration
SAMPLES=("wt1" "wt2" "wt3" "wt4" "wt5" "wt6" "mut1" "mut2" "mut3" "mut4" "mut5" "mut6" "mut7") 
REF_BED="epitype_ref/epitype_500mvcpg_hg38.bed"
INPUT_DIR="modbed"
OUTPUT_DIR="interepitype500"

mkdir -p $OUTPUT_DIR

for ID in "${SAMPLES[@]}"; do
    bedtools intersect -a "$REF_BED" -b "$INPUT_DIR/${ID}_5mC.bed" -wa -wb | \
    awk 'BEGIN{OFS="\t"} {print $1,$2,$3,$4,$15}' > "$OUTPUT_DIR/${ID}_interepitype500_ratio.bed"
done
