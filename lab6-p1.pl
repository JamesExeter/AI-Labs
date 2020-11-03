s(A, D) :- foo(A, B), bar(B, C), wiggle(C, D).

foo([choo|A], A).

foo(A, C) :- foo(A, B), foo(B, C).

bar(A, C) :- mar(A, B), zar(B, C).

mar(A, C) :- me(A, B), my(B, C).

me([i|A], A).

my([am|A], A).

zar(A, C) :- blar(A, B), car(B, C).

blar([a|A], A).

car([train|A], A).

wiggle([toot|A], A).

wiggle(A, C) :- wiggle(A, B), wiggle(B, C).

% consult('lab6-p1.pl')
%?- s(X, []).
%First three results:
% X = [choo, i, am, a, train, toot] ;
% X = [choo, i, am, a, train, toot, toot] ;
% X = [choo, i, am, a, train, toot, toot, toot] .
% Expanding any further past this results in a new toot being added on each time indefinitely