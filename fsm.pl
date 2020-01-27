% general code to show to build up of the search lecture
accept(_,Final,Q,[]) :- member(Q,Final).
accept(Trans,FInal,Q,[H|T]):- member([Q,H,Qn], Trans), accept(Trans,Final,Qn,T).

member(X,[X|_]).
member(X,[_|L]):- member(X,L).

search(Node):- goal(Node).
search(Node):- arc(Node,Next), search(Next).

goal(Q,[],Final) :- member(Q,Final).
arc([Q,[H|T]],[Qn,T],Trans) :- member([Q,H,Qn],Trans).
search(Q,S,F, ) :- goal(Q,S,F).
search(Q,S,F,T) :- arc([Q,S],[Qn,Sn],T),
search(Qn,Sn,F,T).
accept(T,F,Q,S) :- search(Q,S,F,T).

arc([H|T],N,KB) :- member([H|B],KB), append(B,T,N).

prove([], ).
prove([H|T],KB) :- member([H|B],KB), append(B,T,Next),
prove(Next,KB).