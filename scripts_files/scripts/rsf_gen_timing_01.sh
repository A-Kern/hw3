mkdir rsf_times
mkdir rsf_results

f=500

for i in `seq 1 $f`; do

RSFgen \
-nt 300 \
-num_stimts 3 \
-nreps 1 20 \
-nreps 2 20 \
-nreps 3 20 \
-seeds $i \
-prefix stim_${i}_ 

make_stim_times.py \
-files stim_${i}_*.1D \
-prefix stimt_${i}_ \
-nt 300 \
-tr 1 \
-nruns 1 

3dDeconvolve -nodata 300 1 -polort 1 \
-num_stimts 3 \
-stim_times 1 stimt_${i}_.01.1D 'GAM' -stim_label 1 'A' \
-stim_times 2 stimt_${i}_.02.1D 'GAM' -stim_label 2 'B' \
-stim_times 3 stimt_${i}_.03.1D 'GAM' -stim_label 3 'C' \
-gltsym "SYM: A -B" -gltsym "SYM: A -C" | cat > rsf_out_${i}.txt

done

mv stim* rsf_times

for i in `seq 1 $f`; do

efficiency=`scripts/efficiency_parser.py rsf_out_${i}.txt`
echo "$efficiency $i"

done > rsf_results.txt

mv rsf_out_* rsf_times

mv rsf_results.txt rsf_results

sort rsf_results/rsf_results.txt -n -k 1 > rsf_results/rsf_results_ordered.txt

head -n1 rsf_results/rsf_results_ordered.txt > rsf_results/rsf_head.txt

awk '{$1=""}1' rsf_results/rsf_head.txt | awk '{$1=$1}1' > rsf_results/rsf_head_value.txt

s=`cat rsf_results/rsf_head_value.txt`

RSFgen \
-nt 300 \
-num_stimts 3 \
-nreps 1 20 \
-nreps 2 20 \
-nreps 3 20 \
-seeds $s \
-one_file \
-prefix rsf_head_one

1dplot -one -png design.png rsf_head_one.1D

mv rsf_head_one.1D design.png rsf_results

mv 3dD*.err nodata*.1D rsf_times