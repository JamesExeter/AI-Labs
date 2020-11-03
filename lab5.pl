% See Bratko pages 353-356.
%
% Interaction with user and why and how explanation

% Operators for easy to read rules.

:- op( 800, fx, if).
:- op( 700, xfx, then).
:- op( 300, xfy, or).
:- op( 200, xfy, and).
:- op( 800, xfx, <=).

%%%%
% Adam Wyner
% Added the dynamic fact predicate as there were otherwise errors.
% p. 351 in Bratko book.

:- dynamic( fact/1).

% is_true( P, Proof): Proof is a proof that P is true

is_true( P, Proof) :-
 explore( P, Proof, []).

% explore( P, Proof, Trace):
% Proof is an explanation for P, Trace is a chain of rules between P's ancestor goals

explore( P, P, _) :-
 fact( P). % P is a fact

explore( P1 and P2, Proof1 and Proof2, Trace) :- !,
 explore( P1, Proof1, Trace),
 explore( P2, Proof2, Trace).

explore( P1 or P2, Proof, Trace) :- !,
 (
  explore( P1, Proof, Trace)
  ;
  explore( P2, Proof, Trace)
 ).

explore( P, P <= CondProof, Trace) :-
 if Cond then P, % A rule relevant to P
 explore( Cond, CondProof, [ if Cond then P | Trace]).

explore( P, Proof, Trace) :-
 askable( P), % P may be asked of user
 \+ fact( P), % P not already known fact
 \+ already_asked( P), % P not yet asked of user
 ask_user( P, Proof, Trace).

ask_user( P, Proof, Trace) :-
 nl, write( 'Is it true:'), write( P), write(?), nl, write( 'Please answer yes, no, or why'), nl,
 read( Answer),
 process_answer( Answer, P, Proof, Trace). % Process user's answer

process_answer( yes, P, P <= was_told, _) :- % User told P is true
 asserta( fact(P)),
 asserta( already_asked( P)).

process_answer( no, P, _, _) :-
 asserta( already_asked( P)), % Make sure not to ask again about P
 fail. % User told P is not true

process_answer( why, P, Proof, Trace) :- % User requested why-explanation
 display_rule_chain( Trace, 0), nl,
 ask_user( P, Proof, Trace). % Ask about P again

display_rule_chain( [], _).

display_rule_chain( [if C then P | Rules], Indent) :-
 nl, write( 'To explore whether '), write( P), write(' is true, using rule:'),
 nl, write( if C then P),
 NextIndent is Indent + 2,
 display_rule_chain( Rules, NextIndent).

:- dynamic already_asked/1.
















%insert knowledge base here
%assert if true or false for these, some may be removed
%fact(symptoms).
%fact(self_isolated_two_weeks).
%fact(vaccinated_for_coronavirus).
%fact(previously_infected).
%fact(went_to_large_gathering).
%fact(someone_infected_at_gathering). 

is_true(get_tested) :- if symptoms and high_risk_infected then get_tested, is_true(symptoms and high_risk_infected).
is_true(healthy) :- if self_isolated_two_weeks and no_symptoms then healthy, is_true(self_isolated_two_weeks and no_symptoms).
is_true(immune) :- if previously_infected or vaccinated_for_coronavirus then immune, is_true(previously_infected and vaccinated_for_coronavirus).
is_true(high_risk_infected) :- if went_to_large_gathering and someone_infected_at_gathering then high_risk_infected, is_true(went_to_large_gathering and someone_infected_at_gathering).



%healthy:- self_isolated_two_weeks, no_symptoms.
%immune :- vaccinated_for_coronavirus ; previously_infected.
%high_risk_infected :- went_to_large_gathering, someone_infected_at_gathering.
%low_risk_infected :- self_isolated_two_weeks ; went_to_large_gathering, no_infected_at_gathering.
%get_tested :- symptoms, high_risk_infected.
%no_test_needed :- healthy ; immune ; low_risk_infected, no_symptoms. 

% add if conditions to be used for the knowledge base
if 
    self_isolated_two_weeks and no_symptoms
then 
    healthy.

if 
    vaccinated_for_coronavirus or previously_infected
then
    immune.

if 
    went_to_large_gathering and someone_infected_at_gathering
then   
    high_risk_infected.

if 
    symptoms and high_risk_infected
then
    get_tested.

if 
    healthy or immune and no_symptoms
then   
    no_test_needed.

% add askables that need to be known for the system to use
askable(self_isolated_two_weeks).
askable(symptoms).
askable(went_to_large_gathering).
askable(someone_infected_at_gathering).
askable(previously_infected).
askable(vaccinated_for_coronavirus).
