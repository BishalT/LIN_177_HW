:- use_module(library(tabling)).
:- table go/3.

voiced(S) :-
    S = aa;
    S = ae;
    S = ah;
    S = ao;
    S = aw;
    S = ay;
    S = b;
    S = d;
    S = dh;
    S = eh;
    S = er;
    S = ey;
    S = g;
    S = iy;
    S = jh;
    S = l;
    S = m;
    S = n;
    S = ng;
    S = ow;
    S = r;
    S = th;
    S = uh;
    S = uw;
    S = v;
    S = w;
    S = y;
    S = z;
    S = zh.

voiceless(S) :-
    S = ch;
    S = f;
    S = hh;
    S = oy;
    S = k;
    S = ih;
    S = p;
    S = s;
    S = sh;
    S = t.

sibilant(S) :-
    S = ch;
    S = s;
    S = sh;
    S = jh;
    S = z;
    S = zh.

% Transitions
transition(1, S, 1, S):-
    S \= eps,
    S \= '^',
    S \= '#'.
% Voiceless Non-Sibilant
transition(1, S, 2, S):-
    voiceless(S),
    not(sibilant(S)).

transition(2, S, 1, S):-
    S \= '^',
    S \= eps.

transition(2, '^', 3, eps).
transition(3, s, 4, s).
transition(4, '#', 1, '#').

% Voiced Non-Sibilant
transition(1, S, 5, S):-
    voiced(S),
    not(sibilant(S)).

transition(5, S, 1, S):-
    S \= '^',
    S \= eps.

transition(5, '^', 6, eps).
transition(6, s, 7, z).
transition(7, '#', 1, '#').

% Sibiliant
transition(1, S, 8, S):-
    sibilant(S).

transition(8, S, 1, S):-
    S \= '^',
    S \= eps.

transition(8, '^', 9, ah).
transition(9, s, 10, z).
transition(10, '#', 1, '#').

%BEGIN/END STATES

initial(1).
final(1).

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
