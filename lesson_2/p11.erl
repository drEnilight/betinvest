-module(p11).
-export([encode_modified/1]).

encode_modified(List) ->
  p05:reverse(encode_modified(List, [])).

encode_modified([], Acc) ->
  Acc;
encode_modified([H|T], [{Count, H}|Tail]) ->
  encode_modified(T, [{Count+1, H}|Tail]);
encode_modified([H|T], [H|Tail]) ->
  encode_modified(T, [{2,H}|Tail]);
encode_modified([H|T], Acc) ->
  encode_modified(T, [H|Acc]).
