dist_log=dist.log
for w in [01].*; do
  cd $w;
  /usr/local/amber16/bin/cpptraj -i ../dist.in -p ../../../state1.parm7 | \
    grep ^Result > $dist_log

  echo -n "$w "; python ../../aver.py $dist_log
  cd ..;
done
