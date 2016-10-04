# Series

Write a program that will take a string of digits and give you all the contiguous substrings of length `n` in that string.

For example, the string "49142" has the following 3-digit series:

- 491
- 914
- 142

And the following 4-digit series:

- 4914
- 9142

And if you ask for a 6-digit series from a 5-digit string, you deserve
whatever you get.

Note that these series are only required to occupy *adjacent positions*
in the input; the digits need not be *numerically consecutive*.

* * * *

For installation and learning resources, refer to the
[exercism help page](http://exercism.io/languages/erlang).

For running the tests provided, only libraries delivered with recent
versions of erlang are used, so there is no need to install anything.

In order to run the tests, you can issue the following commands from
the exercise directory. Please substitute `$EXERCISE` with the
exercises name.

```sh
erl -make
erl -noshell -eval "eunit:test($EXERCISE, [verbose])" -s init stop
```

## Source

A subset of the Problem 8 at Project Euler [http://projecteuler.net/problem=8](http://projecteuler.net/problem=8)

## Submitting Incomplete Problems
It's possible to submit an incomplete solution so you can see how others have completed the exercise.

