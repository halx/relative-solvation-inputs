windows="$(seq 0.0 0.05 0.95) 0.975 0.9825 0.99 0.995 1.00"

:> mbar.dat

for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" ti.in.tmpl > $w/ti.in.tmpl
  echo $w >> mbar.dat

  (cd $w; ln -sf ../onestep.rst7 ti000.rst7; ln -sf ../mbar.dat)
done
