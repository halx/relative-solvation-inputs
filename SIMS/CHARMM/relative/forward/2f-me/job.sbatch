#!/bin/bash
#SBATCH -A crl231
#SBATCH --job-name="CHG"
#SBATCH --output="CHG.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --export=ALL
#SBATCH -t 03:00:00

charmm=/home/dsuh/c40b1/exec/gnu_M/charmm

win=0
cycle=1
ibrun -v $charmm win=$win cycle=$cycle < g_chg.inp > chg_w${win}_i${cycle}.out
