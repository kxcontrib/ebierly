gp_census:delete from enlist`gen`fit`tree`depth`hit!()
gp_bestof:update best:(),avfit:(),avdepth:(),diverse:()from select by seed:0N,run:0N,gen from gp_census

UNBOUNDED:(0n;0w)               / closure on fns set for %,log 0. p.82
DEPTH:7                         / length of the longest nonbacktracking path from the root to an endpoint. p.92
CROSSDEPTH:18                   / max depth of offspring. p.104
TOURNPOOL:7                     / size of competition for probablistic pressure. p.605

setConstant:{$[type x;x;enlist first[x][]]}

/ genoType[DEPTH;first 1?Model`fns]
genoType:{[depth;token]
 if[token in Model`terms;:setConstant enlist token];
 if[0>=depth-:1;:setConstant 1?Model`terms];
 token,genoType[depth]each(first where Arity=token)?raze Model`fns`terms}

/ retain only paths to enlisted elements to prevent type errors on crossover
pointPaths:{
 p:{$[0>type x;1#();raze til[count x],/:'.z.s each x]}x;
 n:(`$string x ./:p)in Model`fns;
 p:@[p;where 0=last each p;-1_];
 `points`nodes`terms!(p;p where n;p where not n)}

phenoType:{
 e:enlist x;
 first ./[e;pointPaths[e]`terms;first]}

maxDepth:{$[0>type x;0;1+max maxDepth each x]}

/ duplicate individuals in initial generation are unproductive deadwood. p.93
seedRandom:{
 while[Model[`size]>count gp_census;
  /0N!count gp_census;
  s:genoType[DEPTH;first 1?Model`fns];
  d:maxDepth s;
  if[(d>1)&first not s in exec tree from gp_census;
   f:phenoType s;
   e:Model[`fit]f;
   if[not(any UNBOUNDED in e)|e~();
    h:Model[`hit]e;
    `gp_census upsert(0;sum e;s;d;h)
   ]
  ]
 ]}

/ if descendant fails constraints return parent back for next generation
meetSwap:{[generation]
 p0:1#select from gp_census where i in neg[TOURNPOOL]?Model[`size],fit=min fit;
 p1:1#select from gp_census where i in neg[TOURNPOOL]?Model[`size],fit=min fit;
 a:exec tree from p0;
 b:exec tree from p1;
 i:first 1?pointPaths[a]`points;
 j:first 1?pointPaths[b]`points;
 c:first .[a;i;:;b . j];
 d:maxDepth c;
 if[k:(d>1)&d<=CROSSDEPTH;
  f:phenoType c;
  e:Model[`fit]f;
  if[k:not(any UNBOUNDED in e)|e~();
    h:Model[`hit]e;
    `gp_census upsert(generation;sum e;c;d;h)
  ]
 ];
 if[not k;`gp_census upsert update gen:generation from p0];
 c:first .[b;j;:;a . i];
 d:maxDepth c;
 if[k:(d>1)&d<=CROSSDEPTH;
  f:phenoType c;
  e:Model[`fit]f;
  if[k:not(any UNBOUNDED in e)|e~();
    h:Model[`hit]e;
    `gp_census upsert(generation;sum e;c;d;h)
  ]
 ];
 if[not k;`gp_census upsert update gen:generation from p1]}

/ exit generation run of hit
generNation:{[seed]
 g:0;
 r:exec sum differ seed from gp_bestof;
 b:.z.T;
 do[Model`gens;
  s:select best:min fit,avfit:avg fit,avdepth:avg depth,diverse:(count distinct tree)%Model`size by gen from gp_census;
  `gp_bestof upsert lj/[(select by seed,run:r,gen from gp_census where gen=g,fit=min fit;s)];
  show(first each flip 0!s),`seed`run`gen`hits`elapsed`!(seed;r;g;exec sum hit from gp_bestof;"t"$.z.T-b;`);
  g+:1;
  do[Model`breed;
   meetSwap g;
   if[exec max hit from -2#gp_census;
     s:select best:min fit,avfit:avg fit,avdepth:avg depth,diverse:(count distinct tree)%Model`size by gen from gp_census;
    `gp_bestof upsert lj/[(select by seed,run:r,gen from gp_census where gen=g,hit;s)];
    :show exec from 0!gp_bestof where hit
   ]
  ];
  `gp_bestof upsert lj/[(select by seed,run:r,gen from gp_census where gen=g,fit=min fit;s)];
  `gp_census set select from gp_census where gen=g
 ]}

runModel:{[seed]
 b:.z.T;
 system"S ",string seed;
 delete from`gp_census;
 seedRandom[];
 generNation seed;
 -1"";"t"$.z.T-b}

\

preQfix:{./[x;reverse pointPaths[x]`nodes;{$[()~a:(-1_raze over string[1_x],'";");string[x 0];string[x 0],"[",a,"]"]}]}

t:first exec tree from gp_bestof where hit
e:phenoType enlist t
t~phenoType parse raze preQfix e

15 bracket paren limit on q parser
q)(((((((((((((((())))))))))))))))
'(
no such limit on parse trees made with recursive genoType
