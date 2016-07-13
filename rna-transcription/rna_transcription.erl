-module(rna_transcription).
-export([to_rna/1]).

-spec to_rna(string()) -> string().
	
to_rna(DNA) ->
	lists:map(fun to_rna_one/1, DNA).

to_rna_one(DNA_ONE) ->
	case DNA_ONE of
		$G ->
			$C;
		$C ->
			$G;
		$T ->
			$A;
		$A ->
			$U;
		_ELSE ->
			$0
	end.
	
	