-module(grains).
-export([square/1, total/0]).

-spec square(non_neg_integer()) -> non_neg_integer().
-spec total() -> non_neg_integer().

square(N) ->
	square(N, 1).

square(1, Result) ->
	Result;
	
square(N, Result) ->
	square(N-1, 2 * Result).


total() ->
	lists:sum([square(N) || N <- lists:seq(1, 64)]).