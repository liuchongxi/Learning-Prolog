/* 1.(2 marks) Implement makelist(N, X, Lst) that works as follows:

?- makelist(3, a, X).
X = [a, a, a]

?- makelist(4, [a,b], X).
X = [[a, b], [a, b], [a, b], [a, b]]
In other words, makelist(N, X, Lst) binds to Lst a new list consisting of N copies of X.

You can assume N is 0 or greater. */

makelist(0,_,[]).
makelist(N, X, [X|Xs]) :- 
    N > 0,
    N1 is N - 1,
    makelist(N1, X, Xs).

/* 2.(2 marks) Implement second_min(Lst, M) that calculates the second smallest number on a list like this:

?- second_min([2,8,4,6], X).
X = 4

?- second_min([1,2], X).
X = 2
If the passed-in list has fewer than 2 elements, it should fail:

    ?- second_min([], X).
    false

    ?- second_min([6], X).
    false

For simplicity, you can assume ``Lst`` has no duplicates. */

% allow to use sort?
second_min(Lst, X) :- 
    length(Lst, N),
    N > 1,
    sort(Lst, [_, X | _]).

/* 3.(2 marks) Prolog has a function called numlist(Lo, Hi, Result) that creates a list of numbers from Lo to Hi. For example:

?- numlist(1,5,L).
L = [1, 2, 3, 4, 5]
Implement your own version of this called mynumlist(Lo, Hi, Result). Of course, don’t use numlist anywhere! */

mynumlist(X, X, [X]).
mynumlist(Lo, Hi, [Lo|Rest]) :-
    Lo < Hi,
    L2 is Lo + 1,
    mynumlist(L2, Hi, Rest).

/* 4.(2 marks) Implement the function all_diff(Lst) that succeeds (i.e. returns true) just when Lst has no duplicate values, e.g.:

?- all_diff([7,2,1,9]).
true

?- all_diff([7,2,7,9]).
false
If Lst is empty, or only has one element, then all_diff should succeed.

You can use \+, the not operator, in your solution. It works like this:

?- \+ member(2, [2,4,1]).
false

?- \+ 5 < 6.
false. */

% is that ok to just write like this? almost the same as in lecture note
all_diff([]).
all_diff([X|Xs]) :- 
    \+ member(X,Xs),
    all_diff(Xs).

/* 5.(2 marks) Implement negpos(L, Neg, NonNeg) that partitions a list L of numbers into negatives and non-negatives. For example:

?- negpos([1,0,2,-3,2,-4,5], A, B).
A = [-3, -4],
B = [1, 0, 2, 2, 5]
The order of the numbers in Neg and NonNeg doesn’t matter. */

allPositive([],[]).
allPositive([Head|Rest], [Head|Pos]) :-
    Head >= 0,
    allPositive(Rest,Pos).
allPositive([_|Rest], Pos) :-
    allPositive(Rest, Pos).

allNegative([],[]).
allNegative([Head|Rest], [Head|Negs]) :-
    Head < 0,
    allNegative(Rest,Negs).
allNegative([_|Rest], Negs) :-
    allNegative(Rest, Negs).

negpos(L, Neg, NonNeg) :-
    allNegative(L, Neg),
    allPositive(L, NonNeg).

/* 6.(5 marks) A 3x3 magic square is a grid of 9 numbers where each row and column add up to the same number (known as the magic number).
The sum of the two diagonals does not matter.

For example, this magic square has magic number 15:

1 5 9
6 7 2
8 3 4
Implement magic(L9, Result) that takes a list L9 of 9 numbers as input, and calculates a permutation of L9 that is magic. For example:

?- magic([1,2,3,4,5,6,7,8,9], Result).
Result = [1, 5, 9, 6, 7, 2, 8, 3, 4]
Result is in row-major order, i.e. it corresponds to this square:

1 5 9
6 7 2
8 3 4
Here’s another example:

?- magic([2,4,6,8,10,12,14,16,18], Result).
Result = [2, 10, 18, 12, 14, 4, 16, 6, 8]
This is the square (it’s magic number is 30):

 2 10 18
12 14  4
16  6  8
If L9 does not have exactly 9 elements, then magic should return false.

Depending upon the numbers in L9, there could be 0 or more solutions. When there’s no solution, 
your magic function should only take a few seconds to run. */

magic([N1, N2, N3, N4, N5, N6, N7, N8, N9], [A, B, C, D, E, F, G, H, I]) :-
       permutation([N1, N2, N3, N4, N5, N6, N7, N8, N9], [A, B, C, D, E, F, G, H, I]),
       R1 is A + B + C,
       R2 is D + E + F,
       R1 == R2,
       R3 is G + H + I,
       R2 == R3,
       C1 is A + D + G,
       C1 == R1,
       C2 is B + E + H,
       C1 == C2,
       C3 is C + F + I,
       C2 == C3.
