version 1
molecule LIG
rigidbody rotate 3.205 translate 0.147
maximumbondvariables 5  
maximumanglevariables 5  
maximumdihedralvariables 5  
bond C1   H2   flex 0.006
bond C1   H3   flex 0.025
bond C1   H4   flex 0.025
bond C1   H5   flex 0.025
bond H2   DU6  flex 0.020
bond H2   DU9  flex 0.010
bond DU6  DU7  flex 0.020
bond DU7  DU8  flex 0.010
bond DU7  DU10 flex 0.025
bond DU8  DU9  flex 0.010
bond DU8  DU11 flex 0.025
bond DU9  DU12 flex 0.025
angle C1   H2   DU6  flex 0.025
angle C1   H2   DU9  flex 0.025
angle H2   C1   H3   flex 0.250
angle H2   C1   H4   flex 0.250
angle H2   C1   H5   flex 0.250
angle H2   DU6  DU7  flex 0.050
angle H2   DU9  DU8  flex 0.050
angle H2   DU9  DU12 flex 0.100
angle H3   C1   H4   flex 0.250
angle H3   C1   H5   flex 0.250
angle H4   C1   H5   flex 0.250
angle DU6  H2   DU9  flex 0.100
angle DU6  DU7  DU8  flex 0.100
angle DU6  DU7  DU10 flex 0.100
angle DU7  DU8  DU9  flex 0.050
angle DU7  DU8  DU11 flex 0.100
angle DU8  DU7  DU10 flex 0.100
angle DU8  DU9  DU12 flex 0.100
angle DU9  DU8  DU11 flex 0.100
dihedral C1   H2   DU6  DU7  flex 2.500
dihedral C1   H2   DU9  DU8  flex 2.500
dihedral C1   H2   DU9  DU12 flex 2.500
dihedral H2   DU6  DU7  DU8  flex 2.500
dihedral H2   DU6  DU7  DU10 flex 2.500
dihedral H2   DU9  DU8  DU7  flex 2.500
dihedral H2   DU9  DU8  DU11 flex 2.500
dihedral H3   C1   H2   DU6  flex 10.000
dihedral H3   C1   H2   DU9  flex 10.000
dihedral H4   C1   H2   DU6  flex 10.000
dihedral H4   C1   H2   DU9  flex 10.000
dihedral H5   C1   H2   DU6  flex 10.000
dihedral H5   C1   H2   DU9  flex 10.000
dihedral DU6  H2   DU9  DU8  flex 2.500
dihedral DU6  H2   DU9  DU12 flex 2.500
dihedral DU6  DU7  DU8  DU9  flex 2.500
dihedral DU6  DU7  DU8  DU11 flex 2.500
dihedral DU7  DU6  H2   DU9  flex 2.500
dihedral DU7  DU8  DU9  DU12 flex 2.500
dihedral DU9  DU8  DU7  DU10 flex 2.500
dihedral DU10 DU7  DU8  DU11 flex 2.500
dihedral DU11 DU8  DU9  DU12 flex 2.500
