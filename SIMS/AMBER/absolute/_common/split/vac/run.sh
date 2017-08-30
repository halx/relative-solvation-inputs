for w in [01].*; do
  cd $w
  ../submit.sh 1 2
  cd ..
done
