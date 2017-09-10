windows="0.00 0.005 0.01 0.0175 0.025 $(seq 0.05 0.05 1.00)"


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" ti.in.tmpl > $w/ti.in.tmpl

  (cd $w; ln -sf ../../../vdw.rst7 ti000.rst7)
done
