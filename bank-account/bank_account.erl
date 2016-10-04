-module(bank_account).
-author("fireflyc").

%% API
-export([create/0, balance/1, charge/2, close/1, deposit/2, withdraw/2]).

balance(Pid) -> rpc(Pid, balance, 0).

charge(Pid, Amount) when Amount > 0 -> rpc(Pid, charge, Amount);
charge(_Pid, _Amount) -> 0.

close(Pid) -> rpc(Pid, close, 0).

deposit(Pid, Amount) when Amount > 0 -> Pid ! {deposit, Amount};
deposit(_Pid, _Amount) -> ok.

withdraw(Pid, Amount) when Amount > 0 -> rpc(Pid, withdraw, Amount);
withdraw(_Pid, _Amount) -> 0.


create() ->
  erlang:spawn(fun() -> loop(0) end).

loop(Balance) ->
  receive
    {balance, _Argument, Pid} ->
      Pid ! {balance, Balance},
      loop(Balance);
    {charge, Amount, Pid} ->
      Charge = loop_charge(Balance, Amount),
      Pid ! {charge, Charge},
      loop(Balance - Charge);
    {close, _Argument, Pid} ->
      Pid ! {close, Balance};
    {deposit, Amount} ->
      loop(Balance + Amount);
    {withdraw, Amount, Pid} ->
      Withdraw = erlang:min(Balance, Amount),
      Pid ! {withdraw, Withdraw},
      loop(Balance - Withdraw)
  end.

loop_charge(Balance, Amount) when Balance > Amount ->
  Amount;
loop_charge(_Balance, _Amount) ->
  0.

rpc(Pid, Do, Argument) ->
  rpc_loop(is_process_alive(Pid), Pid, Do, Argument).

rpc_loop(true, Pid, Do, Argument) ->
  Pid ! {Do, Argument, self()},
  receive
    {Do, Answer} -> Answer
  end;
rpc_loop(false, _Pid, _Do, _Argument) ->
  {error, account_closed}.