#!/bin/bash
#
# submit multiple dependend jobs on sid (iDataPlex)
#


wall=02:00
nodes=8

module load gcc/6.2.0 > /dev/null 2>&1
export LD_LIBRARY_PATH=$AMBERHOME/lib_gnu:$LD_LIBRARY_PATH

if [ $# -lt 3 ]; then
  echo "Usage: $0 prmtop start stop"
  exit 1
fi

case "$2" in
  [0-9]*)
    start=$2
  ;;
  *)
    echo "start must be a number"
    exit 1;
  ;;
esac

case "$3" in
  [0-9]*)
    stop=$3
  ;;
  *)
    echo "stop must be a number"
    exit 1;
  ;;
esac

prmtop=$1

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

  sed -e "s/%R1%/\$irest/" -e "s/%R2%/\$ntx/" ti.in.tmpl > \${curr}.in

  mpirun -lsf $AMBERHOME/bin_gnu/pmemd.MPI \
    -i \${curr}.in -p $prmtop -c \${prev}.rst7 \
    -O -o \${curr}.out -inf \${curr}.info -e \${curr}.en -r \${curr}.rst7 \
       -x \${curr}.nc -l \${curr}.log
_EOF
