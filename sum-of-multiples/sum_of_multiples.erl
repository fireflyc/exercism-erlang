-module(sum_of_multiples).
-export([sumOfMultiples/2]).

-spec sumOfMultiples([integer()], integer()) -> integer().

sumOfMultiples(NumList, UpBound) ->
	Result = multiples(NumList, UpBound-1, []),
	lists:sum(Result).

multiples(_NumList, 0, Result) ->
	Result;
	
multiples(NumList, UpBound, Result) ->
	case lists:any(fun(N) -> UpBound rem N =:=0 end, NumList) of
		true -> multiples(NumList, UpBound-1, [UpBound | Result]);
		false -> multiples(NumList, UpBound-1, Result)
	end.
	