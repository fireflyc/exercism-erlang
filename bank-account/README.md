# Bank Account

Bank accounts can be accessed in different ways at the same time.

A bank account can be accessed in multiple ways. Clients can make
deposits and withdrawals using the internet, mobile phones, etc. Shops
can charge against the account.

Create an account that can be accessed from multiple threads/processes
(terminology depends on your programming language).

It should be possible to close an account; operations against a closed
account must fail.

## Instructions

Run the test file, and fix each of the errors in turn. When you get the
first test to pass, go to the first pending or skipped test, and make
that pass as well. When all of the tests are passing, feel free to
submit.

Remember that passing code is just the first step. The goal is to work
towards a solution that is as readable and expressive as you can make
it.

Have fun!

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



## Submitting Incomplete Problems
It's possible to submit an incomplete solution so you can see how others have completed the exercise.

