-module(scrabble_score).
-author("fireflyc").

%% API
-export([score/1, main/0]).
score(S) ->
  lists:foldl(fun(X, Sum) -> char_to_score(string:to_lower(X)) + Sum end, 0, S).

char_to_score($q) -> 10;
char_to_score($z) -> 10;
char_to_score($j) -> 8;
char_to_score($x) -> 8;
char_to_score($k) -> 5;
char_to_score($f) -> 4;
char_to_score($h) -> 4;
char_to_score($v) -> 4;
char_to_score($w) -> 4;
char_to_score($y) -> 4;
char_to_score($b) -> 3;
char_to_score($c) -> 3;
char_to_score($m) -> 3;
char_to_score($p) -> 3;
char_to_score($d) -> 2;
char_to_score($g) -> 2;
char_to_score(Ch) when Ch >= $a, Ch =< $z -> 1.


main() ->
  io:format("~p~n", [score("street")]).