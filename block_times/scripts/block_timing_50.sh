mkdir block_50_times
mkdir block_50_results


3dDeconvolve -nodata 300 1 -polort 1 \
-num_stimts 3 \
-stim_times 1 block_50_times/blockt.50.A.txt 'BLOCK(50)' -stim_label 1 'A' \
-stim_times 2 block_50_times/blockt.50.B.txt 'BLOCK(50)' -stim_label 2 'B' \
-stim_times 3 block_50_times/blockt.50.C.txt 'BLOCK(50)' -stim_label 3 'C' \
-gltsym "SYM: A -B" -gltsym "SYM: A -C" | cat > block_50.txt

mv block_50.txt block_50_results


rm nodata*.1D 3dD*.err