windows="$(seq 0.0 0.05 1.0) 0.975 0.9825 0.99 0.995"

: > mbar.dat

for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  echo $w >> mbar.dat

  sed -e "s/%L%/$w/" ti.in.tmpl > $w/ti.in.tmpl

  (cd $w; ln -sf ../../../vdw.rst7 ti000.rst7; ln -s ../mbar.dat)
done
