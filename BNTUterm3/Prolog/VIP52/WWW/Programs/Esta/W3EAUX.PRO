/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  WEBESTA
 FileName: W3EAUX.PRO
 Purpose: 
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "w3esta.inc"

CLAUSES
  ve_min(A,B,A) :- A<=B, !.
  ve_min(_,B,B).
  
  ve_max(A,B,A) :- A>=B, !.
  ve_max(_,B,B).

  repeat.
  repeat:-repeat.

  /* for (i=Min; i<=Max; i++) {  ...  };   */
  for(Min,Min,_).
  
  for(I,Min,Max) :-
    Min < Max, 
    Min1 = Min + 1, !,
    for(I,Min1,Max).

  repfile(F) :- eof(F), !, fail.
  repfile(_).
  repfile(F) :- 
    repfile(F).
  
  ve_member(X,[X|_]).
  ve_member(X,[_|T]):-ve_member(X,T).
  
  non_memb(X,[H|_]):-X=H.
  non_memb(X,[_|T]):- non_memb(X,T).
  
  index(1,[VID|_],VID)  :- !.
  index(N,[_|LIST],VID) :- N>1,N1=N-1,index(N1,LIST,VID).

PREDICATES
   list_get_index_1 (Integer,ILIST,Integer,Integer)
   list_get_index_1 (String,SLIST,Integer,Integer)
   nondeterm part (ilist,integer,ilist,ilist)
   nondeterm part (slist,string,slist,slist)
   le (integer,integer)
   le (string,string)
   gt (integer,integer)
   gt (string,string)
   nondeterm sublist_1 (SLIST,SLIST,SLIST)
   nondeterm sublist_1 (ILIST,ILIST,ILIST)
   
CLAUSES
   append ([],Xs,Xs).
   append ([X|Xs],Ys,[X|Zs]) :- append (Xs,Ys,Zs).
	
   % LOUT = L1 - L2
   sublist (L1,[],L1).
   sublist (L1,[H|T],LOUT) :- sublist_1 (L1,[H],L2),!,sublist_1(L2,T,LOUT).
		
   sublist_1 (AsXsBs,Xs,Out) :-
	append (As,XsBs,AsXsBs),
	append (Xs,Bs,XsBs),
	append (As,Bs,Out).
	
   list_get_index (Key,L,N) :- list_get_index_1 (Key,L,1,N).
   list_get_index_1 (Key,[Key|_],N,N):-!.
   list_get_index_1 (Key,[_|T],Buff,N) :-
	Buff1 = Buff+1,!,
	list_get_index_1 (Key,T,Buff1,N).

   qsort ([X|Xs],Ys) :-
	part (Xs,X,Littles,Bigs),
	qsort(Littles,Ls),
	qsort(Bigs,Bs),
	append (Ls,[X|Bs],Ys).
	qsort([],[]).
	
   part ([X|Xs],Y,[X|Ls],Bs) :- le (X,Y),part (Xs,Y,Ls,Bs).
   part ([X|Xs],Y,Ls,[X|Bs]) :- gt (X,Y),part (Xs,Y,Ls,Bs).
   part ([],_,[],[]).
	
   gt (X,Y) :- X>Y.
   le (X,Y) :- not(gt(X,Y)).

   listconc([],L,L):-!.
   listconc([X|L1],L2,[X|L3]):-
   listconc(L1,L2,L3).

/************************ STRIP **************************************/
predicates
  strip_trailing_blancs(string, string)
  strip_leading_blancs(string, string)

clauses
  strip("",""):-!.

  strip(In, Out) :-
    strip_leading_blancs(In, S),
    strip_trailing_blancs(S, Out).

  /******************* STRIP_TRAILING_BLANCS ***********************/

  strip_trailing_blancs(S1, S3) :- 
    concat(S2, " ", S1),!,
    strip_trailing_blancs(S2, S3).
  strip_trailing_blancs(S, S).


  /******************* STRIP_LEADING_BLANCS ***********************/

  strip_leading_blancs(S1, S3) :- 
    frontchar(S1, ' ', S2),!,
    strip_leading_blancs(S2, S3).
  strip_leading_blancs(S, S).

  strip_tab(S1,S2):- concat(X,"\t",S1),!,strip_tab(X,S2).
  strip_tab(S1,S2):- frontchar(S1,'\t',X),!,strip_tab(X,S2).
  strip_tab(S,S).

%================================================================
%		AVL SORT
%================================================================
PREDICATES

  nondeterm element(ID,AVLTREE)    
  inslistelem(IDL,AVLTREE,AVLTREE) 
   
  ins(ID,AVLTREE,AVLTREE)
  
  avl_insert(ID,AVLTREE,AVLTREE,HEIGHT)

  mkltree(HEIGHT,ID,BAL,AVLTREE,AVLTREE,AVLTREE,HEIGHT) 
  avl_l_bal(BAL,AVLTREE,HEIGHT,AVLTREE)
  mkrtree(HEIGHT,ID,BAL,AVLTREE,AVLTREE,AVLTREE,HEIGHT) 
  avl_r_bal(BAL,AVLTREE,HEIGHT,AVLTREE)
  mk_right_rotate_balance(BAL,BAL,BAL)

CLAUSES
  
  ins(K,T1,T2) :- avl_insert(K,T1,T2,_),!.  
  
  avl_insert(KEY,n,tree(KEY,5,n,n),3) :- !.

  avl_insert(KEY,tree(KEY2,BAL,L,R),NEWTREE,H) :-
        KEY2 > KEY ,!,
        avl_insert(KEY,L,NEWLEFT,H2),
        mkltree(H2,KEY2,BAL,NEWLEFT,R,NEWTREE,H).
  
  avl_insert(KEY,tree(KEY2,BAL,L,R),NEWTREE,H) :-
        KEY2 < KEY , !,
        avl_insert(KEY,R,NEWRIGHT,H2),
        mkrtree(H2,KEY2,BAL,L,NEWRIGHT,NEWTREE,H).

  mkltree(3,KEY,6,L,R,tree(KEY,5,L,R),2) :- !.
  mkltree(3,KEY,5,L,R,tree(KEY,4,L,R),3)  :- !.
  mkltree(3,KEY,4,L,R,NEWTREE,2) :- !,
	L=tree(_,LBAL,_,_),
	avl_l_bal(LBAL,tree(KEY,4,L,R),_,NEWTREE).

  mkltree(H2,KEY,BAL,L,R,tree(KEY,BAL,L,R),H2) :- !.

  avl_l_bal(4,tree(K1,_,tree(K2,_,L2,R2),R),1,tree(K2,5,L2,tree(K1,5,R2,R))):- !.
  avl_l_bal(5,tree(K, _,tree(K2,_,L2,R2),R),2,tree(K2,6,L2,tree(K, 4,R2,R))):- !.
  avl_l_bal(6,tree(K1,_,tree(K2,_,L2,tree(K3,B3,L3,R3)),R1),1,tree(K3,5,tree(K2,NB2,L2,L3),tree(K1,NB1,R3,R1) ) ) :- !, 
	mk_right_rotate_balance(B3,NB2,NB1).   /* dette var en left rotate */
     
  avl_r_bal(6,tree(K1,_,L1,tree(K2,_,L2,R2)),1,tree(K2,5,tree(K1,5,L1,L2),R2)):- !. 
  avl_r_bal(6,tree(K1,_,L1,tree(K2,_,L2,R2)),2,tree(K2,4,tree(K1,6,L1,L2),R2)):- !.   
  avl_r_bal(4,tree(K1,_,L1,tree(K2,_,tree(K3,B3,L3,R3),R2)),1,tree(K3,5,tree(K1,NB1,L1,L3),tree(K2,NB2,R3,R2))):- !,
	mk_right_rotate_balance(B3,NB1,NB2). /* dette var en right rotate */
   
  mk_right_rotate_balance(6,4,5) :- !.
  mk_right_rotate_balance(5,5,5) :- !.
  mk_right_rotate_balance(4,5,6).
  
  mkrtree(3,KEY,4,L,R,tree(KEY,5,L,R),2) :- !.
  mkrtree(3,KEY,5,L,R,tree(KEY,6,L,R),3):-!.
  mkrtree(3,KEY,6,L,R,NEWTREE,2) :- !,
	R=tree(_,RBAL,_,_),
	avl_r_bal(RBAL,tree(KEY,6,L,R),_,NEWTREE).

  mkrtree(H2,KEY,BAL,L,R,tree(KEY,BAL,L,R),H2).

  inslistelem([],T,T) :- !.
  inslistelem([HEAD|TAIL],T1,T3) :-
	ins(HEAD,T1,T2),
	inslistelem(TAIL,T2,T3).

  element(ID,tree(_,_,L,_)):- element(ID,L).
  element(ID,tree(ID,_,_,_)).
  element(ID,tree(_,_,_,R)):- element(ID,R).
  
  sort_idl([],[])  :- !.
  sort_idl(KEYL,KEYL2) :- 
	inslistelem(KEYL,n,T),!,
	findall(KEY,element(KEY,T),KEYL2).

/****************************************************************************/
  maxlen([H|T],MAX,MAX1) :-
	str_len(H,LENGTH),
	LENGTH>MAX,!,
	maxlen(T,LENGTH,MAX1).
  maxlen([_|T],MAX,MAX1) :- 
	 !,maxlen(T,MAX,MAX1).
  maxlen([],LENGTH,LENGTH).

PREDICATES
  listlen2(SLIST,INTEGER,INTEGER)
CLAUSES
  listlen(List, Length) :- listlen2(List, 0, Length).

  listlen2([], Len, Len).
  listlen2([_|T], N, Len):-
	N2=N+1,
	listlen2(T, N2, Len).

 gen_str_list(0,[])    :- !.
 gen_str_list(N,[S|L]) :- str_int(S,N), N1=N-1,gen_str_list(N1,L).

PREDICATES  
  expl_str_item(STRING,EXP)

CLAUSES  
  expl_str_stritem("",[]).
  expl_str_stritem(STR,[H|T]):-
         expl_str_item(STR1,H),
 	 expl_str_stritem(STR2,T),
         concat(STR1,STR2,STR). 

  expl_str_item("\r\n",nl).
  expl_str_item(STR,c_str(STR,_)). 
  expl_str_item(STR,c_var(VID,_)):- evalue(VID,VAL,_),!,val_str(VAL,STR).
  expl_str_item(STR,c_var(VID,_)):- format(STR, " ..%s.. ",VID ).

  picture_is_parameter(PIC,PARAM):-
    searchstring(PIC," ..",_),
    frontstr(3,PIC,_,REST),
    searchstring(REST,".. ",POS),
    POS_1 = POS - 1,
    frontstr(POS_1,REST,PARAM,_).

PREDICATES
  get_str(string,string,string)
  strl_str2(slist,string,string)
  reverse1(slist,slist,slist)
  reverse1(ilist,ilist,ilist)
  reverse1(option_list,option_list,option_list)
  
CLAUSES
  get_str(S,S2,SR):-  
    searchchar(S,';',NO),!,
    NO1 = NO - 1,
    frontstr(NO1,S,S2,SR0),
    frontchar(SR0,';',SR).
  get_str(S,S,"").

  str_strl("",STRL,STRL1):- reverse(STRL,STRL1),!.
  str_strl(S,TEMPL,STRL):-
    get_str(S,S2,SR),
    str_strl(SR,[S2|TEMPL],STRL).
    
  strl_str(L,S) :- strl_str2(L,"",S).
  	
  strl_str2([],S,S).
  strl_str2([H|T],B,S) :-
  	concat(B,H,B1),
  	strl_str2(T,B1,S).

  reverse(X,Y) :- reverse1([],X,Y).

  reverse1(Y,[],Y).
  reverse1(X1,[U|X2],Y):- reverse1([U|X1],X2,Y).

  get_one_line(STR,LINE,STR_REST):-
    searchchar(STR,'\n',POS),         % Soft newline
    frontstr(POS,STR,LINE,STR_REST),!.
    
  get_one_line(STR,STR,"").    
 
/**************************************************************
	Sort stringlist in alphabet order using B_Tree
***************************************************************/
DOMAINS
   BR_TREE = reference t(VAL,BR_TREE,BR_TREE)
   VAL  = STRING

PREDICATES
  insert(STRING,BR_TREE)
  instree(SLIST,BR_TREE)
  nondeterm treemembers(STRING,BR_TREE)

CLAUSES
   insert(Val,t(Val,_,_)):-!.
   insert(Val,t(Val1,Tree,_)):-
	Val<Val1,!,
	insert(Val,Tree).
   insert(Val,t(_,_,Tree)):-insert(Val,Tree).

   instree([],_).
   instree([H|T],Tree):-
      insert(H,Tree),
      instree(T,Tree).

   treemembers(_,T):-free(T),!,fail.
   treemembers(X,t(_,L,_)):-treemembers(X,L).
   treemembers(X,t(Refstr,_,_)):-X=Refstr.
   treemembers(X,t(_,_,R)):-treemembers(X,R).

   bt_sort(L, L1) :-
      instree(L,Tree),
      findall(X,treemembers(X,Tree),L1).
    