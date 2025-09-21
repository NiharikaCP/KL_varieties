This github repository contains Macaulay2 files supplementary to the upcoming arxiv release, "Torus Actions on Matrix Schubert and Kazhdan-Lusztig Varieties; and Links to Statistical Models" by Elke Neuhaus, Niharika Paul, and Irem Portakal. We include two files, each containing multiple functions. Below, we list the contents of the two files, referring to definitions and sections in the paper, as needed. 

MatrixSchubert.m2: each function in the list below takes a permutation, w, in one line notation as an input. 
1. NorthWest - finds the northwest (NW) set associated to the permutation w. This is the analogue of the SW set, as defined in Definition 3.7. We have to use the northwest set, instead of the southwest set, as this is the convention set in previous iterations of the MatrixSchubert package in Macaulay2. The NW set is then provided as a list of coordinates, corresponding to its elements.
2. dominantpiece - finds the dominant piece of w, as defined in Definition 3.7. Again, this is with respect to the northwest convention of the Rothe diagram. The dominant piece is given as a list of relevant coordinates.
3. dimY - finds the dimension of the affine variety Y_w, where Y_w is as defined in Section 3.2, page 3. The dimension is computed as in Section 3.2, page 4. The output of this function is an integer number. 
4. dimWeightConeMS - finds the dimension of the weight cone of the usual torus action on the matrix Schubert variety, where the weight cone and its dimension are just as explained in Section 3.2, page 4. The output is again an integer. 
5. complexityMS - computes the complexity of the matrix Schubert variety under the usual torus action. This again follows the ecposition in Section 3.2. The output of this function is an integer. 


Kazhdan Lusztig: each function in the list below takes two permutations, v and w, both in the same symmetry group S_n, in one line notation as inputs.
1. KLideal - gives the generators of the Kazhdan Lusztig (KL) ideal of v and w. The KL ideal is defined in Definition 4.4 and the generators are fixed by Proposition 4.6. The output of this function is a list of polynomial generators. 
2. dimWeightConeKL - computes the dimension of the weight cone of the two permutations, with respect to the usual torus action. The weight cone is defined in Section 4.3, page 12, as is the method used to compute its dimension. The output of this function is an integer. 
3. complexityKL - computes the complexity of the Kazhdan Lusztig variety for two permutations in one-line notation under the usual torus action. The notion of complexity of the KL variety is defined in Section 4.3, page 12. The output of this function is an integer. 
