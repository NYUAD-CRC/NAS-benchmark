#!/bin/bash

# Loading needed modules 
module purge
module load openmpi/4.0.4rc3
module load gcc

# Accepting user inputs
ARG1=${1:-$Benchmark}
ARG2=${2:-$Class}

cd NPB3.4.2/NPB3.4-MPI

if [ -z "$ARG1" ] && [ -z "$ARG2" ] 
then
	echo "Choose Benchmark index: "
        select Benchmark in is ep cg mg ft bt sp lu
        do
                echo "Selected Benchmark: $Benchmark"
                echo "Selected number: $REPLY"
                break
        done

        echo "Choose index of Class of compilation: "
        select Class in S W A B C D E F
        do
                echo "Selected class: $Class"
                echo "Selected number: $REPLY"
                break
        done


	echo "Enter Number of cores: "
        read num_cores
        echo "The Current Number of cores is $num_cores"

	#Running the executable
	echo "mpiexec -np $num_cores bin/$Benchmark.$Class.x"
	mpiexec -np $num_cores bin/$Benchmark.$Class.x
else
	srun bin/$ARG1.$ARG2.x
fi
