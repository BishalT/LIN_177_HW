:- use_module(library(tabling)).
:- table go/3.

initial(1).
final(1).
final(2).
transition(1, b, 2, p).
transition(1, p, 2, b).
transition(1, d, 2, t).
transition(1, t, 2, d).
transition(1, s, 2, z).
transition(1, z, 2, s).
transition(1, Sym, 1, Sym).
transition(2, Sym, 2, Sym).

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
