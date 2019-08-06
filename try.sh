echo "是否需要自定义生成输入文件? y or n"
read yon
if [[$yon = "y"]];then
echo "Generating Input Files..."

mkdir init ; mv POSCAR init/POSCAR
cat ~/baiguoning/POTCARS/$(sed -n "6p" init/POSCAR |awk '{print $1}')/POTCAR ~/baiguoning/POTCARS/$(sed -n "6p" init/POSCAR |awk '{pri/']'[lnt $2}')/POTCAR ~/baiguoning/POTCARS/$(sed -n "6p" init/POSCAR |awk '{print $3}')/POTCAR	 >> init/POTCAR
cd init ; echo -e "1 \n101 \n st" |vaspkit ; cd ../ 
cd init ; echo -e "1 \n102 \n2 \n0" |vaspkit ; cd ../

echo "done"
#for i in {1..5} ;do cat ~/baiguoning/POTCARS/$(sed -n "6p" init/POSCAR |awk '{print $$i}')/POTCAR >> init/POTCAR ;done
fi

echo "Checking All VASP Files..."

cd ./init ; echo -e "1 \n109" |vaspkit |grep "Error" ; cd ../

echo "Done"
echo "Generating Files..."