-module(gigasecond).
-author("fireflyc").

%% API
-export([from/1]).

from({Y, M, D}) ->
  from({{Y, M, D}, {0, 0, 0}});

from(DateTime) ->
  Seconds = calendar:datetime_to_gregorian_seconds(DateTime),
  calendar:gregorian_seconds_to_datetime(Seconds + 1000000000).
