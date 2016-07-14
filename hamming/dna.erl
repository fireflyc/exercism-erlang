-module(dna).
-export([hamming_distance/2]).

-spec hamming_distance(string(), string()) -> integer().

hamming_distance(S1, S2) -> hamming_distance_one(S1, S2, 0).
		
hamming_distance_one([H|T1], [H|T2], Count) -> hamming_distance_one(T1, T2, Count);
	
hamming_distance_one([_|T1], [_|T2], Count) -> hamming_distance_one(T1, T2, Count+1);

hamming_distance_one([], [], Count) -> Count.


	