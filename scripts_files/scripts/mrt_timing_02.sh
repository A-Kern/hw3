mkdir mrt_iti_times
mkdir mrt_iti_results

f=500

for i in `seq 1 $f`; do

make_random_timing.py -num_stim 3 -num_runs 1 \
-run_time 300 \
-stim_labels A B C \
-num_reps 20 \
-prefix stimt_${i} \
-stim_dur 2 \
-min_rest 1 \
-max_rest 5 \
-seed ${i}

3dDeconvolve -nodata 300 1 -polort 1 \
-num_stimts 3 \
-stim_times 1 stimt_${i}_01_A.1D 'GAM' -stim_label 1 'A' \
-stim_times 2 stimt_${i}_02_B.1D 'GAM' -stim_label 2 'B' \
-stim_times 3 stimt_${i}_03_C.1D 'GAM' -stim_label 3 'C' \
-gltsym "SYM: A -B" -gltsym "SYM: A -C" | cat > mrt_iti_out_${i}.txt

done

for i in `seq 1 $f`; do

efficiency=`scripts/efficiency_parser.py mrt_iti_out_${i}.txt`
echo "$efficiency $i"

done > mrt_iti_results.txt

mv mrt_iti_out_* mrt_iti_times

mv mrt_iti_results.txt mrt_iti_results

sort mrt_iti_results/mrt_iti_results.txt -n -k 1 > mrt_iti_results/mrt_iti_results_ordered.txt

head -n1 mrt_iti_results/mrt_iti_results_ordered.txt > mrt_iti_results/mrt_iti_head.txt

awk '{$1=""}1' mrt_iti_results/mrt_iti_head.txt | awk '{$1=$1}1' > mrt_iti_results/mrt_iti_head_value.txt

s=`cat mrt_iti_results/mrt_iti_head_value.txt`

make_random_timing.py -num_stim 3 -num_runs 1 \
-run_time 300 \
-stim_labels A B C \
-num_reps 20 \
-prefix mrt_iti_head_one \
-stim_dur 2 \
-min_rest 1 \
-max_rest 5 \
-seed $s

timing_tool.py -timing mrt_iti_head_one_01_A.1D -timing_to_1D stim_A.1D -tr 1 -run_len 300 -stim_dur 1 -min_frac .6

timing_tool.py -timing mrt_iti_head_one_02_B.1D -timing_to_1D stim_B.1D -tr 1 -run_len 300 -stim_dur 1 -min_frac .6

timing_tool.py -timing mrt_iti_head_one_03_C.1D -timing_to_1D stim_C.1D -tr 1 -run_len 300 -stim_dur 1 -min_frac .6

1dcat stim_A.1D stim_B.1D stim_C.1D > mrt_iti_one_file.1D

1dplot -one -png design.png mrt_iti_one_file.1D

mv design.png stim_* mrt_iti_one_file.1D mrt_iti_results

mv 3d*.err mrt_iti_head*.1D nodata*.1D stimt* mrt_iti_times

timing_tool.py -multi_timing mrt_iti_times/stimt_${i}_*.1D \
-multi_timing_to_events mrt_iti_times.1d -tr 1 -multi_stim_dur 1 \
-min_frac .5  -run_len 300

mv mrt_iti_times.1d mrt_iti_times















