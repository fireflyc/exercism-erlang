-module('clock').

-export([create/2,
  is_equal/2,
  minutes_add/2,
  to_string/1, main/0]).

mod(X, Y) when X > 0 -> X rem Y;
mod(X, Y) when X < 0 -> Y + X rem Y;
mod(0, _Y) -> 0.

create(Hour, Minute) ->
  mod(Hour * 60 + Minute, 24 * 60).

is_equal(Clock1, Clock2) ->
  Clock1 =:= Clock2.

minutes_add(Clock, Minutes) ->
  mod(Clock + Minutes, 24 * 60).

to_string(Clock) ->
  Hour = Clock div 60,
  Minute = Clock rem 60,
  lists:flatten(io_lib:format("~2.10.0b:~2.10.0b", [Hour, Minute])).

main() ->
  io:format("~p~n", [clock:to_string(clock:create(-25, 0))]).