windows="0.005 $(seq 0.1 0.1 0.9) 0.995"


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" -e "s/%M%/:1/" ti.in > $w/ti0.in
  sed -e "s/%L%/$w/" -e "s/%M%//" ti.in > $w/ti1.in

  (
    cd $w
    ln -sf ../vacuum.rst7 ti000_0.rst7
    ln -sf ../vacuum.rst7 ti000_1.rst7
  )
done
