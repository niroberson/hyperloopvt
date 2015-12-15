#!/bin/bash
#PBS -lwalltime=72:00:00
#PBS -lnodes=1:ppn=8
#PBS -W group_list=ithaca
#PBS -q normal_q
#PBS -A ithaca

#Load the default version of MATLAB
module load matlab

## Below here enter the commands to start your job
cd $PBS_O_WORKDIR

## Print a message:
echo "Starting MATLAB with Magnetic Levitation Simulation..."

## Start MATLAB and call the script
matlab -r mag_batch_local

exit;
