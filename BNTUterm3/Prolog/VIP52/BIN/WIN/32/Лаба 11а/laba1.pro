predicates
 nondeterm fun(integer,real)
  nondeterm result
clauses
  fun(0,1.0).
  fun(1,1.0).
  fun(N,F):-N>1,N mod 2=0, N1=N-2, fun(N1,F1),F=F1*(N-1).
   fun(N,F):-N>1,N mod 2=1, N1=N-2, fun(N1,F1),F=F1*N.
  result:-
    write("¬ведите N"),nl,
    write("N="),readint(N),
    fun(N,F),
    write("1 до N (1*3*5*Е*N)=",F),nl.
goal
result.  