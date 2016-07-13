-module(strain).
-export([keep/2, discard/2]).

-spec keep(fun((integer()) -> boolean()), [integer()]) -> [integer()].
-spec discard(fun((integer()) -> boolean()), [integer()]) -> [integer()].
		
keep(Fun, List) ->
	foreach(Fun, List, [], [], true).
	
discard(Fun, List) ->
	foreach(Fun, List, [], [], false).

foreach(Fun, [H|T], Result1, Result2, WhichResult) ->
	case Fun(H) of 
		true 	-> foreach(Fun, T, [H|Result1], Result2, WhichResult);
		false 	-> foreach(Fun, T, Result1, [H|Result2], WhichResult)
	end;

foreach(_Fun, [], Result1, Result2, WhichResult) ->
	case WhichResult of
		true 	-> lists:reverse(Result1);
		false 	-> lists:reverse(Result2)
	end.