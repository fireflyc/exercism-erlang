-module(beer_song).
-author("fireflyc").

%% API
-export([verse/1, sing/1, sing/2, main/0]).

verse(0) ->
  "No more bottles of beer on the wall, no more bottles of beer.\n"
  "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
verse(1) ->
  "1 bottle of beer on the wall, 1 bottle of beer.\n"
  "Take it down and pass it around, no more bottles of beer on the wall.\n";
verse(2) ->
  "2 bottles of beer on the wall, 2 bottles of beer.\n"
  "Take one down and pass it around, 1 bottle of beer on the wall.\n";
verse(N) ->
  io_lib:format("~p bottles of beer on the wall, ~p bottles of beer.\n", [N, N]) ++
  io_lib:format("Take one down and pass it around, ~p bottles of beer on the wall.\n", [N - 1]).

sing(N1) ->
  sing(N1, 0).
sing(N1, N1) ->
  verse(N1)++"\n";
sing(N1, N2) ->
  verse(N1) ++ "\n" ++ sing(N1-1, N2).

main() ->
  io:format("~s~n", [sing(8, 6)]).