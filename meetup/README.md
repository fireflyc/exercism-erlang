# Meetup

Calculate the date of meetups.

Typically meetups happen on the same day of the week.

Examples are

- the first Monday
- the third Tuesday
- the Wednesteenth
- the last Thursday

Note that "Monteenth", "Tuesteenth", etc are all made up words. There
was a meetup whose members realised that there are exactly 7 days that
end in '-teenth'. Therefore, one is guaranteed that each day of the week
(Monday, Tuesday, ...) will have exactly one date that is named with '-teenth'
in every month.

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

Jeremy Hinegardner mentioned a Boulder meetup that happens on the Wednesteenth of every month [https://twitter.com/copiousfreetime](https://twitter.com/copiousfreetime)

## Submitting Incomplete Problems
It's possible to submit an incomplete solution so you can see how others have completed the exercise.

