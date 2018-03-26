### How to run simulations

#### Relative Free Energy simulations
Relative free energy simulations require the use of an GROMACS' index file `.idx`. You can generate one in GROMACS 4.6.7 by using:

``` make_ndx -f <path_to_grofile> ```

The index file is used to tag the molecule for the Free Energy calculation according to the labels given at the `.mdp` option `energygrps`:

``` energygrps = LIG SOL```

Relative transformations are usually run according to the following sequence:

1. Minimization stage:
(a) This step prepares the simulation and returns warnings or error messages if something is missing or was set up in a wrong way.

``` grompp -f minimize.${LAMBDA}.mdp -o minimize.${LAMBDA}.tpr -c <path_to_grofile> -p <path_to_topfile> -n <path_to_idxfile>```

(b) This step runs the calculation:

``` mdrun -deffnm minimize.${LAMBDA}```

The minimization stage produces an output file named `minimize.${LAMBDA}.gro` which contains the minimized coordinates of your system and will be used as input for the first equilibration stage.


2. NVT Equilibration stage
(a) Simulation prep:

``` grompp -f equil_nvt.${LAMBDA}.mdp -o equil_nvt.${LAMBDA}.tpr -c minimize.${LAMBDA}.gro -p <path_to_topfile> -n <path_to_idxfile>```

(b) This step runs the first equilibration stage:

``` mdrun -deffnm equil_nvt.${LAMBDA}```

3. NPT Equilibration stage (Berendsen barostat)
(a) Simulation prep:

``` grompp -f equil_npt.${LAMBDA}.mdp -o equil_npt.${LAMBDA}.tpr -c equil_nvt.${LAMBDA}.gro -p <path_to_topfile> -n <path_to_idxfile>```

(b) Run second equilibration stage:

``` mdrun -deffnm equil_npt.${LAMBDA}```

4. NPT Equilibration stage (Parrinello-Rahman barostat)
We add a second pressure equilibration stage using the Parrinello-Rahman barostat because it allows the simulation box to change to a more stable shape under the simulation's conditions.
(a) Simulation prep:

``` grompp -f equil_npt2.${LAMBDA}.mdp -o equil_npt2.${LAMBDA}.tpr -c equil_npt.${LAMBDA}.gro -p <path_to_topfile> -n <path_to_idxfile>```

(b) Run second equilibration stage:

``` mdrun -deffnm equil_npt2.${LAMBDA}```

5. Production stage
(a) Simulation prep:

``` grompp -f prod.${LAMBDA}.mdp -o prod.${LAMBDA}.tpr -c equil_npt2.${LAMBDA}.gro -p <path_to_topfile> -n <path_to_idxfile>```

(b) Run second equilibration stage:

``` mdrun -deffnm prod.${LAMBDA}```

##### Observations:
* `${LAMBDA}` corresponds to a position in the arrays defined by the options `fep_lambdas`, `vdw_lambdas` and `mass_lambdas`. `${LAMBDA}` defines number of the window, i.e., the state along the free energy calculation path.
* The character `X` in file names need to be substituted by a number corresponding to the state at which the simulation will be run --`${LAMBDA}`-- and should be the same value as the character `XXX` in the `.mdp` file:

``` init_lambda_state        = XXX```

* `forwards` transformations correspond to relative transformations in which the ligand becomes a smaller molecule at the end of the process.
* `backwards` transformations correspond to relative transformations in which the ligand becomes a larger molecule at the end of the process.
* `fileManager.py` contains a small example of how to fill `.mdp` files and `.sh` scripts that you might use. Small tweaks are likely to be necessary to reproduce in your machine.

#### Absolute Free Energy simulations
They should be run and prepared in the same way as relative free energy calculations. Differences betweent the protocols can be spotted in the following lines in the `.mdp` files:

```couple-moltype           = LIG```

```couple-lambda0           = vdw-q```

```couple-lambda1           = none```

* `couple_moltype`  is used in absolute free energy calculations to tag the molecule that will be coupled/decoupled from the system.
* `couple-lambda0` and `couple-lambda1` control the interactions between the tagged molecule and its surroundings. In the example above, the ligand `LIG` is fully coupled to its surroundings by van der Waals forces and electrostatic interactions in the initial state, and completely decoupled from the solvent in the final state.
* Absolute free energy calculations do not need `.idx` files.

