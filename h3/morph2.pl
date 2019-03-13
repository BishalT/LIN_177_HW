:- use_module(library(tabling)).
:- table go/3.

% Second FST from Jurafsky & Martin
% two-level morphology example
%
% FILL IN THE FST SPECIFICATION WHERE
% INDICATED THROUGHOUT THE FILE.

% Transitions out of state 0
% S below can be anything, except for #, ^, z, s, x, eps
% Pay close attention to how to interpret J&M's use of
% "other" and "#" in transitions.
% "other" means anything not used in any transitions
% going out of this state, excluding "#".

transition(0, '#', 0, '#').
transition(0, '^', 0, eps).
transition(0, S, 0, S) :-
    S \= z,
    S \= s,
    S \= x,
    S \= '#',
    S \= '^',
    S \= eps.

% S below must be one of z, s, x
transition(0, S, 1, S) :-
    S = z;
    S = s;
    S = x.

% Transitions out of state 1
transition(1, '#', 0, '#').
transition(1, S, 0, S) :-
    S \= z,
    S \= s,
    S \= x,
    S \= '^',
    S \= '#',
    S \= eps.

transition(1, S, 1, S) :-
    S = z;
    S = s;
    S = x.

transition(1, '^', 2, eps).

% Transitions out of state 2

transition(2, S, 1, S):-
    S = x;
    S = z.

transition(2, eps, 3, e).
transition(2, s, 5, s).
transition(2, S, 0, S):-
    S \= z,
    S \= s,
    S \= x,
    S \= eps.

% transitions out of state 3

transition(3, s, 4, s).

% transitions out of state 4

transition(4, '#', 0, '#').

% transitions out of state 5

transition(5, S, 1, S) :-
    S = z;
    S = s;
    S = x.

transition(5, S, 0, S) :-
    S \= z,
    S \= s,
    S \= x,
    S \= '^',
    S \= '#',
    S \= eps.

transition(5, '^', 2, eps).

initial(0).

final(0).
final(1).
final(2).


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
