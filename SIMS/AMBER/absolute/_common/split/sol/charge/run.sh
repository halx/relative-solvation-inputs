for w in $(cat mbar.dat); do
  cd $ws
  ../submit.sh ../../charge.parm7 1 2
  cd ..
done
