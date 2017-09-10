windows="0.005 $(seq 0.05 0.05 0.95) 0.995"


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" -e "s/%[CM]%/:1@H14,C15,H16,H17,C18,H19,H20,C21,H22,H23,C24,H25,H26/" ti.in.tmpl > $w/ti0.in
  sed -e "s/%L%/$w/" -e "s/%[CM]%/:1@H17,C18,H19,H20,C21,H22,H23,C24,H25,H26,C27,H28,H29/" ti.in.tmpl > $w/ti1.in

  (
    cd $w
    ln -sf ../../../state0.rst7 ti000_0.rst7
    ln -sf ../../../state1.rst7 ti000_1.rst7
  )
done