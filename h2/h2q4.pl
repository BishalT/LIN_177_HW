:- use_module(library(tabling)).
:- table go/3.


vowel(aa1).
vowel(ae1).
vowel(ah1).
vowel(ao1).
vowel(aw1).
vowel(ax1).
vowel(ay1).
vowel(eh1).
vowel(er1).
vowel(ey1).
vowel(ih1).
vowel(ix1).
vowel(iy1).
vowel(ow1).
vowel(oy1).
vowel(uh1).
vowel(uw1).

initial(1).
final(1).
final(2).
final(4).
transition(1, s, 2, s).
transition(1, t, 3, t_h).
transition(1, k, 3, k_h).
transition(1, p, 3, p_h).
transition(1, Sym, 1, Sym):- Sym \= eps.
transition(2, Sym, 1, Sym):- Sym \= eps.
transition(3, Vowel, 4, Vowel):- vowel(Vowel), !.
transition(4, Sym, 1, Sym):- Sym \= eps, !.

% This is what we use to run the transducer
fst(Input, Output) :-
  initial(State),
  go(State, Input, Output).

% This is how we know that we've reached the end of the run
go(CurrentState, [], []) :-
  final(CurrentState).

% Use a transition with no eps on either side
go(CurrentState, [A|InString], [B|OutString]) :-
  transition(CurrentState, A, NextState, B),
  A \= eps,
  B \= eps,
  go(NextState, InString, OutString).

% use a transition with eps on the input side
go(CurrentState, InString, [B|OutString]) :-
  transition(CurrentState, eps, NextState, B),
  B \= eps,
  go(NextState, InString, OutString).

% use a transition with eps on the output side
go(CurrentState, [A|InString], OutString) :-
  transition(CurrentState, A, NextState, eps),
  A \= eps,
  go(NextState, InString, OutString).

% use a transition with eps on both sides
go(CurrentState, InString, OutString) :-
  transition(CurrentState, eps, NextState, eps),
  go(NextState, InString, OutString).
