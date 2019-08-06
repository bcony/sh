#

echo "Checking All VASP Files..."

cd ./init ; echo -e "1 \n109" |vaspkit |grep "Error" ; cd ../

echo "Done"
echo "Generating Files..." 

for i in {2..9}; do cp -r init ./KPOINTS_$i && sed -i "4c   $i    $i    $i" KPOINTS_$i/KPOINTS ; done

echo "Done"
echo "Running VASP..."

echo "Input the Number of Processors : "
read "Num"

echo "Running..."
for i in KPOINTS_* ;do cd $i ; mpirun -np $Num vasp_std ; cd .. ; done

echo "Done"
echo "Extracting Data..."

for i in KPOINTS_*; do echo -e $(sed -n '4p' $i/KPOINTS | awk '{print $1}') "\t" $(grep 'without' $i/OUTCAR | tail -n 1| awk '{print $7}') ;done > energy_KPOINTS.dat


echo "Done"




