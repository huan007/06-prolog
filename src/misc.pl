%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helpers

%isin(X,L) is true if X appears in L
isin(X,[X|_]).
isin(X,[_|T]) :- isin(X,T).

%hint: use append, reverse, bagof judiciously.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Rules

%zip(L1,L2,L3) :- throw(to_be_done).
zip([],[],[]).
zip([A|AList],[B|BList],[C,D|CList]) :- A=C,B=D,zip(AList, BList, CList).

%assoc(L,X,Y) :- throw(to_be_done). 
assoc([[Key,Value]|Rest],X,Y) :- (X=Key,Y=Value);assoc(Rest,X,Y).

%remove_duplicates(L1,L2) :- throw(to_be_done). 
remove_duplicates([],[]).
remove_duplicates([A|AList],[B|BList]) :- A=B, delete(AList, A, NewList), remove_duplicates((NewList), BList).

%union(L1,L2,L3) :- throw(to_be_done). 
union(L1,L2,L3) :- append(L1,L2,L1ANDL2), remove_duplicates(L1ANDL2, NODUP), listEqual(NODUP, L3).

listEqual([],[]).
listEqual([A|AList], [B|BList]) :- A = B, listEqual(AList,BList).

%intersection(L1,L2,L3) :- 

interHelper([],[],[]).
%%interHelper([A|AList], [B|BList], [C|CList]) :- 
%interHelper([],[],[]).
%interHelper([],X,X).
%interHelper(X,[],X).
%interHelper(X,X,X).
%interHelper([A|AList],BList,CList) :- (member(A,BList), member(A,CList)),interHelper(AList, BList, CList).
%interHelper([A|AList],BList,CList) :- (not(member(A,BList)),not(member(A,CList))), interHelper(AList, BList, CList).

intersection(AList,BList,CList) :- remove_duplicates(AList, AINNO)
								, remove_duplicates(BList, BINNO)
								, append(AINNO, BINNO, CONCAT)
								, union(AINNO, BINNO, UNION)
								, removeHelper(UNION, CONCAT, CList).


%removeFirst(_,[],[]).
%removeFirst(A, [A|Tail], Tail).
%removeFirst(A, [B|Tail], [B,BTail]) :- A \= B, removeFirst(A,Tail,BTail).

removeHelper([],X,X).
removeHelper([A|ATail], BList, Result) :- removeFirstOccur(A, BList, BLess), removeHelper(ATail, BLess, Result).
removeFirstOccur(_,[],[]).
removeFirstOccur(A,[A|Tail],Tail).
removeFirstOccur(A,[B|Tail],[B|BTail]) :-  A \= B, removeFirstOccur(A,Tail,BTail).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2: Facts

cost(carne_asada,3).
cost(lengua,2).
cost(birria,2).
cost(carnitas,2).
cost(adobado,2).
cost(al_pastor,2).
cost(guacamole,1).
cost(rice,1).
cost(beans,1).
cost(salsa,1).
cost(cheese,1).
cost(sour_cream,1).
cost(taco,1).
cost(tortilla,1).
cost(sopa,1).


ingredients(carnitas_taco, [taco,carnitas, salsa, guacamole]).
ingredients(birria_taco, [taco,birria, salsa, guacamole]).
ingredients(al_pastor_taco, [taco,al_pastor, salsa, guacamole, cheese]).
ingredients(guacamole_taco, [taco,guacamole, salsa,sour_cream]).
ingredients(al_pastor_burrito, [tortilla,al_pastor, salsa]).
ingredients(carne_asada_burrito, [tortilla,carne_asada, guacamole, rice, beans]).
ingredients(adobado_burrito, [tortilla,adobado, guacamole, rice, beans]).
ingredients(carnitas_sopa, [sopa,carnitas, guacamole, salsa,sour_cream]).
ingredients(lengua_sopa, [sopa,lengua,beans,sour_cream]).
ingredients(combo_plate, [al_pastor, carne_asada,rice, tortilla, beans, salsa, guacamole, cheese]).
ingredients(adobado_plate, [adobado, guacamole, rice, tortilla, beans, cheese]).

taqueria(el_cuervo, [ana,juan,maria], 
        [carnitas_taco, combo_plate, al_pastor_taco, carne_asada_burrito]).

taqueria(la_posta, 
        [victor,maria,carla], [birria_taco, adobado_burrito, carnitas_sopa, combo_plate, adobado_plate]).

taqueria(robertos, [hector,carlos,miguel],
        [adobado_plate, guacamole_taco, al_pastor_burrito, carnitas_taco, carne_asada_burrito]).

taqueria(la_milpas_quatros, [jiminez, martin, antonio, miguel],  
        [lengua_sopa, adobado_plate, combo_plate]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2: Rules

%available_at(X,L) :- throw(to_be_done).
available_at(X,L) :- taqueria(L, EmpList, MenuList), member(X, MenuList).

%multi_available(X) :- throw(to_be_done). 
multi_available(X) :- taqueria(L, EmpList, MenuList)
					, member(X, MenuList)
					, taqueria(L1, EmpList1, MenuList1)
					, member(X, MenuList1)
					, L \= L1.

%overworked(X) :- throw(to_be_done). 
overworked(X) :-      taqueria(L, EmpList, MenuList)
					, member(X, EmpList)
					, taqueria(L1, EmpList1, MenuList1)
					, member(X, EmpList1)
					, L \= L1.

%total_cost(X,K) :- throw(to_be_done). 
total_cost(X,K) :- 	  ingredients(X, Z)
					, listCost(Z, K).

listCost([],0).
listCost([X|Xs],Cost) :-  cost(X, ItemCost)
						, listCost(Xs, RestCost)
						, Cost is ItemCost + RestCost.

%has_ingredients(X,Is) :- throw(to_be_done).
has_ingredients(X, Is) :- ingredients(X, XIs)
						, intersection(XIs, Is, InterMilan)
						, listEqual(Is, InterMilan).

avoids_ingredients(X,Is) :- throw(to_be_done). 

p1(L,X) :- throw(to_be_done). 

p2(L,Y) :- throw(to_be_done). 

find_items(L,X,Y) :- p1(L1,X),p2(L2,Y),intersection(L1,L2,L).  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
