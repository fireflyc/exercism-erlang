-module('largest_series_product').

-export([lsp/2, main/0]).

lsp(_String, Span) when Span < 0 ->
  error;
lsp(String, Span) when Span >= 0 ->
  lsp(String, Span, string:len(String)).

lsp(_String, Span, Length) when Length < Span ->
  error;
lsp(String, Span, Length) ->
  List = form_string(Span, Length, String),
  lists:max([product(X) || X <- List]).

product(List) -> lists:foldl(fun product/2, 1, List).
product(_C, error) -> error;
product(C, _Acc) when not ((C >= $0) and (C =< $9)) -> error;
product(C, Acc) -> (C - $0) * Acc.


form_string(W, Len, [_H | NewString] = String) when W < Len ->
  Word = string:substr(String, 1, W),
  [Word | form_string(W, Len - 1, NewString)];
form_string(_W, _Len, String) ->
  [String].



main() ->
  io:format("~p~n", [lsp("1234a5", 2)]).