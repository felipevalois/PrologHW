/*
 * Felipe Costa - fvc2m9
 * CS4450 - Principles of Programming Languages
 * Homework 2
 */

% https://swish.swi-prolog.org/p/fvc2m9.pl

% 1. (10 points) Given a positive integer N, print ‘hello world’ N times.
hello_world(X) :-
    foreach(between(1, X, _),
            write('Hello World\n')).

% 2. (15 points) Find the last element of a list; if the list is empty, return ‘NULL’.
last_element([],'NULL').
last_element([Head], Y) :-
	Y=Head.
	last_element([_|Tail], Y) :-
    	last_element(Tail, Y).

% 3. (20 points) Determine whether a given 2-digit integer is prime.
%    (That is, the largest integer to be tested is 99.)
divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).
is_prime(2) :- true, !.
is_prime(X) :- X < 2, !, false.
is_prime(X) :- not(divisible(X,2)).

% 4. (25 points) Return the Least common multiple for all integers in a given list.
%    (For simplicity, all of those integers are assumed to be positive)
lcm([],1).
% lcm is the product of the numbers divided by their gcd
lcm([X|Y], P) :-
    % recursive call removing head each time
    lcm(Y,Q),
    P is X*Q/gcd(X,Q).

% 5. (30 points) Return the factorials of all prime numbers between two integers.
%    (Here closed interval is used to confine the range, like [2, 9].)

rangeToList(L,H,A) :-
    L =< H,
    findall(Z,between(L,H,Z),A).

factorial(0,1).
factorial(N,F) :- N>0, N1 is N-1, factorial(N1,F1), F is N*F1.

primes_factorial(L,H,Y) :-
    rangeToList(L,H,Z),
    % checking if each item is prime, then X contains only the prime numbers from given list
    include(is_prime, Z, X),
    % applying factorial to each prime num
	maplist(factorial, X, Y).
