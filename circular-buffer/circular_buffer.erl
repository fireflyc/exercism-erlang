-module(circular_buffer).
-author("fireflyc").

%% API
-export([create/1, read/1, size/1, write/2, write_attempt/2]).

create(MaxSize) ->
  spawn(fun() -> loop(0, MaxSize, queue:new()) end).

rpc(Pid, Request) ->
  Pid ! {Request, self()},
  receive
    {_, Data} ->
      Data
  end.

write(Pid, Item) ->
  rpc(Pid, {write, Item}).

read(Pid) ->
  rpc(Pid, read).

size(Pid) ->
  rpc(Pid, size).

write_attempt(Pid, Item) ->
  rpc(Pid, {write_attempt, Item}).

circular_write(Size, MaxSize, Item, Queue) when Size < MaxSize ->
  {Size + 1, queue:in(Item, Queue)};
circular_write(MaxSize, MaxSize, Item, Queue) ->
  {_Old, NewQueue} = queue:out(Queue),
  {MaxSize, queue:in(Item, NewQueue)}.

loop(Size, MaxSize, Queue) ->
  receive
    {size, Pid} ->
      Pid ! {size, {ok, MaxSize}},
      loop(Size, MaxSize, Queue);
    {read, Pid} ->
      case Size =:= 0 of
        true ->
          Pid ! {read, {error, empty}},
          loop(Size, MaxSize, Queue);
        false ->
          {{_, Item}, NewQueue} = queue:out(Queue),
          Pid ! {read, {ok, Item}},
          loop(Size - 1, MaxSize, NewQueue)
      end;
    {{write, Item}, Pid} ->
      {NewSize, NewQueue} = circular_write(Size, MaxSize, Item, Queue),
      Pid ! {write, ok},
      loop(NewSize, MaxSize, NewQueue);
    {{write_attempt, Item}, Pid} ->
      case Size =:= MaxSize of
        true ->
          Pid ! {write_attempt, {error, full}},
          loop(Size, MaxSize, Queue);
        false ->
          {NewSize, NewQueue} = circular_write(Size, MaxSize, Item, Queue),
          Pid ! {write_attempt, ok},
          loop(NewSize, MaxSize, NewQueue)
      end
  end.
