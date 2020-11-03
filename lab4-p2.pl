directTrain(saarbruecken,dudweiler).
directTrain(forbach,saarbruecken).
directTrain(freyming,forbach).
directTrain(stAvold,freyming).
directTrain(fahlquemont,stAvold).
directTrain(metz,fahlquemont).
directTrain(nancy,metz).

directRoute(X, Y) :- 
    directTrain(X, Y).

directRoute(X, Y) :-
    directTrain(Y, X), !.

route(Y, Y, RV, V) :-
    reverse(RV, V).

route(X, Y, RV, V) :- 
    directRoute(X, Z),
    not(member(Z, RV)),
    route(Z, Y, [Z | RV], V).

route(X, Y, V) :- 
    route(X, Y, [X], V).

% what is the route from forbach to metz?
% route(forbach, metz, X) -> X = [forbach, freyming, stAvold, fahlquemont, metz] ;
% allows the program to figure out the route backwards since it can query freyming to forbach as forbach to freyming too
% understanding that if there exists a path in one direction, then it exists in the opposite direction too

% what cities are connected via the route through saarbruecken, forbach, freyming, stAvold, fahlquemont, and metz?
% write a query in terms of route(X, Y, [X, saarbruecken, forbach, freyming, stAvold, fahlquemont, metz, Y])
% X = dudweiler; Y = nancy; which seems correct