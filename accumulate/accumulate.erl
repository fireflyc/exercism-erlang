-module(accumulate).
-export([accumulate/2]).

-spec accumulate(fun((any())-> any()), list()) -> list().

%accumulate(Fun, Ls) ->
%	lists:map(Fun, Ls).

accumulate(Fun, Ls) ->
	accumulate(Fun, Ls, []).

accumulate(Fun, [H|T], Result) ->
	accumulate(Fun, T, [Fun(H)|Result]);

accumulate(_Fn, [], Result) ->
	lists:reverse(Result).e