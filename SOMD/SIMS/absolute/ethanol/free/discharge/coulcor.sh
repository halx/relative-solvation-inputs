#!/bin/bash

cp FUNC.py  lambda-0.0000/.

cd lambda-0.0000
~/sire.app/bin/python  FUNC.py 1> ../freenrg-COULCOR.dat 2> /dev/null
cd ..
wait

