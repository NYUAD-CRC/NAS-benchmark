# This script is responsible for cleaning the environmenet and configuring compilation flags
if [ -d "./NPB3.4.2" ]
then
	echo "Removing old directory"
	rm -rf NPB3.4.2	
else
	echo "First compilation"
fi

echo "Untaring the file"
tar xzf ./NPB3.4.2.tar.gz 

echo "Configuring the compilation flags"
cp flags.def ./NPB3.4.2/NPB3.4-MPI/config/make.def
