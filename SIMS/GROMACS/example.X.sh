#!/bin/bash
#
# Template script for SLURM jobs
# Note that "#SBATCH" is not a comment, but "# SBATCH" is (note the space after "#")
# For the online manual for sbatch, type "man sbatch" in the terminal

# Job name:
#----------------
#SBATCH --job-name="relative_X"
#----------------

# Account name (semi-optional):
#----------------
# SBATCH --account=
#----------------

# Partition name:
#----------------
#SBATCH --partition=mf_nes2.8,mf_ilg2.3
#----------------

######################
# The possible job submission partitions are listed here.
# Name:       CPU type:      Cores(Threads)/Node:  Speed:
# mf_m-c1.9   1.9GHz AMD       48                  0.5
# mf_ilg2.3   2.3GHz AMD       32(64)              0.7
# mf_nes2.8   2.8GHz Intel     8(16)-12(24)        1.0
#
# Slurm schedules each processor core to a single job only. Multithreaded jobs
# can take advantage of multiple threads per core.
#
# The 2.3GHz AMD nodes have 32 modules, each with 2 integer cores and 1 floating-
# point core. Each module is scheduled as a single core with two threads.
#
######################
#
######################

# Specifying resources needed for run:
#
#--------------
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1400mb
#SBATCH --time=4-10:00:00
#SBATCH --distribution=block:cyclic
# SBATCH --licenses=foo:4,bar
#--------------

#########################################
# Set copy_local to "yes" to copy contents of submission directory to node-local workspace.
# After the calculation, results will be copied back and the temporary work directory
# /work/$USER/$SLURM_JOB_ID will be deleted.
#
# If time runs out before the job is done, the copyback will be done by a post-execution
# script, but only if the SLURM_WORK_DIR-$SLURM_JOB_ID file (created in this script) exists in the
# submission directory.

copy_local="no"

#########################################

# Define some simpler local evironment variables:
nprocs=$SLURM_NTASKS
nnodes=$SLURM_JOB_NUM_NODES

slurm_startjob(){
#----------------- Actual calculation command goes here: ---------------------------

module unload gnu
module load intel

unset OMP_NUM_THREADS
export GMX_MAXBACKUP="-1" #Disable backups
export GMXRC=/modfac/apps/gromacs-4.6.7_gcc-generic/bin/GMXRC
export GMXLIB=/modfac/apps/gromacs-4.6.7_gcc-generic/share/gromacs/top
#GROMACS EXECUTABLES
export GROMPP=/modfac/apps/gromacs-4.6.7_gcc-generic/bin/grompp_d
export MDRUN=/modfac/apps/gromacs-4.6.7_gcc-generic/bin/mdrun_d

export LAMBDANR=X

#ENERGY MINIMIZATION
$GROMPP -f minimize.${LAMBDANR}.mdp -c morph.gro -n index.ndx -o minimize.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm minimize.${LAMBDANR}

#CONSTANT VOLUME EQUILIBRATION
$GROMPP -f equil_nvt.${LAMBDANR}.mdp -c minimize.${LAMBDANR}.gro -n index.ndx -o equil_nvt.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm equil_nvt.${LAMBDANR}

#CONSTANT PRESSURE EQUILIBRATION 1
$GROMPP -f equil_npt.${LAMBDANR}.mdp -c equil_nvt.${LAMBDANR}.gro -n index.ndx -o equil_npt.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm equil_npt.${LAMBDANR}

#CONSTANT PRESSURE EQUILIBRATION WITH PARRINELLO-RAHMAN
$GROMPP -f equil_npt2.${LAMBDANR}.mdp -c equil_npt.${LAMBDANR}.gro -n index.ndx -o equil_npt2.${LAMBDANR}.tpr -p morph.top
srun $MDRUN -deffnm equil_npt2.${LAMBDANR}

#PRODUCTION STAGE
$GROMPP -f prod.${LAMBDANR}.mdp -c equil_npt2.${LAMBDANR}.gro -n index.ndx -o prod.${LAMBDANR}.tpr -p morph.top 
srun $MDRUN -deffnm prod.${LAMBDANR}

echo Job Done
#-----------------------------------------------------------------------------------
}

slurm_info_out(){
# Informational output
echo "=================================== SLURM JOB ==================================="
date
echo
echo "The job will be started on the following node(s):"
echo $SLURM_JOB_NODELIST
echo
echo "Slurm User:         $SLURM_JOB_USER"
echo "Run Directory:      $(pwd)"
echo "Job ID:             $SLURM_JOB_ID"
echo "Job Name:           $SLURM_JOB_NAME"
echo "Partition:          $SLURM_JOB_PARTITION"
echo "Number of nodes:    $SLURM_JOB_NUM_NODES"
echo "Number of tasks:    $SLURM_NTASKS"
echo "Submitted From:     $SLURM_SUBMIT_HOST:$SLURM_SUBMIT_DIR"
echo "=================================== SLURM JOB ==================================="
echo
echo "--- SLURM job-script output ---"
}

slurm_info_out

slurm_startjob

#
# End file.
#

