:- use_module(library(tabling)).
:- table s/2.
:- table np/2.
:- table vp/2.
:- table pp/2.

% enter your rules below
s --> np, vp.
np --> np, pp.
np --> det, n.
pp --> p, np.
vp --> vp, pp.
vp --> v, np.


% the lexical rules (no need to edit below)
v --> [chased].
v --> [saw].

n --> [cats].
n --> [dogs].
n --> [garden].
n --> [house].

p --> [in].
p --> [behind].
p --> [from].

det --> [the].
