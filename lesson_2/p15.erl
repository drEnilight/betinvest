-module(p15).
-export([replicate/2]).

replicate(List, Count) ->
  EncodedList = p05:reverse(encode(List, Count, [])),
  p13:decode(EncodedList).

encode([], _, Acc) ->
  Acc;
encode([H|T], Count, Acc) ->
  encode(T, Count, [{Count, H}|Acc]).
