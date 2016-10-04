-module(word_count).
-author("fireflyc").

%% API
-export([count/1, main/0]).

count(String) ->
  {_, Pattern} = re:compile("[^'a-zA-Z0-9]+", [unicode]),
  Words = re:split(String, Pattern, [{return, list}]),

  ShuffleMap = lists:foldl(fun(Word, WordCountMap) -> dict:update_counter(string:to_lower(Word), 1, WordCountMap) end,
    dict:new(), Words),
  dict:filter(fun(Key, _) -> Key =/= "" end, ShuffleMap).

main() ->
  io:format("~p~n", [orddict:from_list(dict:to_list(count("go Go GO")))]).
%io:format("~p~n", [orddict:from_list(dict:to_list(count("hey,my_spacebar_is_broken.")))]),
%io:format("~p~n", [orddict:from_list(dict:to_list(count("testing, 1, 2 testing")))]),
%io:format("~p~n", [orddict:from_list(dict:to_list(count("car : carpet as java : javascript!!&@$%^&")))]).
