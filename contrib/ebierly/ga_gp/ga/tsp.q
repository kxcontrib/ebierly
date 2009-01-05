\c 25 100

XY:
 (41 94;
  28 94;
  14 98;
   2 99;
   4 86;
   2 76;
   7 64;
  14 66;
  25 62;
  22 60;
  18 54;
  11 50;
   4 50;
   9 42;
  13 40;
  24 42;
  25 38;
  36 38;
  44 35;
  41 26;
  45 21;
  52 29;
  58 35;
  62 32;
  70 24;
  74 12;
  82  7;
  88 14;
  92 24;
  91 38)

POPSIZE:500
TOURNPOOL:10
GENS:35

DS:XY{sqrt((x[0]-y 0)xexp 2)+(x[1]-y 1)xexp 2}\:/:XY                    / calculate distance matrix from XY coordinates

tsp:{
 p:{neg[y]?/:x#y}[POPSIZE;count XY];                                    / initial population as randomn order of cities
 g:0;
 do[GENS;                                                               / generation
  t:min f:{sum DS ./:x,'1 rotate x}each p;
  b:p first f?t;
  show`generation`top_score`best_order`!(g;t;b;`);
  n:();                                                                 / new bucket for next gen parents
  do[POPSIZE;
   j:{x,'1 rotate x}p i first where 0=rank f i:neg[TOURNPOOL]?POPSIZE;  / select parents
   k:{x,'1 rotate x}p i first where 0=rank f i:neg[TOURNPOOL]?POPSIZE;
   e:distinct{x rank x}each j,k;                                        / edge map has all connects into and out of a city
   s:distinct raze e;                                                   / used for orphan left on final edge
   o:();                                                                / offspring
   while[count e;
    c:floor .5*group raze e;
    i:key 1#asc count each c;
    o,:i;
    e@:key[count e]except first c i                                     / take city with fewest edges and remove
   ];
   n,:enlist o union s                                                  / collect new offspring for next population
  ];
  p:n;
  g+:1
 ]}

\t tsp[]

\

optimal solution is til 30
