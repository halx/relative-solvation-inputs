for w in $(cat mbar.dat); do
  cd $w
  ../../submit.sh ../../../../solvated.parm7 1 2
  cd ..
done
