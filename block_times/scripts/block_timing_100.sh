mkdir block_100_times
mkdir block_100_results


3dDeconvolve -nodata 300 1 -polort 1 \
-num_stimts 3 \
-stim_times 1 blockt.100.A.txt 'BLOCK(100)' -stim_label 1 'A' \
-stim_times 2 blockt.100.B.txt 'BLOCK(100)' -stim_label 2 'B' \
-stim_times 3 blockt.100.C.txt 'BLOCK(100)' -stim_label 3 'C' \
-gltsym "SYM: A -B" -gltsym "SYM: A -C" | cat > block_100.txt

mv block_100.txt block_100_results

mv blockt.100*.txt block_100_times

rm nodata*.1D 3dD*.err