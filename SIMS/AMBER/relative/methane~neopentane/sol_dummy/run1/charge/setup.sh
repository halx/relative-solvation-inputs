windows=$(seq 0.0 0.1 1.0)


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" ti.in.tmpl > $w/ti.in.tmpl

  (cd $w; ln -sf ../../../charge.rst7 ti000.rst7)
done
