\l ../../gp.q

X:asc(SAMPLE?1.)*(1 -1)SAMPLE?2

ADD:+;SUB:-;MUL:*;DIV:%;SIN:sin;COS:cos;EXP:exp;LOG:log

Arity:2 2 2 2 1 1 1 1!(`ADD`SUB`MUL`DIV`SIN`COS`EXP`LOG)
Model:`fns`terms`size`gens`fit`hit`breed!(value Arity;enlist`X;500;60;{abs Y-eval x};{SAMPLE=sum .01>x};250)

browseStep:{[hitseed]
 if[not count select from gp_bestof where hit,seed=hitseed;:()];
 g:count select from gp_bestof where seed=hitseed;
 h:("<html>";"<head>";"<META HTTP-EQUIV=\"refresh\" CONTENT=\"1\">";"<script type=\"text/javascript\" src=\"http://www.google.com/jsapi\"></script>";"<script type=\"text/javascript\">";"google.load(\"visualization\",\"1\",{packages:[\"scatterchart\"]});";"google.setOnLoadCallback(drawChart);";"function drawChart(){";"var data=new google.visualization.DataTable();";"data.addColumn('number','X');";"data.addColumn('number','Y');";"data.addColumn('number','f');";"data.addRows(",string[count X],");");
 c:{("var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));";"chart.draw(data,{width:800,height:480,titleX:'",x,"',legend:'none',lineSize:1});}")}"{sum x xexp 4 3 2 1}each X";
 f:("</script>";"</head>";"<body>";"<div id=\"chart_div\"></div>";"</body>";"</html>");
 d:{n:count x;"data.setValue(",/:(","sv'string flip(where n#3;(n*3)#0 1 2;raze flip(x;y;z))),\:");"}[X;Y;Y];
 p:raze(h;d;c;f);
 while[-11h<>type .[0:;(`:PLOT.html;p);-1]];
 -1"Reopen the file ",ssr[system"cd";"\\";"/"],"/PLOT.html in a browser";
 -1"Then hit Enter here to iterate through the solution until you see the q) prompt";
 j:0;
 while[j<g;
  l:exec tree from gp_bestof where seed=hitseed,gen=j;
  t:phenoType first l;
  c:{("var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));";"chart.draw(data,{width:800,height:480,titleX:'",x,"',legend:'none',lineSize:1});}")}[raze -3!'t];
  read0 0;
  0N!t;
  r:eval t;
  d:{n:count x;"data.setValue(",/:(","sv'string flip(where n#3;(n*3)#0 1 2;raze flip(x;y;z))),\:");"}[X;Y;r];
  p:raze(h;d;c;f);
  while[-11h<>type .[0:;(`:PLOT.html;p);-1]];
  j+:1
 ];
 h:("<html>";"<head>";"<script type=\"text/javascript\" src=\"http://www.google.com/jsapi\"></script>";"<script type=\"text/javascript\">";"google.load(\"visualization\",\"1\",{packages:[\"scatterchart\"]});";"google.setOnLoadCallback(drawChart);";"function drawChart(){";"var data=new google.visualization.DataTable();";"data.addColumn('number','X');";"data.addColumn('number','Y');";"data.addColumn('number','f');";"data.addRows(",string[count X],");");
 p:raze(h;d;c;f);
 while[-11h<>type .[0:;(`:PLOT.html;p);-1]];}
