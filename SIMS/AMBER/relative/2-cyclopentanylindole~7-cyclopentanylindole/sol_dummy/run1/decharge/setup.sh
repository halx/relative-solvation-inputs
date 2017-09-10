windows="0.005 $(seq 0.1 0.1 0.9) 0.995"


for w in $windows; do
  if [ \! -x $w ]; then
    mkdir $w
  fi

  sed -e "s/%L%/$w/" -e "s/%C%//" ti.in.tmpl > $w/ti0.in.tmpl
  sed -e "s/%L%/$w/" -e "s/%C%/:1@H17,C18,H19,H20,C21,H22,H23,C24,H25,H26,C27,H28,H29/" ti.in.tmpl > $w/ti1.in.tmpl

  (
    cd $w
    ln -sf ../../../state0.rst7 ti000_0.rst7
    ln -sf ../../../state0.rst7 ti000_1.rst7
  )
done
