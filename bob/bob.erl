-module(bob).
-export([response_for/1]).

-spec response_for(string()) -> string().

response_for(Str) -> 
	case is_space(Str) of
		true -> "Fine. Be that way!";
		false -> 
			case is_shouting(Str) of
				true -> "Whoa, chill out!";
				false ->
					case is_question(Str) of
						true -> "Sure.";
						false -> "Whatever."
					end
			end
	end.

is_shouting(Str) ->
  lists:any(fun (C) -> C >= $A andalso C =< $Z end, Str) andalso
  string:to_upper(Str) =:= Str.

is_question(Str) ->
  lists:last(Str) =:= $?.

is_space(Str) -> 
	re:run(Str, "^(\\h|\\v)*$", [unicode]) =/= nomatch.