-module(parallel_letter_frequency).
-author("fireflyc").

%% API
-export([dict/1, main/0]).

start_task(Sentence) ->
  MyPid = self(),
  spawn(fun() -> MyPid ! {self(), frequency(Sentence)} end).

join_task(Pid) ->
  receive
    {Pid, Dict} -> Dict
  end.

dict(List) ->
  PidList = [start_task(X) || X <- List],
  Dicts = [join_task(X) || X <- PidList],
  merge_dicts(Dicts).

merge_dicts([Dict | Dicts]) ->
  lists:foldl(fun merge_dicts/2, Dict, Dicts).

merge_dicts(Dict, Acc) -> dict:merge(fun merge_dicts/3, Dict, Acc).

merge_dicts(_Key, Value, Acc_value) -> Value + Acc_value.
frequency(Sentence) ->
  lists:foldl(fun(X, Acct) -> dict:update_counter(X, 1, Acct) end, dict:new(), Sentence).

main() ->
  io:format("~p~n", [dict(["asd", "asd"])]).