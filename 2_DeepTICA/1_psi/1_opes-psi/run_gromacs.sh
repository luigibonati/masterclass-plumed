#!/bin/bash

sp="../../scripts" #scripts path

### compulsory ###
ncore=1
tprfile=input.tpr
gmx=`which gmx_mpi`

### optional ###
nsteps=$[500*1000*5000] #last is ns
ntomp=1
maxh="" #h:min
filename=alanine
plumedfile=plumed.dat
extra_cmd=""

### setup ###
[ -z "$filename" ]  && filename=simulation
outfile=${filename}.out
[ -z "$plumedfile" ] || plumedfile="-plumed $plumedfile"
[ -z "$ntomp" ] || ntomp="-ntomp $ntomp"
[ -z "$nsteps" ] || nsteps="-nsteps $nsteps"
if [ ! -z "$maxh" ]
then
  maxh=`python <<< "print('%g'%(${maxh%:*}+${maxh#*:}/60))"`
  maxh="-maxh $maxh"
fi

### commands ###
mpi_cmd="$gmx mdrun -s $tprfile -deffnm $filename $plumedfile $ntomp $nsteps $maxh"
submit="time mpirun -np $ncore ${mpi_cmd} -pin off" #change this when submitting to a cluster

### execute ###
#$sp/bck.meup.sh -i $outfile
#$sp/bck.meup.sh -i ${filename}* > $outfile
echo -e "\n$submit &>> $outfile"
eval "$submit &>> $outfile"
[ -z "$extra_cmd" ] || eval $extra_cmd

