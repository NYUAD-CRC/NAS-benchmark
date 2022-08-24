#!/bin/bash
#SBATCH -n 256
#SBATCH -C dalma
#SBATCH -t 1:00:00

# Params are $1: Benchmark 
# Params are $2: Class
# Params are $3: CPUs 
declare -a ARGS 

#Running function
function run(){
#	 mpiexec               -x PATH -x LD_LIBRARY_PATH -wdir $PWD  bin/${ARGS[0]}.${ARGS[1]}.x
	mpiexec -n ${ARGS[2]} -x PATH -x LD_LIBRARY_PATH -wdir $PWD --map-by slot  bin/${ARGS[0]}.${ARGS[1]}.x
	#srun  -n ${ARGS[2]} ./bin/${ARGS[0]}.${ARGS[1]}.x
}

function getBenchmark() {
	echo "Choose Benchmark index: "
	select Benchmark in is ep cg mg ft bt sp lu
	do
		echo "Selected Benchmark: $Benchmark"
		echo "Selected number: $REPLY"
		break
	done
	ARGS[0]=$Benchmark
}

function getClass() {
	echo "Choose index of Class of compilation: "
        select Class in S W A B C D E F
        do
                echo "Selected class: $Class"
                echo "Selected number: $REPLY"
                break
        done
        ARGS[1]=$Class
}

function getCores() {
	if [ ! -z $SLURM_NPROCS ]; then 
        	ARGS[2]=$SLURM_NPROCS
	else
		echo "Enter Number of cores: "
	        read num_cores
       		echo "The Current Number of cores is $num_cores"
        	ARGS[2]=$num_cores
	fi
}

# Loading needed modules 
module purge
module load openmpi
module load gcc

i=0
if  [ $# -gt 0 ]; then 
	while [ ! -z $1 ]; do
		ARGS[$i]=$1
		shift
		i=$(($i+1))
	done
fi

echo "*************"
echo ${ARGS[@]}
echo "*************"

case ${#ARGS[@]} in
	0)
		getBenchmark
		getClass
		getCores
		;;
	1)
		getClass
		getCores
		;;
	2) 
		getCores
		;;
esac

#Running the executable
cd NPB3.4.2/NPB3.4-MPI
echo "mpiexec -n ${ARGS[2]} -x PATH -x LD_LIBRARY_PATH -wdir $PWD  bin/${ARGS[0]}.${ARGS[1]}.x "
echo "${ARGS[0]}"
echo "${ARGS[1]}"
echo "${ARGS[2]}"

#Calling the running function
run

