-module(atbash_cipher).
-export([encode/1, decode/1]).
-spec encode(string()) -> string().
-spec decode(string()) -> string().


encode_char(C) when C >= $A, C =< $Z ->
    {true, $Z - C + $a};
encode_char(C) when C >= $a, C =< $z ->
    {true, $z - C + $a};
encode_char(C) when C >= $0, C =< $9 ->
    {true, C};
encode_char(_C) ->
    false.
	
chunk("", Acc) ->
	Acc;
chunk(Ch, Acc) ->
	chunk_encode(encode_char(Ch), Acc).
	
chunk_encode(false, Acc) ->
	Acc;
chunk_encode({true, Ch}, Acc) ->
	case Acc of
		{5, AccList} ->
			{1, [Ch, 32] ++ AccList};
		{C, AccList} ->
			{C + 1, [Ch] ++ AccList}
	end.
	
encode(OriginalStr) ->
	{_, AccList} = lists:foldl(fun chunk/2, {0, []}, OriginalStr),
	lists:reverse(AccList).
	
decode(OriginalStr) ->
	lists:filtermap(fun encode_char/1, OriginalStr).

