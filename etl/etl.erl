-module(etl).
-author("fireflyc").

%% API
-export([transform/1, main/0]).

split(DictItem) ->
  {Val, ValWordList} = DictItem,
  lists:map(fun(X) -> {string:to_lower(X), Val} end, ValWordList).

transform(Data) ->
  lists:foldr(fun(X, List) -> split(X) ++ List end, [], Data).

main() ->
  io:format("~p~n", [transform([{1, ["a", "e"]}, {4, ["b"]}])]),
  io:format("~p~n", [transform([{1, ["a"]}])]),
  Old = [
    {1,  ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]},
    {2,  ["D", "G"]},
    {3,  ["B", "C", "M", "P"]},
    {4,  ["F", "H", "V", "W", "Y"]},
    {5,  ["K"]},
    {8,  ["J", "X"]},
    {10, ["Q", "Z"]}
  ],
  io:format("~p~n", [lists:sort(transform(Old))]).