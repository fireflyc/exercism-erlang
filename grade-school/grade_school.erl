-module(grade_school).

%% API
-export([add/3, get/2, sort/1, new/0]).

add(Name, Grade, School) ->
  case get(Grade, School) of
    [] ->
      orddict:store(Grade, [Name], School);
    Class ->
      orddict:store(Grade, ordsets:add_element(Name, Class), School)
  end.

get(Grade, Students) ->
  case orddict:find(Grade, Students) of
    {ok, Class} -> Class;
    _ -> []
  end.

sort(S) ->
  S.

new() ->
  [].