byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(losAngeles,auckland).

travel(X, Y) :- journey(X, Y).
travel(X, Y) :- journey(X, Z),
                travel(Z, Y).

travel(X, Y, go(X, Y)) :- journey(X, Y).
travel(X, Y, go(X, Z, Path)) :- journey(X, Z), 
                                travel(Z, Y, Path).    

journey(X, Y) :- byCar(X, Y).
journey(X, Y) :- byPlane(X, Y).
journey(X, Y) :- byTrain(X, Y).

% answer queries
% travel(valmont, paris). -> true
% travel(valmont, paris, X) -> X = go(valmont, saarbruecken, go(saarbruecken, paris)) and 
%                              X = go(valmont, metz, go(metz, paris)).
% you can travel from valmont to paris via metz, but also through saarbruecken

% travel(auckland, raglan). -> true, it is possible to travel from auckland to raglan with the route given below
% travel(auckland, raglan, X). -> X = go(auckland, hamilton, go(hamilton, raglan)) .

% travel(valmont, losAngeles) -> X = go(valmont, metz, go(metz, paris, go(paris, losAngeles))) and 
%                                X = go(valmont, saarbruecken, go(saarbruecken, paris, go(paris, losAngeles)))