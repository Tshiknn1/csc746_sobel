#!/bin/bash -l
#SBATCH -A m3930
#SBATCH -C gpu
#SBATCH -q shared
#SBATCH -t 0:10:00
#SBATCH -n 1
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH -J csc746_f25_evan_caplinger_sobel_gpu
#SBATCH --mail-user=ecaplinger@sfsu.edu
#SBATCH --mail-type=ALL

# first, "reset" the GPU to work around a known potential error
dcgmi profile --pause

echo "ncu --set basic  --metrics smsp__cycles_active.avg.pct_of_peak_sustained_elapsed,dram__throughput.avg.pct_of_peak_sustained_elapsed,gpu__time_duration.avg --replay-mode kernel  --launch-count 1 ./sobel_gpu $N $B"
ncu --set basic  --metrics smsp__cycles_active.avg.pct_of_peak_sustained_elapsed,dram__throughput.avg.pct_of_peak_sustained_elapsed,gpu__time_duration.avg --replay-mode kernel  --launch-count 1 build/sobel_cpu_omp_offload $N $B

