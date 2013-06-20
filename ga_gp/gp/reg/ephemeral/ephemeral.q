/
Koza Genetic Programming p.242
symbolic regression with constant creation
discover the "unknown" equation with constants
http://books.google.com/books?id=Bhtxo60BV0EC&dq=data+minig+and+gentic+programming&printsec=frontcover&source=in&hl=en&sa=X&oi=book_result&resnum=11&ct=result#PPA242,M1
\

/ number of points for X
SAMPLE:20

\l ../reg.q

Y:{(2.718*x xexp 2)+3.1416*x}X

/ ephemeral random constant terminal
ERC:{rand[1.]*1 -1 rand 2}

Model[`terms]:(`X;ERC)

runModel 499

-1"";

\c 25 125
show phenoType first exec tree from gp_bestof where hit

-1"";
-1"to see steps to the solution type the browseStep command below into your q console";
-1"requires internet connection for use of google gadget";
-1"browseStep 499";

