
f=5

for i in `seq 1 $f`; do

make_random_timing.py -num_stim 3 -num_runs 1 \
-run_time 300 \
-stim_labels A B C \
-num_reps 20 \
-prefix stimt_${i} \
-stim_dur 2 \
-min_rest 1 \
-max_rest 5 \
-max_consec 1 \
-seed ${i}

3dDeconvolve -nodata 300 1 -polort 1 \
-num_stimts 3 \
-stim_times 1 stimt_${i}_01_A.1D 'BLOCK(20)' -stim_label 1 'A' \
-stim_times 2 stimt_${i}_02_B.1D 'BLOCK(20)' -stim_label 2 'B' \
-stim_times 3 stimt_${i}_03_C.1D 'BLOCK(20)' -stim_label 3 'C' \
-gltsym "SYM: A -B" -gltsym "SYM: A -C" | cat > mrt_lnr_out_${i}.txt

done

for i in `seq 1 $f`; do

efficiency=`scripts/efficiency_parser.py mrt_lnr_out_${i}.txt`
echo "$efficiency $i"

done > mrt_lnr_results.txt

mv mrt_lnr_out_* mrt_lnr_times

mv mrt_lnr_results.txt mrt_lnr_results

sort mrt_lnr_results/mrt_lnr_results.txt -n -k 1 > mrt_lnr_results/mrt_lnr_results_ordered.txt

head -n1 mrt_lnr_results/mrt_lnr_results_ordered.txt > mrt_lnr_results/mrt_lnr_head.txt

awk '{$1=""}1' mrt_lnr_results/mrt_lnr_head.txt | awk '{$1=$1}1' > mrt_lnr_results/mrt_lnr_head_value.txt

s=`cat mrt_lnr_results/mrt_lnr_head_value.txt`

make_random_timing.py -num_stim 3 -num_runs 1 \
-run_time 300 \
-stim_labels A B C \
-num_reps 20 \
-prefix mrt_lnr_head_one \
-stim_dur 2 \
-min_rest 1 \
-max_rest 5 \
-max_consec 1 \
-seed $s

timing_tool.py -timing mrt_lnr_head_one_01_A.1D -timing_to_1D stim_A.1D -tr 1 -run_len 300 -stim_dur 1 -min_frac .6

timing_tool.py -timing mrt_lnr_head_one_02_B.1D -timing_to_1D stim_B.1D -tr 1 -run_len 300 -stim_dur 1 -min_frac .6

timing_tool.py -timing mrt_lnr_head_one_03_C.1D -timing_to_1D stim_C.1D -tr 1 -run_len 300 -stim_dur 1 -min_frac .6

1dcat stim_A.1D stim_B.1D stim_C.1D > mrt_lnr_one_file.1D

1dplot -one -png design.png mrt_lnr_one_file.1D

mv design.png stim_* mrt_lnr_one_file.1D mrt_lnr_results

mv 3d*.err mrt_lnr_head*.1D nodata*.1D stimt* mrt_lnr_times

timing_tool.py -multi_timing mrt_lnr_times/stimt_${i}_*.1D \
-multi_timing_to_events mrt_lnr_times.1d -tr 1 -multi_stim_dur 1 \
-min_frac .5  -run_len 300

mv mrt_lnr_times.1d mrt_lnr_times











