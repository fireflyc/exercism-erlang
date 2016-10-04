-module(zipper).
-author("fireflyc").

%% API
-export([new_tree/3, empty/0, left/1, right/1, up/1, value/1, set_left/2, set_right/2, set_value/2, to_tree/1,
  from_tree/1, main/0]).

-record(tree, {value, left, right}).

%%囧 trail
-record(zipper, {value, left, right, trail}).

new_tree(Value, Left, Right) ->
  #tree{value = Value, left = Left, right = Right}.

empty() ->
  nil.

left(#zipper{left = nil}) -> nil;
left(Zipper = #zipper{}) ->
  Next = Zipper#zipper.left,
  #zipper{value = Next#tree.value, left = Next#tree.left, right = Next#tree.right,
    trail = [{left, Zipper#zipper.value, Zipper#zipper.right} | Zipper#zipper.trail]}.

right(#zipper{right = nil}) -> nil;
right(Zipper = #zipper{}) ->
  Next = Zipper#zipper.right,
  #zipper{value = Next#tree.value, left = Next#tree.left, right = Next#tree.right,
    trail = [{right, Zipper#zipper.value, Zipper#zipper.left} | Zipper#zipper.trail]}.

value(#zipper{value = V}) -> V.

set_value(Zipper = #zipper{}, V) -> Zipper#zipper{value = V}.

set_left(Zipper = #zipper{}, L) -> Zipper#zipper{left = L}.

set_right(Zipper = #zipper{}, R) -> Zipper#zipper{right = R}.

up(#zipper{trail = []}) -> empty();
up(Zipper = #zipper{trail = [{left, V, R} | T]}) ->
  #zipper{value = V, left = new_tree(Zipper#zipper.value, Zipper#zipper.left, Zipper#zipper.right), right = R, trail = T};
up(Zipper = #zipper{trail = [{right, V, L} | T]}) ->
  #zipper{value = V, left = L, right = new_tree(Zipper#zipper.value, Zipper#zipper.left, Zipper#zipper.right), trail = T}.

to_tree(Zipper = #zipper{trail = [_ | _]}) -> to_tree(up(Zipper));
to_tree(Zipper) ->
  new_tree(Zipper#zipper.value, Zipper#zipper.left, Zipper#zipper.right).

from_tree(Tree) ->
  #zipper{value = Tree#tree.value, left = Tree#tree.left, right = Tree#tree.right, trail = []}.

bt(V, L, R) -> zipper:new_tree(V, L, R).
leaf(V) -> zipper:new_tree(V, empty(), empty()).

t1() -> bt(1, bt(2, empty(), leaf(3)), leaf(4)).
main() ->
  io:format("~p~n", [up(from_tree(t1()))]).