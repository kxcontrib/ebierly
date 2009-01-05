\l ../../gp.q

reSet:{
 get"\\x .z.vs";

 FACES::">v<^";
 FACE::">";
 STEP::0;

 T::T_;

 TRAIL::ssr[;"0";"."]each raze each string T;
 TRAIL[0;0]::FACE;

 MAXHIT::sum over T;
 ROWS::til count T;
 COLS::til count flip T;
 ROW::0;
 COL::0;
 FOUND::0;

 .z.vs:{[x;y]if[x in`ROW`COL;FOUND+:T[ROW;COL];T[ROW;COL]:0];if[x in`ROW`COL`FACE;STEP+:1;TRAIL[ROW;COL]:FACE]}}

reSet[]

Arity:2 3 2!`prog2`prog3`ifFood
Model:`fns`terms`size`gens`fit`hit`breed!(value Arity;`move`left`right;500;65;{reSet[];while[(STEP<STEPS)&MAXHIT>FOUND;eval x];MAXHIT-FOUND};{(MAXHIT=FOUND)&STEP<=STEPS};250)

prog2:{x[];y[]}

prog3:{x[];y[];z[]}

foodAhead:{
 $[FACE~">";:T[ROW;first 1 rotate COLS];
   FACE~"v";:T[first 1 rotate ROWS;COL];
   FACE~"<";:T[ROW;first -1 rotate COLS];
   FACE~"^";:T[first -1 rotate ROWS;COL]
  ];}

ifFood:{$[foodAhead[];x[];y[]]}

/ terminals defined
move:{
 $[FACE~">";COL::first COLS::1 rotate COLS;
   FACE~"v";ROW::first ROWS::1 rotate ROWS;
   FACE~"<";COL::first COLS::-1 rotate COLS;
   FACE~"^";ROW::first ROWS::-1 rotate ROWS
  ];}

left:{FACE::first FACES::-1 rotate FACES}

right:{FACE::first FACES::1 rotate FACES}

browseStep:{[hitseed]
 t:phenoType first exec tree from gp_bestof where hit,seed=hitseed;
 if[not count t;:()];
 d:-3!'t;
 h:("<html>";"<head>";"<META HTTP-EQUIV=\"refresh\" CONTENT=\"1\">";"</head>";"<body>";"<pre>");
 f:("</pre>";"</body>";"</html>");
 ITERATION::0;
 reSet[];
 s:" "sv'flip(string;string value each)@\:`ITERATION`FOUND`STEP;
 r:raze(h;s;enlist"  ";ssr[;">";"&#062;"]each ssr[;"<";"&#060;"]each TRAIL;enlist"  ";d;f);
 while[-11h<>type .[0:;(`:TRAIL.html;r);-1]];
 -1"Reopen the file ",ssr[system"cd";"\\";"/"],"/TRAIL.html in a browser";
 -1"Then hit Enter here to iterate through the solution until you see the q) prompt";
 while[(STEP<STEPS)&MAXHIT>FOUND;
  read0 0;
  eval t;
  0N!ITERATION+:1;
  s:" "sv'flip(string;string value each)@\:`ITERATION`FOUND`STEP;
  r:raze(h;s;enlist"  ";ssr[;">";"&#062;"]each ssr[;"<";"&#060;"]each TRAIL;enlist"  ";d;f);
  while[-11h<>type .[0:;(`:TRAIL.html;r);-1]];
 ];
 h:("<html>";"<head>";"</head>";"<body>";"<pre>");
 r:raze(h;s;enlist"  ";ssr[;">";"&#062;"]each ssr[;"<";"&#060;"]each TRAIL;enlist"  ";d;f);
 while[-11h<>type .[0:;(`:TRAIL.html;r);-1]];}
