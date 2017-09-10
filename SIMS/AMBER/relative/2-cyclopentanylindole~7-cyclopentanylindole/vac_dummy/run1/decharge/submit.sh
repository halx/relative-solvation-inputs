#!/bin/bash
#
# submit multiple dependend jobs on sid (iDataPlex)
#


wall=01:00
nodes=2

module load gcc/4.9.4 > /dev/null 2>&1
export LD_LIBRARY_PATH=$AMBERHOME/lib:$LD_LIBRARY_PATH

if [ $# -lt 2 ]; then
  echo "Usage: $0 start stop"
  exit 1
fi

case "$1" in
  [0-9]*)
    start=$1
  ;;
  *)
    echo "start must be a number"
    exit 1;
  ;;
esac

case "$2" in
  [0-9]*)
    stop=$2
  ;;
  *)
    echo "stop must be a number"
    exit 1;
  ;;
esac

if [ $stop -lt $start ]; then
  echo "stop must be larger than start"
  exit 2
fi


bsub <<-_EOF
  #BSUB -J "ti[$start-$stop]%1"
  #BSUB -n $nodes
  #BSUB -q scarf
  #BSUB -x
  #BSUB -m "scarf16+16 scarf15+15 scarf14+14 scarf13+13 scarf12+12 scarf11+11 scarf10+10"
  #BSUB -W $wall
  #BSUB -e ti%I.err

  jidx=\$LSB_JOBINDEX
  curr=ti\$(printf "%03i" \$jidx)
  prev=\$(expr \$jidx - 1)
  prev=ti\$(printf "%03i" \$prev)

  if [ "\$LSB_JOBINDEX" -lt 2 ]; then
    irest=0
    ntx=1
  else
    irest=1
    ntx=5
  fi

  sed -e "s/%P/\$prev/g" -e "s/%C/\$curr/g" ../lambda.group > \${curr}.group
  sed -e "s/%R1%/\$irest/" -e "s/%R2%/\$ntx/" ti0.in.tmpl > ti0.in
  sed -e "s/%R1%/\$irest/" -e "s/%R2%/\$ntx/" ti1.in.tmpl > ti1.in

  mpirun -np $nodes $AMBERHOME/bin/sander.MPI -O -ng 2 -groupfile \${curr}.group

_EOF
