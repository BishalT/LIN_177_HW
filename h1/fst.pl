:- use_module(library(tabling)).
:- table go/3.

initial(1).
final(1).
transition(1, l, 2, eps).
transition(2, ae, 3, eps).
transition(3, ng, 4, eps).
transition(4, g, 5, eps).
transition(5, w, 6, eps).
transition(6, ah, 7, eps).
transition(7, jh, 1, language).

transition(7, jh, 8, eps).
transition(8, ah, 9, eps).
transition(9, z, 1, languages).

transition(1, f, 10, eps).
transition(10, ao, 11, eps).
transition(11, r, 12, eps).
transition(12, m, 13, eps).
transition(13, ah, 14, eps).
transition(14, l, 1, formal).

transition(1, n, 15, eps).
transition(15, ae, 16, eps).
transition(16, ch, 17, eps).
transition(17, er, 18, eps).
transition(18, ah, 19, eps).
transition(19, l, 1, natural).

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


soundslike(X,Y) :-
    fst(Phenom, X),
    fst(Phenom, Y).
