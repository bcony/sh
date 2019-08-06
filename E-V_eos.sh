#
#
#
#
#
echo "Checking All VASP Files..."

cd ./init ; echo -e "1 \n109" |vaspkit |grep "Error" ; cd ../

echo "Done"
echo "Generating Files..."
 
for i in 0.95 0.96 0.97 0.98 0.99 1.00 1.01 1.02 1.03 1.04 1.05 ; do cp -r ./init ./Volume_$i && sed -i "2s/1.00/$i/g" Volume_$i/POSCAR ; done

echo "Done"
echo "Running VASP..."

echo "Input the Number of Processors : "
read "Num"

for i in Volume_* ;do cd $i ; mpirun -np $Num vasp_std ; cd .. ; done

echo "Done"
echo "Extracting Data..."

for i in Volume_*; do echo -e  $i "\t" $(grep ' volume of cell' $i/OUTCAR | tail -n 1| awk '{print $5}') "\t" $(grep 'without' $i/OUTCAR | tail -n 1| awk '{print $7}') ;done > energy_Volume.dat
echo "Done"





