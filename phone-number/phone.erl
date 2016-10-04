-module(phone).
-export([number/1, areacode/1, pretty_print/1]).

convert_number(Number, Acc) ->
  case re:run(Number, "^[0-9]") of
    nomatch ->
      Acc;
    {match, _} ->
      [Number] ++ Acc
  end.

number(PhoneNumber) ->
  PhoneNumber1 = re:replace(PhoneNumber, "\\D", "", [global, {return, list}]),
  Len = string:len(PhoneNumber1),
  First = string:left(PhoneNumber1, 1),
  if
    Len == 10 ->
      PhoneNumber1;
    Len > 10 andalso (First =:= "1") ->
      number(string:substr(PhoneNumber1, 2));
    true ->
      "0000000000"
  end.

areacode(PhoneNumber) ->
  PhoneNumber1 = number(PhoneNumber),
  string:left(PhoneNumber1, 3).

pretty_print(PhoneNumber) ->
  PhoneNumber1 = number(PhoneNumber),
  "(" ++ string:left(PhoneNumber1, 3) ++ ") " ++ string:substr(PhoneNumber1, 3, 3)
    ++ "-" ++ string:substr(PhoneNumber1, 6).