:- dynamic(kb/1).

% Given 
% Reads in the file and creates the knowledge base
makeKB(File) :- open(File,read,Str),
                readK(Str,K),
                reformat(K,KB),
                asserta(kb(KB)),
                close(Str). 

% Given
readK(Stream,[]):- at_end_of_stream(Stream),!.
readK(Stream,[X|L]):- read(Stream,X),
                      readK(Stream,L).

% Given
reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H,B)|L],[[H|BL]|R]) :- !,
                                    mkList(B,BL),
                                    reformat(L,R).
reformat([A|L],[[A]|R]) :- reformat(L,R).

% Given
mkList((X,T),[X|R]):- !, mkList(T,R).
mkList(X,[X]).

% Given
initKB(File) :- retractall(kb(_)), makeKB(File).

% Given
astar(Node,Path,Cost) :- kb(KB), astar(Node,Path,Cost,KB).