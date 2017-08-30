version 1
molecule LIG
rigidbody rotate 2.162 translate 0.125
maximumbondvariables 5  
maximumanglevariables 5  
maximumdihedralvariables 5  
bond C1   C2   flex 0.006
bond C1   H8   flex 0.025
bond C1   H9   flex 0.025
bond C1   H10  flex 0.025
bond C2   C3   flex 0.010
bond C2   C7   flex 0.010
bond C3   C4   flex 0.010
bond C3   H11  flex 0.025
bond C4   C5   flex 0.010
bond C4   H12  flex 0.025
bond C5   C6   flex 0.010
bond C5   H13  flex 0.025
bond C6   C7   flex 0.010
bond C6   H14  flex 0.025
bond C7   H15  flex 0.025
angle C1   C2   C3   flex 0.025
angle C1   C2   C7   flex 0.025
angle C2   C1   H8   flex 0.250
angle C2   C1   H9   flex 0.250
angle C2   C1   H10  flex 0.250
angle C2   C3   C4   flex 0.050
angle C2   C3   H11  flex 0.100
angle C2   C7   C6   flex 0.050
angle C2   C7   H15  flex 0.100
angle C3   C2   C7   flex 0.050
angle C3   C4   C5   flex 0.050
angle C3   C4   H12  flex 0.100
angle C4   C3   H11  flex 0.100
angle C4   C5   C6   flex 0.050
angle C4   C5   H13  flex 0.100
angle C5   C4   H12  flex 0.100
angle C5   C6   C7   flex 0.050
angle C5   C6   H14  flex 0.100
angle C6   C5   H13  flex 0.100
angle C6   C7   H15  flex 0.100
angle C7   C6   H14  flex 0.100
angle H8   C1   H9   flex 0.250
angle H8   C1   H10  flex 0.250
angle H9   C1   H10  flex 0.250
dihedral C1   C2   C3   C4   flex 2.500
dihedral C1   C2   C3   H11  flex 2.500
dihedral C1   C2   C7   C6   flex 2.500
dihedral C1   C2   C7   H15  flex 2.500
dihedral C2   C3   C4   C5   flex 2.500
dihedral C2   C3   C4   H12  flex 2.500
dihedral C2   C7   C6   C5   flex 2.500
dihedral C2   C7   C6   H14  flex 2.500
dihedral C3   C2   C1   H8   flex 10.000
dihedral C3   C2   C1   H9   flex 10.000
dihedral C3   C2   C1   H10  flex 10.000
dihedral C3   C2   C7   C6   flex 2.500
dihedral C3   C2   C7   H15  flex 2.500
dihedral C3   C4   C5   C6   flex 2.500
dihedral C3   C4   C5   H13  flex 2.500
dihedral C4   C3   C2   C7   flex 2.500
dihedral C4   C5   C6   C7   flex 2.500
dihedral C4   C5   C6   H14  flex 2.500
dihedral C5   C4   C3   H11  flex 2.500
dihedral C5   C6   C7   H15  flex 2.500
dihedral C6   C5   C4   H12  flex 2.500
dihedral C7   C2   C1   H8   flex 10.000
dihedral C7   C2   C1   H9   flex 10.000
dihedral C7   C2   C1   H10  flex 10.000
dihedral C7   C2   C3   H11  flex 2.500
dihedral C7   C6   C5   H13  flex 2.500
dihedral H11  C3   C4   H12  flex 2.500
dihedral H12  C4   C5   H13  flex 2.500
dihedral H13  C5   C6   H14  flex 2.500
dihedral H14  C6   C7   H15  flex 2.500
