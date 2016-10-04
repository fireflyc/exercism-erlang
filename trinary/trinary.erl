-module(trinary).
-author("fireflyc").

%% API
-export([to_decimal/1, main/0]).


to_decimal(N) ->
  case re:run(N, "^[0-9]+$") of
    {match, _} ->
      Len = string:len(N),
      {Sum1, _} = lists:foldl(fun(X, Acc) ->
        {Sum, Index} = Acc,
        NewSum = (X - $0) * math:pow(3, Index) + Sum,
        {NewSum, Index - 1}
                              end, {0, Len - 1}, N),
      round(Sum1);
    nomatch ->
      0
  end.

main() ->
  io:format("~p~n", [to_decimal("100")]).