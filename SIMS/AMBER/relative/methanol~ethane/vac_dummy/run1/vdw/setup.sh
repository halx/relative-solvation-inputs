windows="0.005 $(seq 0.05 0.05 0.95) 0.995"


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" -e "s/%M%/:1@DU=/" ti.in > $w/ti0.in
  sed -e "s/%L%/$w/" -e "s/%M%/:1@H7,H8/" ti.in > $w/ti1.in

  (
    cd $w
    ln -sf ../../../state0.rst7 ti000_0.rst7
    ln -sf ../../../state_int.rst7 ti000_1.rst7
  )
done
