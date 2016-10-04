-module(series).
-author("fireflyc").

%% API
-export([from_string/2, main/0]).


from_string(W, String) ->
  Len = string:len(String),
  form_string(W, Len, String).

form_string(W, Len, [_H | NewString] = String) when W < Len ->
  Word = string:substr(String, 1, W),
  [Word | form_string(W, Len - 1, NewString)];
form_string(_W, _Len, String) ->
  [String].

main() ->
  io:format("~w~n", [from_string(3, "01234")]).