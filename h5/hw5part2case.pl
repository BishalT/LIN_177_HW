% sentence
% np(subject/object, person, singular/plural)
% vp(trans/intransitive, person, singular/plural)
% F: subjective or Objective
% P: 1st, 2rd, 3rd
% N: Singular or Plural
s --> np(subj, P, N), vp(_, P, N).

% noun phrase
np(F, P, N) --> pro(F, P, N).
np(_, P, N) --> det, n(_, P, N).

% verb phrase with intransitive verb
vp(intransitive, P, N) --> v(intransitive, P, N).

% verb phrase with transitive verb
vp(transitive, P, N) --> v(transitive, P, N), np(obj, _, _).

% lexicon
det --> [the].
n(_, third, singular) --> [dog].
n(_, third, plural) --> [dogs].

pro(subj, first, singular) --> [i].
pro(subj, third, singular) --> [she].
pro(subj, first, plural) --> [we].
pro(subj, third, plural) --> [they].

pro(obj, third, singular) --> [her].
pro(obj, third, plural) --> [them].

v(intransitive, _, _) --> [arrived].

v(transitive, third, singular) --> [likes].

v(transitive, first, _) --> [like].
v(transitive, third, plural) --> [like].
