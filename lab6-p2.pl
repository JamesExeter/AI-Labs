s --> np(N),vp(N). 

np(N) --> det(N),n(N).

vp(N) --> v(N),np(N). 
vp(N) --> v(N).

det(_) --> [the]. 
det(singular) --> [a].
n(singular) --> [woman].
n(singular) --> [man].
n(plural) --> [men].
n(singular) --> [apple].
n(singular) --> [pear].
v(singular) --> [eats].
v(plural) --> [eat].
v(plural) --> [know].

%consult('lab6-p2.pl').
%example output
%?- s(X, []).
% X = [the, woman, eats, a, pear] ;
% X = [the, woman, eats] ;
% X = [the, man, eats, the, woman] ;
% X = [the, man, eats, the, man] ;
% X = [the, man, eats, the, apple] ;
% X = [the, man, eats, the, pear] ;
% X = [the, man, eats, a, woman] ;
% X = [the, man, eats, a, man] ;
% X = [the, man, eats, a, apple] ;
% X = [the, man, eats, a, pear] ;
% X = [the, man, eats] ;
% X = [the, men, eat, the, men] ;
% X = [the, men, know, the, men] ;
% X = [the, men, eat] ;