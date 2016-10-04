-module(luhn).
-author("fireflyc").

%% API
-export([valid/1, create/1, main/0]).

checksum(Number) ->
  checksum(lists:reverse(lists:filter(fun(C) -> ($0 =< C) andalso (C =< $9) end, Number)), odd, 0, 0).

checksum([], _, EvenTotal, OddTotal) ->
  EvenTotal + OddTotal;

checksum([H | ReversedNumber], odd, EvenTotal, OddTotal) ->
  checksum(ReversedNumber, even, EvenTotal, OddTotal + H - $0);

checksum([H | ReversedNumber], even, EvenTotal, OddTotal) when H < $5 ->
  checksum(ReversedNumber, odd, EvenTotal + (H - $0) * 2, OddTotal);

checksum([H | ReversedNumber], even, EvenTotal, OddTotal) when H >= $5 ->
  checksum(ReversedNumber, odd, EvenTotal + ((H - $0) * 2) - 9, OddTotal).

create(N) ->
  lists:flatten([N, ($: - (checksum(N ++ [$0]) rem 10))]).

valid(N) ->
  checksum(N) rem 10 =:= 0.

main() ->
  io:format("~p~n", [checksum("2323 2005 7766 355")]).