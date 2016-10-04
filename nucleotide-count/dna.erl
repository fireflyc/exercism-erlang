-module(dna).
-export([count/2, nucleotide_counts/1]).

-spec count(string(), string()) -> non_neg_integer().
-spec nucleotide_counts(string()) -> map().

count(Dna, N) ->
  check(N),
  lists:foldl(
    fun(X, Sum) ->
      case [X] =:= N of
        true -> 1 + Sum;
        false -> Sum
      end
    end,
    0, Dna).

check(N) ->
  case lists:member(N, ["A", "T", "C", "G"]) of
    true -> true;
    _ -> erlang:error("Invalid nucleotide")
  end.

nucleotide_counts(Dna) ->
  [{"A", count(Dna, "A")}, {"T", count(Dna, "T")}, {"C", count(Dna, "C")}, {"G", count(Dna, "G")}].