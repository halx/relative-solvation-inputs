windows=0.5


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" min.in.tmpl > $w/min.in

  (cd $w; ln -sf ../../../charge.rst7 start.rst7)
done
