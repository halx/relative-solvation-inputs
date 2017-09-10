windows=0.50


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" min.in.tmpl > $w/min.in

  (cd $w; ln -sf ../../../pmemd_sc_2step_1.rst7 start.rst7)
done
