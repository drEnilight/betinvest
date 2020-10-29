-module(p12).
-export([decode_modified/1]).

decode_modified(List) ->
  p05:reverse(decode_modified(List, [])).

decode_modified([], Acc) ->
  Acc;
decode_modified([{1, H}|T], Acc) ->
  decode_modified(T, [H|Acc]);
decode_modified([{Count, H}|T], Acc) ->
  decode_modified([{Count-1, H}|T], [H|Acc]);
decode_modified([H|T], Acc) ->
  decode_modified(T, [H|Acc]).
