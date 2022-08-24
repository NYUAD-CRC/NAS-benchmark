#!/bin/bash
This script is responsible for compilating the different benchmarks with the available classes.

# Loading needed modules 
module purge
module load openmpi/4.0.4rc3
module load gcc

# Working on the MPI version
cd NPB3.4.2/NPB3.4-MPI

#Global variables
Benchmark_array=("IS" "EP" "CG" "MG" "FT" "BT" "SP" "LU" "All") 
Available_classes_array=("S" "W" "A" "B" "C" "D" "E" "F" "All") 

#Compilation function
compilation(){
	make $1 CLASS=$2

}

# Benchmark choosing
echo -e "Choose Benchmark index or All if you want to compile all availble benchmarks:\n "
select Benchmark in "${Benchmark_array[@]}"
do
    echo "Selected Benchmark: $Benchmark"
    break
done

# Formating selected benchmark array
Selected_benchmark=()
if [ "$Benchmark" == "All" ]
then
	Selected_benchmark=("IS" "EP" "CG" "MG" "FT" "BT" "SP" "LU")
else
	Selected_benchmark[$i]=$Benchmark
fi

# Formating selected classes array 
Selected_class=()
for i in "${!Selected_benchmark[@]}"
do
	echo "Choose Class index for benchmark ${Benchmark_array[$i]}: "
	select Class in "${Available_classes_array[@]}"
	do
		echo "Selected class: $Class"
                Selected_class[$i]=$Class
		break
	done
done

# Compilation 
for i in "${!Selected_benchmark[@]}"
do
	# All classes compilation
	if [ "${Selected_class[$i]}" == "All" ]
        then
                for ((j=0 ; j<${#Available_classes_array[@]}-1; j++));
                do
			compilation ${Selected_benchmark[$i]}  ${Available_classes_array[$j]}
                done

        #Single class compilation
        else
		compilation ${Selected_benchmark[$i]} ${Selected_class[$i]}
        fi
done
