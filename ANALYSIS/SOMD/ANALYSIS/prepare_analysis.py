#Author: Stefano Bosisio
#Script to prepare simfile.dat to be processed with alchemicaL_analysis.py for reproducibility project
#Usage:
#cd output/ (go to the ouptut directory)
#python  prepare_analysis.py


from numpy import *
import sys,os,shutil

dcdfolders = []
dcdpath = os.getcwd()
print("looking for simfile.dat files...")

#store automatically all the simfile.dat files from each lambda window
for root, dirs, files in os.walk(dcdpath):
    if "lambda" in root:
        for name in files:
            if "simfile.dat" in name:
                path = root + "/" + name
                
                dcdfolders.append(path)

#sort the lambda order
dcdfolders.sort()
#Sanity check, show which folders have been found
print("Found in these folders simfile.dat\n")
print(dcdfolders)

#now move everything to run_analysis folder, where the analysis file are contained
path_gro = os.getcwd() + "/run_analysis"
if not os.path.exists(path_gro):
    os.makedirs(path_gro)#creation of run_analysis folder wher eall the lambda will be moved to 

numb_files = len(dcdfolders) #total number of lambda windows run

for numb in range(0, numb_files):
    val = (dcdfolders[numb])
    if val.index("lambda"):
        l = val.index("lambda")  #extract the value of the lambda window
        val_split = val[l:].split("/")   #real value of lambda
        index = val_split[0].index("-")  
        lambda_val = val_split[0][(index+1):] 
        output_name = "lambda-"+str(lambda_val) +".dat" #output file name  is e.g. lambda-0.00   
        output_file = open(output_name,"w")
    else:
        print("Be careful, are you sure lambdas folders are here?")
    

    input_lambda = open(dcdfolders[numb],"r") #read the simfile.dat of lambda-X
    read_file = input_lambda.readlines()
    #this is the templated of the simfile.dat file
    index_start = read_file.index('#   [step]      [potential kcal/mol]       [gradient kcal/mol]      [forward Metropolis]     [backward Metropolis]                   [u_kl]\n') +1
    values_data = read_file[index_start:]  #copy all the values of the simfile
    time_grad = loadtxt(values_data,usecols=[0,2]) # use the columns 0(time) and 2 (gradients)
    output_file.write("# lambba_val.val %s\n" % str(lambda_val))
    output_file.write("#time (ps)      gradients (kcal/mol*lam)\n")
    elements_data = len(time_grad)
    #convert everything
    for x in range(0,elements_data-1):
        output_file.write("%.3f            %.10f\n" %(time_grad[:,0][x]*2,time_grad[:,1][x]*0.593))  #multiplication by 2 cause we have 2ps and 0.593 kcal/mol

    current_file = os.getcwd() + "/" + str(output_name)
    dest_file = path_gro + "/" + str(output_name)
    print(dest_file) #this is the final file created
    os.rename(current_file,dest_file)
    print("Files are ready to be analysed :)")
  
