:- use_module(library(tabling)).
:- table s/2.

:- table np_subj/1.
:- table np_subj/2.

:- table pro_subj/1.
:- table pro_obj/1.

:- table np_obj/2.
:- table vp/2.

% % the sentence rule
s --> np_subj_3rd, vp_3rd.
s --> np_subj, vp.

% noun phrase rules
np_subj_3rd --> det, n_3rd.
np_subj_3rd --> pro_subj_3rd.

np_subj --> det, n.
np_subj --> pro_subj.

np_obj --> det, n.
np_obj --> det, n_3rd.
np_obj --> pro_obj.


% verb phrase with transitive verb
vp --> v_transitive, np_obj.
% verb phrase with intransitive verb
vp --> v_intransitive.

vp_3rd --> v_transitive_3rd, np_obj.
vp_3rd --> v_intransitive.

% % lexical rules
det --> [the].
n_3rd --> [dog].
n --> [dogs].

pro_obj --> [her].
pro_obj --> [them].

pro_subj_3rd --> [she].

pro_subj --> [i].
pro_subj --> [we].
pro_subj --> [they].

v_intransitive --> [arrived].

v_transitive --> [like].
v_transitive_3rd --> [likes].
