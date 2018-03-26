#!/usr/bin/env python

import os, glob

def create_mdp(num):
    """ Replicates mdp files for each lambda value.
        
        VARIABLE        I/O         Type        Description
        ----------------------------------------------------------------------------
        num            input        integer     number of replicas
        
        """
    files = glob.glob("*.X.mdp")
    for elem in files:
        f = elem
        file  = open(f, 'r')
        s = file.read()
        N = num # Number of different states to be calculated
        for i in range(N):
            of = f.replace('X', str(i))
            oss = s.replace('XXX', str(i))
            with open(of, 'w') as outputfile:
                outputfile.write(oss)


def create_running_scripts(num, name='example'):
    """ Fixes LAMBDANR on run scripts and changes the Job name in the running script
        
        VARIABLE        I/O         Type        Description
        ----------------------------------------------------------------------------
        name            input       string      name of the sh script (before .X.sh)
        num             input       integer     number of files to be created
        
        """
    os.system('cp {}.X.sh {}.0.sh'.format(name,name))
    ideal_number = num
    for number in range(ideal_number):
        if not os.path.isfile('{}.{}.sh'.format(name,number)):
            os.system('cp {}.0.sh {}.{}.sh'.format(name, name, number))
    return


def fix_lambdas_and_names(name='relative', files="*.sh"):
    """ Fixes LAMBDANR on run scripts and changes the Job name in the running script
        
        VARIABLE        I/O         Type        Description
        ----------------------------------------------------------------------------
        name            input       string      name to be given to the job
        files           input       string      file extension
        
        """
    discrepancy = 'export LAMBDANR'
    job_name = '#SBATCH --job-name='
    run_files = glob.glob(files)
    for filename in run_files:
        f = open(filename, "r")
        name_lambdas = filename.split(".")[1]
        lines = f.readlines()
        f.close()
        new_lines = []
        for line in lines:
            if discrepancy in line:
                file_lambdas = line.split()[-1].split("=")[-1]
                if file_lambdas != name_lambdas:
                    new_line = line.replace(file_lambdas, name_lambdas)
                    new_lines.append(new_line)
                else:
                    new_lines.append(line)
            elif job_name in line:
                replacement = '#SBATCH --job-name="{}_{}"\n'.format(name, name_lambdas)
                new_lines.append(replacement)
            else:
                new_lines.append(line)
        f2 = open(filename, "w")
        f2.writelines(new_lines)
        f2.close()
    return


# Example
num_states = 31

#copy_mdp(num_states)
create_running_scripts(num_states)
fix_lambdas_and_names()
