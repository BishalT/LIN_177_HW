% sentence
% we need to enforce subject-verb agreement
% (person and number need to match for NP and VP),
% and we need the right case
s --> np(subj,ADD_MORE_FEATURES), vp(ADD_FEATURES_HERE).

% noun phrase
% ADD THE NP RULES

% verb phrase
% VP with intransitive verb
% the VP gets Person and Number from the V
vp(Person,Number) --> v(intransitive,Person,Number).

% VP with transitive verb
% ADD THE TRANSITIVE VP RULE

% lexicon

det --> [the].

% pronoun, subjective case, third person singular
pro(subj,third,singular) --> [she].

% WRITE THE LEXICAL ENTRIES FOR:
% her, they, them, i, we

% here the underscore means that case can be
% anything. (dog is the same, whether it is
% subj or obj.)
n(_,third,singular) --> [dog].

% WRITE THE LEXICAL ENTRY FOR dogs

% verb features:
% - transitive/instransitive
% - person: first, second, third
% - number: plural, singular

% the underscores here mean that Person can
% be anything, and Number can be anything
v(intransitive,_,_) --> [arrived].

% here we need to ensure person/number is
% third singular
% WRITE THE LEXICAL ENTRY FOR likes (transitive)

% here we use variables to indicate that
% person/number can be anything, except for
% third singular
v(transitive,Person,Number) --> [like],
    { not((Person == third, Number == singular)) }.



