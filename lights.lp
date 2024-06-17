% Please provide the names of your (up to three) group members:
% Valentina Schiavon
% Adin Halilovic
% Vanessa Fröhlich

%* DATA *%

% Define the cells in the grid
cell(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
free(X,Y) :- cell(X,Y), not digit(X,Y,_).

diff(0,1;0,-1;1,0;-1,0).
next(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), diff(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

%* IMPLEMENTATION *%

% Light placing in cells
{ light(X,Y) : rows(R),cols(C), X=1..R, Y=1..C, not digit(X,Y,_), not empty(X,Y), not tozero(X,Y), not lightpresent(X,Y)}.

% Check if there is a light or wall in the same column or row
lightpresent(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, light(X1,Y), X1 != X, not block(X,Y,X1,Y).
lightpresent(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, light(X,Y1), Y1 != Y, not block(X,Y,X,Y1).

% Adjacent cells 
tozero(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, digit(X1,Y1,0), adjacent(X,Y,X1,Y1).

% an cell next to an illuminated one should be illuminated too
illuminated(X,Y) :- light(X,Y).
illuminated(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, light(X,Y1), Y1 < Y, not block(X,Y,X,Y1).
illuminated(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, light(X,Y1), Y1 > Y, not block(X,Y,X,Y1).
illuminated(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, light(X1,Y), X1 < X, not block(X,Y,X1,Y).
illuminated(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, light(X1,Y), X1 > X, not block(X,Y,X1,Y).

% Predetermined cells can be between two othre cells
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, digit(Z,W,_), Z = X, Z = X1, W > Y, W < Y1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, digit(Z,W,_), Z = X, Z = X1, W < Y, W > Y1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, digit(Z,W,_), W = Y, W = Y1, Z > X, Z < X1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, digit(Z,W,_), W = Y, W = Y1, Z < X, Z > X1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, empty(Z,W), Z = X, Z = X1, W > Y, W < Y1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, empty(Z,W), Z = X, Z = X1, W < Y, W > Y1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, empty(Z,W), W = Y, W = Y1, Z > X, Z < X1.
block(X,Y,X1,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, X1=1..R, Y1=1..C, empty(Z,W), W = Y, W = Y1, Z < X, Z > X1.

% Neighbour cells
adjacent(X,Y,X1,Y) :- rows(R), cols(C), X=1..R, Y=1..C, X1 = X+1, X1 <= R.
adjacent(X,Y,X1,Y) :- rows(R), cols(C), X=1..R, Y=1..C, X1 = X-1, X1 >= 1.
adjacent(X,Y,X,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, Y1 = Y+1, Y1 <= C.
adjacent(X,Y,X,Y1) :- rows(R), cols(C), X=1..R, Y=1..C, Y1 = Y-1, Y1 >= 1.

% Adjacent cells in each direction for a number should have a light in them
:- digit(X,Y,D), D != #count { X1,Y1 : light(X1,Y1), adjacent(X,Y,X1,Y1), rows(R), cols(C), X=1..R, Y=1..C, not tozero(X1,Y1) }.

% also all cells that are not pre-chosen should be illuminated
:- rows(R), cols(C), X=1..R, Y=1..C, not digit(X,Y,_), not empty(X,Y), not illuminated(X,Y).

%* DISPLAY *%
#show light/2.