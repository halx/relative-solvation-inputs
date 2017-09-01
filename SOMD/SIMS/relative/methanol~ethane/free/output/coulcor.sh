#!/bin/bash

cp FUNC_0.py  lambda-0.0000/.

cd lambda-0.0000
~/sire.app/bin/python  FUNC_0.py 1> ../freenrg-COULCOR-lam-0.0000.dat 2> /dev/null
cd ..
wait

cd lambda-1.0000
~/sire.app/bin/python FUNC_1.py 1> ../freenrg-COULCOR-lam-1.0000.dat 2>/dev/null
cd ../
wait

