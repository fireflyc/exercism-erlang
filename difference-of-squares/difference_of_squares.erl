-module(difference_of_squares).
-author("fireflyc").

%% API
-export([sum_of_squares/1, square_of_sums/1, difference_of_squares/1, main/0]).

sum_of_squares(N) ->
  round(lists:foldr(fun(X, Acct) -> Acct + math:pow(X, 2) end, 0, lists:seq(1, N))).

square_of_sums(N) ->
  round(math:pow(lists:foldr(fun(X, Acct) -> Acct + X end, 0, lists:seq(1, N)), 2)).

difference_of_squares(N) ->
  square_of_sums(N) - sum_of_squares(N).

main() ->
  io:format("~p~n", [difference_of_squares(5)]).