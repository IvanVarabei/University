
/*domains
l=char*
predicates
nondeterm result
nondeterm str_list(string,l)%(i,o)
nondeterm rev(l,l)%(i,o)
nondeterm revers (l,l,l)%(i,i,o)
nondeterm list_str(l,string)%(i,o)
clauses
str_list("",[]).
str_list(S,[H|T]):-frontchar(S,H,S1),str_list(S1,T).

rev (L, L1):-revers (L, [ ], L1).

revers ([ ], L1, L1).
revers ([H|T], L, L1):-revers (T, [H|L], L1).

list_str([],"").
list_str([H|T],S):-list_str(T,S1),frontchar(S,H,S1).

result:-
write("3.0 Enter innate row:"),nl,
readln(S),nl,
str_list(S,L),
rev(L,L1),
list_str(L1,S1),
write("Innate row:"),nl,
write(S),nl,nl,
write(str_len(S,3)),
write("Inside out row:"),nl,
write(S1),nl,nl.
goal
result.*/

%4.4
/*predicates
nondeterm p(string, string) %(i,o)            
clauses
p("", "").
p(S,R):-frontchar(S,'*',SS),!,  
p(SS,R);
frontchar(S,C,SS),!,
p(SS,RR),frontchar(RRR,C,RR),frontchar(R,C,RRR).    
goal
write("String: "),
readln(S),
p(S,R),
write("Result: ", R),nl.   */ 
        

%4.13             
predicates
nondeterm a(char,string).%(i,i)              
nondeterm b(string,string).%(i,i)             
nondeterm r.
clauses 
a(CH,STR):-frontchar(STR,H,_),H=CH.                                  
a(CH,STR):-frontchar(STR,H,OST),H<>CH,a(CH,OST).        
b(_,"").
b(S,STR):-frontchar(STR,M,OST2),a(M,S),b(S,OST2).           
b(S,STR):-frontchar(STR,M,OST2),not(a(M,S)),write(M),b(S,OST2).         
    
r:-S="abcdefghijklmnopqrstuvwxyz",write("In: "),readln(STR),b(STR,S),nl.         
goal
r.
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    