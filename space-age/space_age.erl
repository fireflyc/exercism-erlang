-module(space_age).
-export([ageOn/2]).

-spec ageOn(atom(), integer()) -> float().

planetTable() ->
	#{earth => 1, mercury => 0.2408467, venus => 0.61519726, mars => 1.8808158, 
					jupiter => 11.862615, saturn => 29.447498, uranus => 84.016846, neptune => 164.79132}.
	
ageOn(Planet, Seconds) ->
	Seconds / secondsPerYear(Planet).

secondsPerYear(Planet) ->
	(365.25 * 24 * 60 * 60) * maps:get(Planet, planetTable()).
	