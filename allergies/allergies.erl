-module(allergies).
-author("fireflyc").

%% API
-export([allergies/1, is_allergic_to/2, main/0]).
-define(ALLERGIES_LIST, ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats']).

allergies(N) ->
  lists:filter(fun(X) -> is_allergic_to(X, N) end, ?ALLERGIES_LIST).

is_allergic_to(X, N) ->
  Index = string:str(?ALLERGIES_LIST, [X]),
  (N band trunc(math:pow(2, Index-1))) > 0.0.

indexOf(A, Allergies) ->
  index(0, Allergies, A).

index(Index, [A | _], A) ->
  Index;
index(Index, [_ | Allergies], A) ->
  index(Index + 1, Allergies, A);
index(_, [], _) ->
  not_found.


main() ->
  io:format("~p~n", [allergies:allergies(1)]).