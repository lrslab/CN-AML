MODEL_NAME=r941_prom_sup_g5014
run_clair3.sh \
  --bam_fn=bam/wt1.bam \
  --ref_fn=ref/hg38.fa \
  --threads=16 \
  --platform="ont" \
  --model_path=clair3/bin/models/r941_prom_sup_g5014/ \
  --min_coverage=1 \
  --output=clair3_out/wt1/
