#!/bin/bash

# Loading needed modules 
module purge
module load openmpi/4.0.4rc3
module load gcc

ARG1=${1:-$Benchmark}
ARG2=${2:-$Class}
ARG3=${3:-$SLURM_NTASKS}

echo $ARG3

#Running function
run(){
	mpiexec -n $ARG3 -x PATH -x LD_LIBRARY_PATH -wdir $PWD --map-by slot bin/$ARG1.$ARG2.x
}

#SBATCH is not used 
if [ -z "$ARG3" ]
then
	echo "Choose Benchmark index: "
	select Benchmark in is ep cg mg ft bt sp lu
	do
		echo "Selected Benchmark: $Benchmark"
		echo "Selected number: $REPLY"
		break
	done
	ARG1=$Benchmark

	echo "Choose index of Class of compilation: "
        select Class in S W A B C D E F
        do
                echo "Selected class: $Class"
                echo "Selected number: $REPLY"
                break
        done
        ARG2=$Class

	echo "Enter Number of cores: "
        read num_cores
        echo "The Current Number of cores is $num_cores"
        ARG3=$num_cores
fi

#Running the executable
cd NPB3.4.2/NPB3.4-MPI
echo "mpiexec -n $ARG3 -x PATH -x LD_LIBRARY_PATH -wdir $PWD --map-by core  bin/$ARG1.$ARG2.x "
echo "$ARG1"
echo "$ARG2"
echo "$ARG3"

#Calling the running function
run

