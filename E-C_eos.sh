#
#
#
#
#
echo "Checking All VASP Files..."

cd ./init ; echo -e "1 \n109" |vaspkit |grep "Error" ; cd ../

echo "Done"
echo "Generating Files..."
 
for i in 280 320 360 400 440 480 520 ; do cp -r ./init ./ENCUT_$i ; sed -i "s/^.*ENCUT.*$/  ENCUT = $i/g" ENCUT_$i/INCAR ; done

echo "Done"
echo "Running VASP..."

echo "Input the Number of Processors : "
read "Num"

for i in ENCUT_* ;do cd $i; mpirun -np $Num vasp_std ; cd .. ; done

echo "Done"
echo "Extracting Data..."

for i in ENCUT_*; do echo -e $(grep 'ENCUT' $i/INCAR |awk '{print $3}') "\t" $(grep 'without' $i/OUTCAR | tail -n 1| awk '{print $7}') ;done > energy_ENCUT.dat

echo "Done"





