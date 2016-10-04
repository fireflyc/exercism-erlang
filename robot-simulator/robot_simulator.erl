-module(robot_simulator).

%% API
-export([create/0, direction/1, position/1, place/3, left/1, right/1, advance/1, control/2]).

-record(robot, {x, y, direction}).

create() ->
  erlang:spawn(fun() -> loop(#robot{x = undefined, y = undefined, direction = undefined}) end).

loop(Robot) ->
  receive
    {advance, Pid} ->
      {X, Y} = next_position(Robot#robot.direction, {Robot#robot.x, Robot#robot.y}),
      NewRobot = #robot{x = X, y = Y, direction = Robot#robot.direction},
      Pid ! {advance, NewRobot},
      loop(NewRobot);
    {direction, Pid} ->
      Pid ! {direction, Robot#robot.direction},
      loop(Robot);
    {position, Pid} ->
      Pid ! {position, {Robot#robot.x, Robot#robot.y}},
      loop(Robot);
    {turn, Turn, Pid} ->
      NewRobot = turn(Robot, Turn),
      Pid ! {turn, NewRobot},
      loop(NewRobot);
    {place, {{X, Y}, Direction}, Pid} ->
      NewRobot = #robot{x = X, y = Y, direction = Direction},
      Pid ! {place, NewRobot},
      loop(NewRobot)
  end.

rpc(Robot, RequestTag, RequestBody) ->
  Robot ! {RequestTag, RequestBody, self()},
  receive
    {RequestTag, Response} -> Response
  end.
rpc(Robot, RequestTag) ->
  Robot ! {RequestTag, self()},
  receive
    {RequestTag, Response} -> Response
  end.

direction(Robot) ->
  rpc(Robot, direction).

place(Robot, Direction, Position) ->
  rpc(Robot, place, {Position, Direction}).

left(Robot) ->
  rpc(Robot, turn, left).

right(Robot) ->
  rpc(Robot, turn, right).

advance(Robot) ->
  rpc(Robot, advance).

position(Robot) ->
  rpc(Robot, position).

control(Robot, Cmd) ->
  lists:map(fun(X) -> case X of
                        $A ->
                          advance(Robot);
                        $L ->
                          left(Robot);
                        $R ->
                          right(Robot);
                        _ ->
                          []
                      end
            end, Cmd).

turn(Robot, LeftOrRight) ->
  #robot{x = Robot#robot.x, y = Robot#robot.y, direction = next_direction(Robot#robot.direction, LeftOrRight)}.

next_direction(north, right) -> east;
next_direction(south, right) -> west;
next_direction(east, right) -> south;
next_direction(west, right) -> north;
next_direction(north, left) -> west;
next_direction(south, left) -> east;
next_direction(east, left) -> north;
next_direction(west, left) -> south.

next_position(north, {X, Y}) -> {X, Y + 1};
next_position(south, {X, Y}) -> {X, Y - 1};
next_position(east, {X, Y}) -> {X + 1, Y};
next_position(west, {X, Y}) -> {X - 1, Y}.
