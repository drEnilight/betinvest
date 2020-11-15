-module(p13).
-export([decode/1]).

decode(List) ->
  p05:reverse(decode(List, [])).

decode([], Acc) ->
  Acc;
decode([{1, H}|T], Acc) ->
  decode(T, [H|Acc]);
decode([{Count, H}|T], Acc) ->
  decode([{Count-1, H}|T], [H|Acc]).
