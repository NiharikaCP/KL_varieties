loadPackage "MatrixSchubert"

-----------------------
---MATRIX SCHUBERT-----
-----------------------

--North-West Component:
NorthWest =  w->(
n = #w;
D := rotheDiagram w;
NW = D;
for pair in D do (
    a := pair#0;
    b := pair#1;
    for i from 1 to a do (
        for j from 1 to b do (
            NW = append(NW, (i, j))
        );
    );
);
unique NW
)

--dominant piece:
dominantpiece = w -> (
    D = rotheDiagram w;

    dom = select(D, p -> (p#0 == 1 or p#1 == 1));
    frontier = dom;
    while not frontier === {} do (
        newFrontier = {};
        for p in frontier do (
            i = p#0;
            j = p#1;
            for q in {(i+1,j), (i,j+1)} do (
                if member(q, D) and not member(q, dom) then (
                    dom = append(dom, q);
                    newFrontier = append(newFrontier, q);
                )
            )
        );
        frontier = newFrontier;
    );
    unique dom
);


--Dimension of L':
dimY = w -> (
D := rotheDiagram w;
#NorthWest(w) - #D 
)


--dimension of weight cone:
dimWeightConeMS = w -> (
n = #w;
D := rotheDiagram w;
N := NorthWest w;
d := dominantpiece w;

setL = set N - set d;
L = toList setL;
A = set apply(L, x -> x#0);
B = set apply(L, x -> x#1);
edgeList = apply(L, x -> {
    "a" | toString(x#0),
    "b" | toString(x#1)
});
G = graph(edgeList, EntryMode => "edges");
c = numberOfComponents G;
v = #A+#B;
v-c
)

--complexity:
complexityMS = w -> (
dimY w - dimWeightConeMS w
)

--Example:
w = {6,5,4,8,2,1,3,7};

NorthWest w
dominantpiece w
dimY w
dimWeightConeMS w
complexityMS w


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

