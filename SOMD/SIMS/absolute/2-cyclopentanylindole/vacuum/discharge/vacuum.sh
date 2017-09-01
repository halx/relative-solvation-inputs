#!/bin/bash
#SBATCH -o somd-array-gpu-%A.%a.out
#SBATCH -p Tesla
#SBATCH -n 1
#SBATCH --gres=gpu:1
#SBATCH --time 48:00:00
#SBATCH --array=0-16


module load cuda/7.5

#export OPENMM_CUDA_COMPILER=/usr/local/cuda-7.0/bin/nvcc

echo "CUDA DEVICES:" $CUDA_VISIBLE_DEVICES

lamvals=( 0.0000 0.0625 0.1250 0.1875 0.2500 0.3125 0.3750 0.4375 0.5000 0.5625 0.6250 0.6875 0.7500 0.8125 0.8750 0.9375 1.0000)

lam=${lamvals[SLURM_ARRAY_TASK_ID]}

echo "lambda is: " $lam

mkdir lambda-$lam
cd lambda-$lam
cp ../../input/MORPH.pert.discharge MORPH.pert
cp ../../input/sim.cfg    .
cp ../../input/SYSTEM.top .
cp ../../input/SYSTEM.crd .

export OPENMM_PLUGIN_DIR=/home/julien/sire.app/lib/plugins/

srun ~/sire.app/bin/somd-freenrg -C sim.cfg -t SYSTEM.top -c SYSTEM.crd -m MORPH.pert -l $lam -p CUDA
cd ..

wait
