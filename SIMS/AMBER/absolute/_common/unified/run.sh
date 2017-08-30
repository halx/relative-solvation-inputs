for w in $(cat mbar.dat); do
  cd $w
  ../submit.sh 1 2
  cd ..
done
