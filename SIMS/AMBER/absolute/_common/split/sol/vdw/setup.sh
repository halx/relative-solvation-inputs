. ../../../window.lst

MBAR_DAT=mbar.dat

:> $MBAR_DAT

for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  echo $w >> $MBAR_DAT
  sed -e "s/%L%/$w/" ti.in.tmpl > $w/ti.in.tmpl

  cd $w
    ln -sf ../../../../md00005.rst7 ti000.rst7
    ln -sf ../$MBAR_DAT
  cd ..
done

sort -n $MBAR_DAT > tmp.sort
mv tmp.sort $MBAR_DAT
