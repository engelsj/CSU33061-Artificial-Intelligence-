:- dynamic(kb/1).

% Given 
makeKB(File) :- open(File,read,Str),
                readK(Str,K),
                reformat(K,KB),
                asserta(kb(KB)),
                close(Str). 

readK(Stream,[]):- at_end_of_stream(Stream),!.
readK(Stream,[X|L]):- read(Stream,X),
                      readK(Stream,L).

reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H,B)|L],[[H|BL]|R]) :- !,
                                    mkList(B,BL),
                                    reformat(L,R).
reformat([A|L],[[A]|R]) :- reformat(L,R).

mkList((X,T),[X|R]):- !, mkList(T,R).
mkList(X,[X]).

initKB(File) :- retractall(kb(_)), makeKB(File).

less-than([[Node1|_],Cost1],[[Node2|_],Cost2]) :- heuristic(Node1,Hvalue1), heuristic(Node2,Hvalue2),
                                                  F1 is Cost1+Hvalue1, F2 is Cost2+Hvalue2,
                                                  F1 =< F2.



heuristic(Node, Heuristic) :- length(Node, Heuristic).
arc([H|T],Node,Cost,KB) :- member([H|B],KB), append(B,T,Node),
                           length(B,L), Cost is L+1.

goal([]). 

astar(Node,Path,Cost) :- kb(KB), astar(Node,Path,Cost,KB).

% Written Work 

astar(Node,Path,Cost,KB) :- search([[Node,0,[Node]]], Path, Cost, KB).


search([[Node,CurrentValue,Path]|_],CurrentPath,CurrentCost,_) :- goal(Node),CurrentPath=Path,CurrentCost=CurrentValue.
search([[Node,CurrentValue,Path]|T],CurrentPath,CurrentCost,KB) :- findall([X,NewCost,[X|Path]],
                                                                   (arc(Node,X,ArcCost,KB),NewCost is ArcCost+CurrentValue),
                                                                   Children),
                                                                   add_to_frontier(Children,T,New), search(New, CurrentPath,CurrentCost,KB).
add_to_frontier([],Value,Value).
add_to_frontier([H|T], Value, New) :- insert_sort([H|Value], Sorted), add_to_frontier(T, Sorted, New).

% Edited version of insertion sort https://rosettacode.org/wiki/Sorting_algorithms/Insertion_sort#Prolog
insert_sort(L1,L2) :- insert_sort_intern(L1,[],L2).
 
insert_sort_intern([],L,L).
insert_sort_intern([H|T],L1,L) :- insert(L1,H,L2),
                                  insert_sort_intern(T,L2,L).
insert([],X,[X]). 
insert([H|T],X,[X,H|T]) :- less-than(X,H),
                           !.
insert([H|T],X,[H|T2]) :- insert(T,X,T2).





