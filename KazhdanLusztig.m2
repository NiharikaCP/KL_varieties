loadPackage "MatrixSchubert"

------------------------
---KAZHDAN LUSZTIG------
------------------------

--KL ideal:

KLideal = (v,w) -> (
    n = #v;
    I = schubertDeterminantalIdeal w;
    V = permToMatrix v;
    D = rotheDiagram v;
    S = delete(null, flatten apply(n, i -> apply(n, j -> if not isMember((i+1,j+1),D) then (z_(i+1,j+1) => V_(i,j)))));
    R = QQ[delete(null, flatten apply(n, i -> apply(n, j -> if isMember((i+1,j+1),D) then z_(i+1,j+1) )))];
    J = substitute(ideal flatten entries mingens substitute(substitute(I,S),R),R)
    )
 --lives in the space of z_(i,j) with (i,j) in Rothe diagram
 --this way dimension is correct

--dimension of weight cone:

dimWeightConeKL = (v,w) -> (
    NonzeroEntries = apply(flatten entries basis(1, prune quotient KLideal(v,w)), d -> last baseName d);
    edgeList = apply(NonzeroEntries, d -> {v#(d#0-1), d#1}); 
    G = graph(toList(1..n),edgeList);
    n - numberOfComponents(G)
    )

--complexity:

complexityKL = (v,w) -> (
    dimVar = permLength(v) - permLength(w);
    dimVar - dimWeightConeKL(v,w)
    )

-- Example:

v = {4,5,3,2,1};
w = {1,2,3,4,5};

KLideal(v,w)
dim KLideal(v,w) == permLength(v) - permLength(w)
dimWeightConeKL(v,w)
complexityKL(v,w)

