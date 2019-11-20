%e^x = 1 + x/1! + x^2/2! + … + x^n/n! 

%Task 4.3 iteration
/*domains
n= integer
f=real
predicates
nondeterm factorial(integer,real)
nondeterm factorial_aux(integer,real,integer,real)
nondeterm step(real,integer,real)
nondeterm expo(integer,real,real)
nondeterm expo_aux(integer,real,real,real,real)
nondeterm control(integer,real)
clauses
step(_,0,1.0).
step(A,N,R) if N>0 and N mod 2<>0 and N1=N-1 and step(A,N1,R1) and R=R1*A.
step(A,N,R):- N<0,N mod 2<>0,N1=-N-1,step(A,N1,R1),R=1/(R1*A).
step(A,N,R):- N>0,N mod 2=0,N1=N/2,step(A,N1,R1),R=R1*R1.
step(A,N,R):- N<0,N mod 2=0,N1=-N-1,step(A,N1,R1),R=1/(R1*A).
 factorial(N,F):- factorial_aux(N,F,0,1).
 factorial_aux(N,F,L,P):-
 L<N, NewL=L+1,NewP=P*Newl,
 factorial_aux(N,F,NewL,NewP).
 factorial_aux(N,F,L,F):- L>=N.
 
 expo(X,E,R):- expo_aux(X,E,R,0,0).
 expo_aux(X,E,R,L,P):-
  NewL=L+1,factorial(L,F),step(X,L,U),NewP=P+U/F,abs(P-NewP)>E, 
  expo_aux(X,E,R,NewL,NewP).

 expo_aux(X,E,R,L,R):- L>=E,X>0.
 
 control(X,G):-G=exp(X).
 
goal
write("Poke X="),readint(X),
write("Poke E(Aqurancy)="),readreal(E),
expo(X,E,R),
control(X,G),nl,
write("Standart function : e^",X,"=",G),nl,
write("e^",X,"=",R),nl.*/




%Task 4.3 recursion
domains
n= integer
f=real
predicates
nondeterm step(real,integer,real)
nondeterm factorial(n,f)
nondeterm expo(integer,integer,real)
nondeterm result
clauses
step(_,0,1.0).
step(A,N,R) if N>0 and N1=N-1 and step(A,N1,R1) and R=R1*A or N1=N+1 and
step(A,N1,R1) and R=R1/A.
factorial(0,1).
factorial(N,F):- N>0,N1=N-1,factorial(N1,F1),F=F1*N.
expo(_,N,0) if N=100.
expo(X,N,R) if N1=N+1 and expo(X,N1,R1) and factorial(N,F) and step(X,N,U) 
and R=R1+U/F.
result:-
write("Poke X"),nl,
write("X="),readint(X),
expo(X,0,R),
write("e^",X,"=",R),nl.
goal
result.




%Task 4.2
/*predicates
nondeterm summ(integer,integer,integer)
nondeterm result
clauses
summ(F,N,R) if F=N+1 and R=0.
summ(F,N,R) if F1=F+1 and F mod 2<>0 and summ(F1,N,R1) and R=R1+F 
or F1=F+1 and summ(F1,N,R1) and R=R1+0.
result:-
write("Poke N"),nl,
write("N="),readint(N),
summ(1,N,R),
write("Summ odds from 1 to ",N," = ",R),nl.
goal
result.*/


%Task 4.1
/*predicates
nondeterm summ(integer,integer,integer)
nondeterm result
clauses
summ(I,J,K) if I=J+1 and K=0.
summ(M,N,R) if M1=M+1 and summ(M1,N,R1) and R=R1+M.
result:-
write("Poke M"),nl,
write("M="),readreal(M),
write("Poke N"),nl,
write("N="),readint(N),
summ(M,N,R),
%R=R+M,
write("Summ from ",M," to ",N," = ",R),nl.
goal
result.*/

/*
%Task 3 a)
predicates
nondeterm step(real,integer,real)
nondeterm result
clauses
step(_,0,1.0).
step(A,N,R) if N>0 and N1=N-1 and step(A,N1,R1) and R=R1*A or N1=N+1 and
step(A,N1,R1) and R=R1/A.
result:-
write("Enter number A"),nl,
write("A="),readreal(A),
write("Enter extent N"),nl,
write("N="),readint(N),
step(A,N,R),
write(A,"^",N,"=",R),nl.
goal
result.*/


%Task 3 b)
/*predicates
nondeterm step(real,integer,real)
nondeterm result
clauses
step(_,0,1.0).
step(A,N,R) if N>0 and N mod 2<>0 and N1=N-1 and step(A,N1,R1) and R=R1*A.
step(A,N,R):- N<0,N mod 2<>0,N1=-N-1,step(A,N1,R1),R=1/(R1*A).
step(A,N,R):- N>0,N mod 2=0,N1=N/2,step(A,N1,R1),R=R1*R1.
step(A,N,R):- N<0,N mod 2=0,N1=-N-1,step(A,N1,R1),R=1/(R1*A).
result:-
write("Enter real number A"),nl,
write("A="),readreal(A),
write("Enter amount of power integer N"),nl,
write("N="),readint(N),
step(A,N,R),
write(A,"^",N,"=",R),nl.
goal
result.*/
