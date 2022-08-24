#!/bin/bash

This script is responsible for running the different benchmarks with the available classes.
#This script can be used in 3 ways:
#1-./run.sh :choose the benchmark/s,class/es from the list and put number of cores
#2-./run.sh with he benchamtk name, and/or class name , and/or number of cores (./run.sh is S 16)
#3-sbatch -n 16 ./run.sh is S 16 (Or) sbatch -n 16 ./run.sh is S (Or) sbatch -n 32 -N 1 ./run.sh is S (one node) : running with sbatch

# Loading needed modules 
module purge
module load openmpi/4.1.1rc1
module load gcc

#Accepting input arguments
ARG1=${1}
ARG2=${2}
ARG3=${3:-$SLURM_NTASKS}

#Benchmark funstion
Select_benchmark(){
    	echo "Choose Benchmark index: "
	select Benchmark in is ep cg mg ft bt sp lu
	do
		echo "Selected Benchmark: $Benchmark"
		echo "Selected number: $REPLY"
		break
	done
	ARG1=$Benchmark
}

#Classes function
Select_Class(){
    	echo "Choose index of Class of compilation: "
        select Class in S W A B C D E F
        do
                echo "Selected class: $Class"
                echo "Selected number: $REPLY"
                break
        done
        ARG2=$Class
}

#Cores function
GetCores(){
    	echo "Enter Number of cores: "
        read num_cores
        echo "The Current Number of cores is $num_cores"
        ARG3=$num_cores
}

#Running function
run(){
#	mpiexec -n $ARG3 -x PATH -x LD_LIBRARY_PATH -wdir $PWD --map-by slot bin/$ARG1.$ARG2.x
mpiexec -n $ARG3 -x PATH -x LD_LIBRARY_PATH -wdir $PWD  bin/$ARG1.$ARG2.x
}


#SBATCH is not used 
if [ -z "$ARG1" ]
then
	Select_benchmark
fi

if [ -z "$ARG2" ]
then
	Select_Class
fi

if [ -z "$ARG3" ]
then
	GetCores
fi

#Running the executable
cd NPB3.4.2/NPB3.4-MPI
echo "mpiexec -n $ARG3 -x PATH -x LD_LIBRARY_PATH -wdir $PWD --map-by slot  bin/$ARG1.$ARG2.x "
echo "$ARG1"
echo "$ARG2"
echo "$ARG3"

#Calling the running function
run
