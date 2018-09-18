mkdir block_20_times
mkdir block_20_results


3dDeconvolve -nodata 300 1 -polort 1 \
-num_stimts 3 \
-stim_times 1 blockt.20.A.txt 'BLOCK(20)' -stim_label 1 'A' \
-stim_times 2 blockt.20.B.txt 'BLOCK(20)' -stim_label 2 'B' \
-stim_times 3 blockt.20.C.txt 'BLOCK(20)' -stim_label 3 'C' \
-gltsym "SYM: A -B" -gltsym "SYM: A -C" | cat > block_20.txt

mv block_20.txt block_20_results

mv blockt.20*.txt block_20_times

rm nodata*.1D 3dD*.err