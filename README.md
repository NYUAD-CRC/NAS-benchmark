# NAS-benchmark
This repository includes configuration, compilation and running bash scripts for NAS benchmark

**Steps:**
1. **./clean_config.sh** : This script is responsible for cleaning the environmenet and configuring compilation flags.
2. **./compile.sh** : This script is responsible for compilating the different benchmarks with the available classes.
3. **./run.sh**: This script is responsible for running the different benchmarks with the available classes.

The run script can be used in different ways:
- ./run.sh :choose the benchmark/s,class/es from the list and put number of cores (interactively on the compute node)
- ./run.sh with the benchamtk name, and/or class name , and/or number of cores (./run.sh is S 16) (interactively on the compute node)
- sbatch -n 16 ./run.sh is S 16 **(Or)** sbatch -n 16 ./run.sh is S **(Or)** sbatch -n 32 -N 1 ./run.sh is S **(one node)** : (running with sbatch)
