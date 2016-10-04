-module(anagram).
-export([find/2]).

-spec find(string(), list()) -> list().

find(Origin, OtherList) ->
	LowOrign = string:to_lower(Origin),
	OrderOrigin = lists:sort(LowOrign),
	Fun = fun(X) -> 
		LowX = string:to_lower(X),
		case {LowX, lists:sort(LowX)} of
			{LowOrign, _} ->
				false;
			{_, OrderOrigin} ->
				true;
			_ ->
				false
		end
	end,
	lists:filter(Fun, OtherList).