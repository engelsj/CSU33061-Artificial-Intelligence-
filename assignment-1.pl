/* This assignment asks you to apply the A* search algorithm to the processing of
propositional Prolog knowledge bases such as
q:- a,b.
q:- c.
a:- f.
c:- b.
c:- d,e,f.
d:- e.
e.
f:- e,d.
*/

search([Node|_]) :- goal(Node).
search([Node|More]) :- findall(X,arc(Node,X),Children),
add-to-frontier(Children,More,New),
search(New).

makeKB(File):- open(File,read,Str), readK(Str,K), reformat(K,KB), asserta(kb(KB)), close(Str).

readK(Stream,[]):- at_end_of_stream(Stream),!.
readK(Stream,[X|L]):- read(Stream,X),
readK(Stream,L).

reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H,B)|L],[[H|BL]|R]) :- !, mkList(B,BL), reformat(L,R).
reformat([A|L],[[A]|R]) :- reformat(L,R).

mkList((X,T),[X|R]) :- !, mkList(T,R).
mkList(X,[X]).

initKB(File) :- retractall(kb(_)), makeKB(File).
astar(Node,Path,Cost) :- kb(KB), astar(Node,Path,Cost,KB).

% astar(Node,Path,Cost,KB) :- ???